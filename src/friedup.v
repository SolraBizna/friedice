`define DEBUG_INTERFACE 1
//`define LED_INTERFACE 1

module friedup(output RGB0,
               output RGB1,
               output RGB2,
               input  enable_internal_clock,
               input  debug_clock,
               input  debug_strobe,
               output debug_data,
               input  external_reset,
               input  external_clock);

`ifndef DEBUG_INTERFACE
   assign debug_data = 0;
`endif
   
   wire[31:0] data_to_core, data_from_core;
   wire[23:0] addr_from_core;
   wire[3:0] mem_mask;
   wire not_writing;
   reg startup_reset = 0;
   wire raw_clock, clock, reset;
   wire [320:0] allstate;
   
   friedice #(.STARTING_PC(32'h 0040_0000))
     core(.data_in(data_to_core),
          .data_out(data_from_core),
          .mem_mask(mem_mask),
          .not_writing(not_writing),
          .addr_out(addr_from_core),
          .clock(clock),
          .reset(reset),
          .allstate(allstate));

   reg[15:0] ctr = 0;
   always @(posedge raw_clock) begin
      if(ctr == 255) startup_reset = 1;
      ctr <= ctr + 1;
   end
`ifdef LED_INTERFACE
   // RGB LED: xxFFFFFC
   wire PWM_select = addr_from_core[23:2] == 22'b 1111_1111_1111_1111_1111_11;
   wire LED_red, LED_green, LED_blue;
   pwm PWM_red(clock, ctr[7:0], data_from_core[7:0],
               PWM_select && !mem_mask[0] && !not_writing, LED_red);
   pwm PWM_grn(clock, ctr[7:0], data_from_core[15:8],
               PWM_select && !mem_mask[1] && !not_writing, LED_green);
   pwm PWM_blu(clock, ctr[7:0], data_from_core[23:16],
               PWM_select && !mem_mask[2] && !not_writing, LED_blue);
   SB_RGBA_DRV
     #(
       .RGB0_CURRENT("0b000001"),
       .RGB1_CURRENT("0b000001"),
       .RGB2_CURRENT("0b000001"),
       .CURRENT_MODE("0b1")
       )
     LED_driver
     (
      .CURREN(1),
      .RGBLEDEN(1),
      .RGB0PWM(LED_green),
      .RGB1PWM(LED_blue),
      .RGB2PWM(LED_red),
      .RGB0(RGB0),
      .RGB1(RGB1),
      .RGB2(RGB2)
      );
`endif
   
   // "ROM", 8192 bytes: xx400000 -- xx7FFFFF
   wire rom_select = addr_from_core[23:22] == 1;
   wire[31:0] data_from_rom[0:7];
`include "src/friedup_rom.v"

   // RAM, 131072 bytes: xx000000 -- xx3FFFFF
   wire ram_select = addr_from_core[23:22] == 0;
   wire[31:0] data_from_ram[0:1];
   genvar n;
   for(n = 0; n < 2; n = n + 1) begin
      wire select = ram_select && addr_from_core[16] == n;
      SB_SPRAM256KA lo
           (
            .DATAOUT(data_from_ram[n][15:0]),
            .DATAIN(data_from_core[15:0]),
            .ADDRESS(addr_from_core[15:2]),
            .CLOCK(clock),
            .WREN(!not_writing),
            .CHIPSELECT(select),
            .MASKWREN({mem_mask[1], mem_mask[1], mem_mask[0], mem_mask[0]})
            ), hi
           (
            .DATAOUT(data_from_ram[n][31:16]),
            .DATAIN(data_from_core[31:16]),
            .ADDRESS(addr_from_core[15:2]),
            .CLOCK(clock),
            .WREN(!not_writing),
            .CHIPSELECT(select),
            .MASKWREN({mem_mask[3], mem_mask[3], mem_mask[2], mem_mask[2]})
            );
   end

   // select data in!
   assign data_to_core = rom_select ? data_from_rom[addr_from_core[12:10]]
                         : ram_select ? data_from_ram[addr_from_core[16]]
                         : 32'b XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;

   // debug interface!
`ifdef DEBUG_INTERFACE
   wire enable_internal_clock_signal;
   SB_IO#(.PULLUP(1)) eic_pin(.D_IN_0(enable_internal_clock_signal),
                              .PACKAGE_PIN(enable_internal_clock));
   assign clock = raw_clock;//ctr[1];//enable_internal_clock_signal ? ctr[6] : external_clock;
   assign reset = startup_reset && external_reset;
   reg [320:0] debug_shift;
   assign debug_data = debug_shift[320];
   always @(posedge debug_clock) begin
      if(debug_strobe) debug_shift = allstate;
      else debug_shift = {debug_shift[319:0], 1'b 1};
   end
`else
   assign clock = raw_clock;
   assign reset = startup_reset;
`endif
   
   // clock!
   SB_HFOSC #(.CLKHF_DIV("0b11")) clock_instance(.CLKHFPU(1), .CLKHFEN(1), .CLKHF(raw_clock));

endmodule
