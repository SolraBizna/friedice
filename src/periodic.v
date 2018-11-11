module periodic(clock, enable, data_in, set_latch, set_count, out);
   input clock, enable;
   input[15:0] data_in;
   input set_latch, set_count;
   output reg out;

   reg[15:0] latch, count;
   
   always @(posedge clock) begin
      if(set_count || set_latch) latch <= data_in;
      if(set_count) begin
         count <= data_in;
         out = 0;
      else if(enable) begin
         if(count == 0) out = !out;
         else if(clear) out = 0;
         if(count == 0) count <= latch;
         else count -= 1;
      end
   end
endmodule
