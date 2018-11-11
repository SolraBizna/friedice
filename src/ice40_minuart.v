module minuart(input[31:0] data_in, output reg[31:0] data_out,
               input select_fifo,
               input select_config,
               input not_writing,
               input rx_pin,
               output tx_pin,
               input system_clock,
               input line_clock,
               input reset);
   reg enable_tx, enable_rx;
   
   // 0-15, which 1/16th line clock phase we are in
   reg[0:3] rx_clock_phase;
   // 0 = waiting for stop bit, 1 = reading stop bit, 8-15 = reading data bits
   reg[0:3] rx_phase;
   // when data_acquired = 1, the data that was read
   reg[0:7] rx_char;
   // the number of 1/16th clocks in this phase in which rx_pin was high
   reg[0:3] rx_bits_on;
   // rises for a single line_clock cycle if we acquired data
   reg data_acquired;
   // true if the current value of rx_pin is the last slice for this phase
   wire rx_final_bit = rx_clock_phase == 15;
   // iff rx_final_bit, true if we think we have a one bit
   wire clean_one_bit = (rx_bits_on + rx_pin) > 8;
   // iff tx_final_bit, true if we think we have a zero bit
   wire clean_zero_bit = (rx_bits_on + rx_pin) < 8;

   // 1 if we are "between bytes"
   reg ready_to_transmit;
   // TODO: phase
   
   signed wire[8:0] rx_fifo_out;
   wire[8:0] tx_fifo_out;
   fifo rx_fifo(rx_char, rx_fifo_out,
                line_clock, system_clock,
                data_acquired, select_fifo && not_writing,
                reset),
     tx_fifo(data_in[7:0], tx_fifo_out,
             system_clock, line_clock,
             select_fifo && !not_writing, ready_to_transmit,
             reset);

   always @(posedge system_clock or negedge reset) begin
      if(!reset) begin
         enable_tx <= 0;
         enable_rx <= 0;
      end else begin
         case({select_fifo, select_config})
            2'b 01: begin
               // config register
               if(!not_writing) begin
                  enable_tx <= data_in[1];
                  enable_rx <= data_in[0];
               end
               data_out = {enable_tx, enable_rx};
            end
            2'b 10: begin
               // fifo
               if(not_writing) begin
                  data_out = rx_fifo_out;
               end
            end
         endcase
      end
   end
   
   always @(posedge line_clock or negedge reset) begin
      data_acquired <= 0;
      ready_to_transmit <= 0;
      if(!reset) begin
         rx_phase <= 0;
         rx_char <= 0;
      end else begin
         if(enable_rx) begin
            case(rx_phase)
               0: begin
                  // waiting for start bit
                  if(rx_pin) begin
                     // it may be the start bit!
                     rx_bits_on <= 1;
                     rx_phase <= 1;
                     rx_clock_phase <= 1;
                  end
               end
              1: begin
                 // reading start bit
                 if(rx_final_bit) begin
                    if(rx_bits_on >= 13) begin
                       // clean start bit
                       rx_phase <= 8;
                       rx_char <= 0;
                       rx_bits_on <= 0;
                    end else begin
                       // not a clean start bit
                       rx_phase <= 0;
                    end
                 end else begin
                    rx_bits_on <= rx_bits_on + rx_pin;
                 end
                 rx_clock_phase <= rx_clock_phase + 1;
              end
              8, 9, 10, 11, 12, 13, 14, 15: begin
                 // reading a char bit
                 if(rx_final_bit) begin
                    if(rx_bits_on + rx_pin != 8) begin
                       rx_char = {clean_one_bit, rx_char[6:0]};
                       if(rx_final_bit) begin
                          data_acquired <= 1;
                       end else rx_phase <= rx_phase + 1;
                    end else begin
                       rx_phase <= 0; // perfect tie, give up
                    end
                 end else begin
                    rx_bits_on <= rx_bits_on + rx_pin;
                 end
                 rx_clock_phase <= rx_clock_phase + 1;
              end
            endcase
         end else begin
            rx_phase <= 0;
            rx_char <= 0;
         end
         if(enable_tx) begin
            
         end else begin
            tx_phase <= 0;
         end
      end
   end
endmodule
