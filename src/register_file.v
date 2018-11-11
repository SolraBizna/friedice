module register_file(rrd1, rrd2, rwr,
                     rd1, rd2, wr,
                     rd1en, rd2en, wren,
                     clock, outregs);
   input[0:4] rrd1;
   input[0:4] rrd2;
   input[0:4] rwr;
   output[0:31] rd1;
   output[0:31] rd2;
   input[0:31] wr;
   input rd1en, rd2en, wren;
   input clock;
   reg[0:31] regs[1:31];
   reg[0:31] temp;
   reg[0:4] target;
   reg wrote_temp = 0;
   output[0:991] outregs;
   wire[0:991] outregw = {regs[1],regs[2],regs[3],regs[4],regs[5],regs[6],
                          regs[7],regs[8],regs[9],regs[10],regs[11],regs[12],
                          regs[13],regs[14],regs[15],regs[16],regs[17],
                          regs[18],regs[19],regs[20],regs[21],regs[22],
                          regs[23],regs[24],regs[25],regs[26],regs[27],
                          regs[28],regs[29],regs[30],regs[31]};
   assign outregs = outregw;

   assign rd1 = rd1en ? (rrd1 != 0 ? regs[rrd1] : 0) : 32'b XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;
   assign rd2 = rd2en ? (rrd2 != 0 ? regs[rrd2] : 0) : 32'b XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;
   always @(posedge clock) begin
      if(wren && rwr != 0) begin
         target <= rwr;
         temp <= wr;
         wrote_temp <= 1;
      end else begin
         wrote_temp <= 0;
      end
   end
   always @(negedge clock) begin
      if(wrote_temp)
        regs[target] <= temp;
   end
endmodule
