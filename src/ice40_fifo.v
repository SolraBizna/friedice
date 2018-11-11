module fifo(input[7:0] data_in, output reg[8:0] data_out,
            input input_clock, input output_clock,
            input input_clock_enable, input output_clock_enable,
            input reset);
   reg[8:0] in_ptr, in_ptr_plus_one, out_ptr;
   wire data_present = in_ptr != out_ptr;
   wire buffer_has_room = (in_ptr_plus_one != out_ptr);
   wire[7:0] buf_out;
   SB_RAM512x8 fifobuf(.RDATA(buf_out), .RADDR(out_ptr), .RCLK(output_clock),
                       .RCLKE(data_present && output_clock_enable), .RE(1),
                       .WDATA(data_in), .WADDR(in_ptr), .WCLK(input_clock),
                       .WCLKE(buffer_has_room && input_clock_enable), .WE(1));
   always @(posedge input_clock or negedge reset) begin
      if(!reset) begin
         in_ptr <= 0;
         in_ptr_plus_one <= 1;
      end else begin
         if(buffer_has_room) begin
            in_ptr <= in_ptr + 1;
            in_ptr_plus_one <= in_ptr_plus_one + 1;
         end
      end
   end
   always @(posedge output_clock or negedge reset) begin
      if(!reset) begin
         out_ptr <= 0;
      end else begin
         if(data_present) begin
            data_out = {1'b 0, buf_out};
            out_ptr <= out_ptr + 1;
         end else begin
            data_out = 9'b 111111111;
         end
      end
   end
endmodule
