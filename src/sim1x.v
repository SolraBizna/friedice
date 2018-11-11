module sim1x();

   wire [31:0] data_in;
   wire [31:0] data_out;
   wire [23:0] addr_out;
   wire [3:0]  wmask;
   wire        not_writing;
   
   reg        clock, reset;
   
   
   friedice#(.STARTING_PC(32'h 8000_0000))
   core(.data_in(data_in),
        .data_out(data_out),
        .mem_mask(wmask),
        .not_writing(not_writing),
        .addr_out(addr_out),
        .clock(clock),
        .reset(reset));
   memoryspace mem(clock, addr_out[23:2], data_out, data_in, wmask, not_writing, !not_writing);

   always #2 clock = !clock;
   
   initial begin
      clock = 0;
      reset = 0;
      #8
        reset = 1;
      #1000000 begin
         $display("Patience ran out");
         $finish();
      end
   end
   
endmodule
