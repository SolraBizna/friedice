module memoryspace(clock, address, data_in, data_out, wmask, wlo, olo);
   input clock;
   input [23:2] address;
   input [31:0] data_in;
   output [31:0] data_out;
   input [3:0]  wmask;
   input        wlo, olo;

   reg          was_writing;
   reg[23:2]          write_addr_buffer;
   
   reg[31:0] out_buffer;

   reg[7:0] mem[16777215:0];
   reg      trace = 0;
   reg      stdio = 1;
   reg [31:0] tohost;
   reg [31:0] signature_start;
   reg [31:0] signature_end;

   assign data_out = !olo ? out_buffer : 32'b ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ;

   reg[16383:0] testimg;
   reg [31:0]   fd, n, o;
   always @(posedge clock) begin
      if(was_writing) begin
         if(trace) begin
            $display("%06X := %08X & %08X", {write_addr_buffer,2'b00}, data_in,
                     {{8{!wmask[3] }},{8{!wmask[2]}},{8{!wmask[1]}},{8{!wmask[0]}}});
         end
         case(write_addr_buffer)
           22'b 1111_1111_1111_1111_1111_00: begin
              if(!wmask[0] && stdio && !trace) begin
                 $write("%c",data_in[7:0]);
              end
              if(!wmask[2]) begin
                 $fflush(32'h 8000_0000);
              end
              if(!wmask[1]) begin
                 $finish;
              end
           end
           default: begin
              if(write_addr_buffer == tohost[23:2]) begin
                 for(n = 0; n < signature_end - signature_start - 15; n += 16) begin
                    for(o = 15; o < 16; o -= 1) begin
                       $write("%02x", mem[signature_start[23:0] + n + o]);
                    end
                    $write("\n");
                 end
                 $finish;
              end else begin
                 if(!wmask[0]) mem[{write_addr_buffer, 2'b00}] = data_in[7:0];
                 if(!wmask[1]) mem[{write_addr_buffer, 2'b01}] = data_in[15:8];
                 if(!wmask[2]) mem[{write_addr_buffer, 2'b10}] = data_in[23:16];
                 if(!wmask[3]) mem[{write_addr_buffer, 2'b11}] = data_in[31:24];
              end
           end
         endcase
      end
      was_writing = !wlo;
      write_addr_buffer = address;
      if(stdio && address == 22'b 1111_1111_1111_1111_1111_00 && !was_writing)
        out_buffer = $fgetc(32'h 8000_0000);
      else
        out_buffer = {mem[{address, 2'b11}], mem[{address, 2'b10}], mem[{address, 2'b01}], mem[{address, 2'b00}]};
      if(trace && !olo) $display("%06X(%08X)", {address,2'b00}, out_buffer);
   end

   initial begin
      // J 0x000008
      mem[24'h FFFFF7] = 8'b 0_0000001;
      mem[24'h FFFFF6] = 8'b 010_0_0000;
      mem[24'h FFFFF5] = 8'b 0000_0000;
      mem[24'h FFFFF4] = 8'b 0_11011_11;
      // J 0x000004
      mem[24'h FFFFFB] = 8'b 0_0000000;
      mem[24'h FFFFFA] = 8'b 110_0_0000;
      mem[24'h FFFFF9] = 8'b 0000_0000;
      mem[24'h FFFFF8] = 8'b 0_11011_11;
      // J 0x000000
      mem[24'h FFFFFF] = 8'b 0_0000000;
      mem[24'h FFFFFE] = 8'b 010_0_0000;
      mem[24'h FFFFFD] = 8'b 0000_0000;
      mem[24'h FFFFFC] = 8'b 0_11011_11;
      if($value$plusargs("TRACE=%d",trace)) begin
         ;
      end
      if($value$plusargs("STDIO=%d",stdio)) begin
         ;
      end
      if(!$value$plusargs("TESTIMG=%s", testimg)
         || !$value$plusargs("TOHOST=%h", tohost)
         || !$value$plusargs("SIG_START=%h", signature_start)
         || !$value$plusargs("SIG_END=%h", signature_end)) begin
         $display("Required arguments: +TESTIMG, +TOHOST, +SIG_START, +SIG_END");
         $finish();
      end
      fd = $fopen(testimg, "rb");
      n = $fread(mem, fd, 0); // ignore return value :)
      $fclose(fd);
   end
endmodule
