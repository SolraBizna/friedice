module pwm(clock, phase, data_in, write_enable, out);
   input clock;
   output out;
   input[7:0] phase;
   input[7:0] data_in;
   input write_enable;
   
   reg[7:0] duty = 16;
   assign out = phase < duty;
   
   always @(posedge clock) begin
      if(write_enable) duty = data_in;
   end
endmodule
