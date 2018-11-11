module friedice(input[31:0] data_in,
                output reg[31:0] data_out,
                output data_out_enable,
                output reg[3:0] mem_mask,
                output not_writing,
                output[23:0] addr_out,
                input clock, input reset
`ifndef NO_ALLSTATE
                , output[320:0] allstate
`endif
);
   parameter[31:0] HART_ID = 0;
   parameter[31:0] STARTING_PC = 0;

`ifndef LONG_PC
   reg [23:2] pc, tsugi_no_pc;
   reg [23:2] pc_plus_one;
`else
   reg [31:2] pc, tsugi_no_pc;
   reg [31:2] pc_plus_one;
`endif
   
   reg[31:0]   instruction;
   reg         instruction_valid, mem_access_aligned;
`ifndef NO_JUMP_ALIGN_CHECK
   reg jump_misaligned;
`endif
   wire [4:0]  rs1 = instruction[19:15];
   wire [4:0]  rs2 = instruction[24:20];
   wire [4:0]  rd = instruction[11:7];
   wire [6:2]  opcode = instruction[6:2];
   wire [2:0]  funct3 = instruction[14:12];
   wire [6:0]  funct7 = instruction[31:25];
   wire [31:0] imm12 = {{20{instruction[31]}}, instruction[31:20]};

   wire [31:0] source1;
   wire [31:0] source2;
   reg [31:0]  data_from_memory, written_to_csr;
   reg [31:0] result;
   
   reg [63:0] ctr_cycle;
   reg [63:0] ctr_instret;

   reg     load_needed;
   reg     store_needed;
   wire [31:0] load_addr = source1 + imm12;
   wire [31:0] store_addr = source1 + {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};

   assign addr_out = load_needed ? load_addr[23:0] : store_needed ? store_addr[23:0] : {tsugi_no_pc[23:2], 2'b00};
   assign data_out_enable = store_needed && !load_needed;
   assign not_writing = !data_out_enable;
   
   wire        enable_rs1 = 1; // TODO: optimize this more
//opcode[4:2] != 3'b 101 && {opcode[6:5],opcode[2]} != 3'b 111;
   wire    enable_rs2 = enable_rs1 && opcode[6:2] < 5'b 11001;
   wire    enable_rd = (opcode[6:3] != 4'b 0100 && opcode[6:2] != 5'b 11000) && !load_needed && !store_needed && mem_access_aligned;

   reg [4:0] csr_mcause;
   reg [31:0] csr_mscratch, csr_mtval;
`ifndef LONG_PC
   reg [23:2] csr_mepc, csr_mtvec;
`else
   reg [31:2] csr_mepc, csr_mtvec;
`endif
   reg        csr_mie, csr_mip;
   reg        st_mxr, st_mprv, st_mpp, st_mpie, st_mie;
   reg        priv;
   reg        cen_cycles, cen_instret;

   register_file regs(.rrd1(rs1),
                      .rrd2(rs2),
                      .rwr(rd),
                      .rd1(source1),
                      .rd2(source2),
                      .wr(result),
                      .rd1en(enable_rs1),
                      .rd2en(enable_rs2),
                      .wren(enable_rd),
                      .clock(clock));
   
   reg     should_branch, trapping;

   always @(posedge clock or negedge reset) begin
      if(!reset) begin
         csr_mcause = 0;
         ctr_cycle <= 0;
         priv = 1;
         st_mie = 0;
         st_mprv = 0;
         trapping = 1;
         pc = STARTING_PC >> 2;
      end else begin
         trapping = 0;
         if(!instruction_valid) begin
            if(data_in[6:2] == 5'b 11100) begin
               case({data_in[31:20],data_in[14:12]})
                 15'b 000000000000_000:
                   csr_mcause = priv ? 11 : 8; // environment call
                 15'b 000000000001_000:
                   csr_mcause = 3; // breakpoint
                 default:
                   csr_mcause = 2; // illegal instruction
               endcase
            end else begin
               csr_mcause = 2; // illegal instruction
            end
            trapping = 1;
            csr_mtval = data_from_memory;
`ifndef NO_JUMP_ALIGN_CHECK
         end else if(jump_misaligned) begin
            csr_mcause = 0; // Instruction address misaligned
            csr_mtval = {tsugi_no_pc, 2'b10};
            trapping = 1;
`endif
         end else if(load_needed) begin
            if(!mem_access_aligned) begin
               csr_mcause = 4; // load address misaligned
               csr_mtval = load_addr;
               trapping = 1;
            end
         end else if(store_needed) begin
            if(!mem_access_aligned) begin
               csr_mcause = 6; // store address misaligned
               csr_mtval = store_addr;
               trapping = 1;
            end
         end else begin
            case(opcode[6:2])
              5'b 11100: begin
                 // SYSTEM
                 case(funct3)
                   1, 2, 3, 5, 6, 7: begin
                      case(instruction[31:20])
                        //// Machine
                        // mstatus
                        12'h 300: begin
                           st_mxr = written_to_csr[19];
                           st_mprv = written_to_csr[17];
                           st_mpp = written_to_csr[12];
                           st_mpie = written_to_csr[7];
                           st_mie = written_to_csr[3];
                        end
                        // mie (interrupt enable)
                        12'h 304: csr_mie = written_to_csr;
                        // mtvec (trap handler base address)
`ifndef LONG_PC
                        12'h 305: csr_mtvec = written_to_csr[23:2];
`else
                        12'h 305: csr_mtvec = written_to_csr[31:2];
`endif
                        // mcounteren (counter enable)
                        12'h 306: begin
                           cen_instret = written_to_csr[2];
                           cen_cycles = written_to_csr[0];
                        end
                        // mscratch
                        12'h 340: csr_mscratch = written_to_csr;
                        // mepc
`ifndef LONG_PC
                        12'h 341: csr_mepc = written_to_csr[23:2];
`else
                        12'h 341: csr_mepc = written_to_csr[31:2];
`endif
                        // mcause
                        12'h 342: csr_mcause = {written_to_csr[31], written_to_csr[3:0]};
                        // mtval (bad address or instruction)
                        12'h 343: csr_mtval = written_to_csr;
                        // mip (interrupt pending)
                        12'h 344: csr_mip = written_to_csr;
                      endcase
                   end
                   0: begin
                      // the only other system instruction that is currently
                      // allowed is MRET, and privilege will already have been
                      // checked if we get this far
                      // TODO: WFI
                      st_mie = st_mpie;
                      st_mpie = 1;
                      priv = st_mpp;
                      st_mpp = 0;
                   end
                 endcase
              end
            endcase
            if(cen_instret)
              ctr_instret = ctr_instret + 1;
         end
         if(trapping) begin
            st_mpie = st_mie;
            st_mie = 0;
            st_mpp = priv;
            priv = 1;
            csr_mepc = pc;
            pc = csr_mtvec;
         end else if(!load_needed && !store_needed) begin
            pc = tsugi_no_pc;
         end
         if(cen_cycles)
           ctr_cycle <= ctr_cycle + 1;
      end
   end
   
   always @(negedge clock) begin
      pc_plus_one = pc + 1;
      if(!reset || trapping) begin
         load_needed <= 0;
         store_needed <= 0;
         mem_access_aligned = 1;
         // NOP!
         instruction = 32'b 000000000000_00000_000_00000_0010011;
         instruction_valid = 1;
         mem_mask = 4'b 1111;
      end else begin
         if(load_needed) begin
            case(funct3[1:0])
              2'b 00: begin // byte
                 case(load_addr[1:0])
                   0:
                     data_from_memory = {{funct3[2] ? 24'd 0 : {24{data_in[7]}}},
                                         data_in[7:0]};
                   1:
                     data_from_memory = {{funct3[2] ? 24'd 0 : {24{data_in[15]}}},
                                         data_in[15:8]};
                   2:
                     data_from_memory = {{funct3[2] ? 24'd 0 : {24{data_in[23]}}},
                                         data_in[23:16]};
                   3:
                     data_from_memory = {{funct3[2] ? 24'd 0 : {24{data_in[31]}}},
                                         data_in[31:24]};
                 endcase
                 mem_mask = {load_addr[1:0] != 3,
                             load_addr[1:0] != 2,
                             load_addr[1:0] != 1,
                             load_addr[1:0] != 0};
                 mem_access_aligned = 1;
              end
              2'b 01: begin // halfword
                 case(load_addr[1:0])
                   0: begin
                     data_from_memory = {{funct3[2] ? 16'd 0 : {16{data_in[15]}}},
                                         data_in[15:0]};
                      mem_mask = 4'b 1100;
                   end
                   2: begin
                     data_from_memory = {{funct3[2] ? 16'd 0 : {16{data_in[31]}}},
                                         data_in[31:16]};
                      mem_mask = 4'b 0011;
                   end
                   default: begin
                      data_from_memory = 32'b XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;
                      mem_mask = 4'b XXXX;
                   end
                 endcase
                 mem_access_aligned = (load_addr[0] == 0);
              end
              2'b 10: begin // fullword
                 case(load_addr[1:0])
                   0: begin
                      data_from_memory = data_in;
                      mem_mask = 4'b 0000;
                   end
                   default: begin
                      data_from_memory = 32'b XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;
                      mem_mask = 4'b XXXX;
                   end
                 endcase
                 mem_access_aligned = (load_addr[1:0] == 0);
              end
              2'b 11: begin // doubleword (illegal)
                 // has already been trapped
                 mem_access_aligned = 1'b X;
                 data_from_memory = 32'b XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;
                 mem_mask = 4'b XXXX;
              end
            endcase
            load_needed <= !mem_access_aligned;
         end else if(store_needed) begin
            case(funct3[1:0])
              2'b 00: begin // byte
                 data_out = {source2[7:0],source2[7:0],
                             source2[7:0],source2[7:0]};
                 mem_mask = {store_addr[1:0] != 3,
                             store_addr[1:0] != 2,
                             store_addr[1:0] != 1,
                             store_addr[1:0] != 0};
                 mem_access_aligned = 1;
              end
              2'b 01: begin // halfword
                 if(store_addr[0]) begin
                    data_out = 32'b XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;
                    mem_mask = 4'b 1111;
                    mem_access_aligned = 0;
                 end else begin
                    data_out = {source2[15:0],source2[15:0]};
                    mem_mask = {store_addr[1] != 1,
                                store_addr[1] != 1,
                                store_addr[1] != 0,
                                store_addr[1] != 0};
                    mem_access_aligned = 1;
                 end
              end
              2'b 10: begin // fullword
                 if(store_addr[1:0]) begin
                    data_out = 32'b XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;
                    mem_mask = 4'b 1111;
                    mem_access_aligned = 0;
                 end else begin
                    data_out = source2;
                    mem_mask = 4'b 0000;
                    mem_access_aligned = 1;
                 end
              end
              2'b 11: begin // doubleword (illegal)
                 data_out = 32'b XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;
                 mem_mask = 4'b XXXX;
                 mem_access_aligned = 1'b X;
                 // has already been trapped
              end
            endcase
            store_needed <= !mem_access_aligned;
         end else begin
            mem_access_aligned = 1;
            mem_mask = 4'b 0000;
            if(data_in[1:0] == 3) begin
               case(data_in[6:2])
                 5'b 00000: instruction_valid = data_in[13:12] != 3; // LOAD
                 5'b 00011: instruction_valid = data_in[14:13] == 0; // MISC-MEM
                 5'b 00100: instruction_valid = 1; // OP-IMM
                 5'b 00101: instruction_valid = 1; // AUIPC
                 5'b 01000: instruction_valid = 1; // STORE
                 5'b 01100: instruction_valid = 1; // OP
                 5'b 01101: instruction_valid = 1; // LUI
                 5'b 11000: instruction_valid = data_in[14:13] != 1; // BRANCH
                 5'b 11001: instruction_valid = 1; // JALR
                 5'b 11011: instruction_valid = 1; // JAL
                 5'b 11100: begin // SYSTEM
                    instruction_valid = data_in[13:12] != 0 ? (priv || data_in[29:28] == 0) : (priv && data_in[31:20] == 12'b 001100000010 && data_in[11:7] == 5'b 00000);
                 end
                 default: instruction_valid = 0;
               endcase
            end else begin
               instruction_valid = 0;
            end
            if(instruction_valid) begin
               instruction = data_in;
               data_from_memory = 32'b XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;
               load_needed <= data_in[6:2] == 5'b 00000;
               store_needed <= data_in[6:2] == 5'b 01000;
            end else begin
               // load instruction register with a NOP
               instruction = 32'b 000000000000_00000_000_00000_0010011;
               // save the bad bits in data_from_memory to transfer to csr_mtval
               data_from_memory = instruction;
               load_needed <= 0;
               store_needed <= 0;
            end
         end
      end
   end

   always @(*) begin
`ifndef NO_JUMP_ALIGN_CHECK
      jump_misaligned <= 0;
`endif
      if(trapping || !reset) begin
         tsugi_no_pc <= pc;
      end else begin
         case(opcode[6:2])
           5'b 00000: result <= data_from_memory; // LOAD
           5'b 00011: /* bug: FENCE will clobber a non-zero d register, leaking data */result <= 0; // MISC-MEM
           5'b 00100: begin // OP-IMM
              case(funct3)
                // ADDI (and SUBI)
                3'b 000: result <= source1 + imm12;
                // SLLI
                3'b 001: result <= source1 << instruction[24:20];
                // SLTI
                3'b 010: result <= $signed(source1) < $signed(imm12);
                // SLTIU
                3'b 011: result <= source1 < imm12;
                // XORI
                3'b 100: result <= source1 ^ imm12;
                // SRLI/SRAI
                3'b 101: begin
                   if(instruction[30])
                     result <= $signed(source1) >>> instruction[24:20];
                   else
                     result <= source1 >> instruction[24:20];
                end
                // ORI
                3'b 110: result <= source1 | imm12;
                // ANDI
                3'b 111: result <= source1 & imm12;
              endcase
           end
           5'b 00101: begin // AUIPC
              result <= {pc, 2'b 00} + {instruction[31:12], 12'd 0};
           end
           5'b 01000: result <= 32'b XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; // STORE
           5'b 01100: begin // OP
              case(funct3)
                // ADD (and SUB)
                3'b 000: begin
                   if(instruction[30])
                     result <= source1 - source2;
                   else
                     result <= source1 + source2;
                end
                // SLL
                3'b 001: result <= source1 << source2[4:0];
                // SLT
                3'b 010: result <= $signed(source1) < $signed(source2);
                // SLTU
                3'b 011: result <= source1 < source2;
                // XOR
                3'b 100: result <= source1 ^ source2;
                // SRL/SRA
                3'b 101: begin
                   if(instruction[30])
                     result <= $signed(source1) >>> source2[4:0];
                   else
                     result <= source1 >> source2[4:0];
                end
                // OR
                3'b 110: result <= source1 | source2;
                // AND
                3'b 111: result <= source1 & source2;
              endcase
           end
           5'b 01101: result <= {instruction[31:12], 12'd 0}; // LUI
           5'b 11000: result <= 32'b XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; // BRANCH
           5'b 11001: result <= {pc_plus_one, 2'b 00}; // JALR
           5'b 11011: result <= {pc_plus_one, 2'b 00}; // JAL
           5'b 11100: begin // SYSTEM
              case(funct3)
                1, 2, 3, 5, 6, 7: begin
                   case(instruction[31:20])
                     //// User
                     // cycle
                     12'h C00: result <= ctr_cycle[31:0];
                     // time
                     12'h C01: result <= 0;
                     // instret
                     12'h C02: result <= ctr_instret[31:0];
                     // cycleh
                     12'h C80: result <= ctr_cycle[63:32];
                     // timeh
                     12'h C81: result <= 0;
                     // instreth
                     12'h C82: result <= ctr_instret[63:32];
                     // ustatus
                     12'h 000: result <= 0;
                     // (floating point registers go here)
                     //// Machine
                     // mvendorid
                     12'h F11: result <= 0; // non-commercial implementation
                     // marchid
                     12'h F12: result <= 0; // TODO: get an archid
                     // mimpid
                     12'h F13: result <= 0;
                     // mhartid
                     12'h F14: result <= HART_ID;
                     // mstatus
                     12'h 300: result <= {12'd 0, st_mxr, 1'b 0, st_mprv, 4'd 0,
                                          {2{st_mpp}}, 3'd 0, st_mpie, 3'd 0,
                                          st_mie, 3'd 0};
                     // misa
                     // TODO: set the 'X' bit when we add CAS
                     12'h 301: result <= 32'b 01_0000_00000100000000000100000000;
                     // medeleg (exception delegation)
                     //12'h 302: result <= 32'b XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;
                     // mideleg (interrupt delegation)
                     //12'h 303: result <= 32'b XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;
                     // mie (interrupt enable)
                     12'h 304: result <= csr_mie;
                     // mtvec (trap handler base address)
                     12'h 305: result <= {csr_mtvec, 2'b 00};
                     // mcounteren (counter enable)
                     12'h 306: result <= {29'd 0, cen_instret, 1'd 0, cen_cycles};
                     // mscratch
                     12'h 340: result <= csr_mscratch;
                     // mepc
                     12'h 341: result <= {csr_mepc, 2'b00};
                     // mcause
                     12'h 342: result <= {csr_mcause[4], 27'b 0, csr_mcause[3:0]};
                     // mtval (bad address or instruction)
                     12'h 343: result <= csr_mtval;
                     // mip (interrupt pending)
                     12'h 344: result <= csr_mip;
                     default: result <= 32'b XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;
                   endcase
                   case(funct3)
                     3'b 000, 3'b 100: written_to_csr <= 32'b XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;
                     3'b 001: begin // CSRRW
                        written_to_csr <= source1;
                     end
                     3'b 010: begin // CSRRS
                        written_to_csr <= result | source1;
                     end
                     3'b 011: begin // CSRRC
                        written_to_csr <= result & ~source1;
                     end
                     3'b 101: begin // CSRRWI
                        written_to_csr <= {27'b 0, rs1};
                     end
                     3'b 110: begin // CSRRSI
                        written_to_csr <= result | {27'b 0, rs1};
                     end
                     3'b 111: begin // CSRRCI
                        written_to_csr <= result & ~{27'b 0, rs1};
                     end
                   endcase
                end
                default: begin
                   result <= 32'b XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;
                   written_to_csr <= 32'b XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;
                end
              endcase
           end
           default: begin
              result <= 32'b XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;
              written_to_csr <= 32'b XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;
           end
           // invalid instructions will already have trapped
         endcase
         case(opcode[6:2])
           5'b 11000: begin // branch
              case(funct3)
                3'b 000: should_branch = source1 == source2;
                3'b 001: should_branch = source1 != source2;
                3'b 010, 3'b 011: should_branch = 1'b X;
                3'b 100: should_branch = $signed(source1) < $signed(source2);
                3'b 101: should_branch = $signed(source1) >= $signed(source2);
                3'b 110: should_branch = source1 < source2;
                3'b 111: should_branch = source1 >= source2;
              endcase
              if(should_branch) begin
                 tsugi_no_pc <= pc + {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:9]};
`ifndef NO_JUMP_ALIGN_CHECK
                 jump_misaligned <= instruction[8];
`endif
              end else begin
                 tsugi_no_pc <= pc_plus_one;
              end
           end
           5'b 11001: begin // JALR
`ifndef NO_JUMP_ALIGN_CHECK
              {tsugi_no_pc, jump_misaligned} <= (source1 + imm12)>>1;
`else
              tsugi_no_pc <= (source1 + imm12)>>2;
`endif
           end
           5'b 11011: begin // JAL
              tsugi_no_pc <= pc + {{12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:22]};
`ifndef NO_JUMP_ALIGN_CHECK
              jump_misaligned <= instruction[21];
`endif
           end
           5'b 11100: begin // SYSTEM
              if(funct3 == 0) begin
                 // assuming only MRET again
                 // TODO: WFI
                 tsugi_no_pc <= csr_mepc;
              end else tsugi_no_pc <= pc_plus_one;
           end
           default:
             tsugi_no_pc <= pc_plus_one;
         endcase
      end
   end
`ifndef NO_ALLSTATE
   assign allstate = {addr_out, data_in, data_out, mem_mask, not_writing, pc[23:2], tsugi_no_pc[23:2], instruction, data_from_memory, written_to_csr, load_needed, store_needed, load_addr[23:0], store_addr[23:0], instruction_valid, mem_access_aligned, jump_misaligned, trapping, should_branch, priv, result};
`endif
endmodule
