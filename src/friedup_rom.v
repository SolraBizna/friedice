// Auto-generated by gen_friedup_rom.lua, don't edit!
SB_RAM40_4K #(
.INIT_0(256'hfa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0f),
.INIT_1(256'hfa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0f),
.INIT_2(256'hfa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0f),
.INIT_3(256'hfa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0f),
.INIT_4(256'hfa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0f),
.INIT_5(256'hfa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0f),
.INIT_6(256'hfa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0f),
.INIT_7(256'hfa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0f),
.INIT_8(256'hfa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0f),
.INIT_9(256'hfa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0f),
.INIT_A(256'hfa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0f),
.INIT_B(256'hfa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0f),
.INIT_C(256'hfa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0f),
.INIT_D(256'hfa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0f),
.INIT_E(256'hfa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0f),
.INIT_F(256'hfa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0ffa0f)
) rom0lo(.RDATA(data_from_rom[0][15:0]),
          .RADDR({3'b 000, addr_from_core[9:2]}),
          .RCLK(clock),
          .RE(rom_select),
          .RCLKE(rom_select));
SB_RAM40_4K #(
.INIT_0(256'hfa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1e),
.INIT_1(256'hfa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1e),
.INIT_2(256'hfa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1e),
.INIT_3(256'hfa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1e),
.INIT_4(256'hfa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1e),
.INIT_5(256'hfa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1e),
.INIT_6(256'hfa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1e),
.INIT_7(256'hfa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1e),
.INIT_8(256'hfa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1e),
.INIT_9(256'hfa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1e),
.INIT_A(256'hfa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1e),
.INIT_B(256'hfa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1e),
.INIT_C(256'hfa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1e),
.INIT_D(256'hfa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1e),
.INIT_E(256'hfa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1e),
.INIT_F(256'hfa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1efa1e)
) rom0hi(.RDATA(data_from_rom[0][31:16]),
          .RADDR({3'b 000, addr_from_core[9:2]}),
          .RCLK(clock),
          .RE(rom_select),
          .RCLKE(rom_select));
SB_RAM40_4K #(
.INIT_0(256'hfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2d),
.INIT_1(256'hfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2d),
.INIT_2(256'hfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2d),
.INIT_3(256'hfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2d),
.INIT_4(256'hfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2d),
.INIT_5(256'hfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2d),
.INIT_6(256'hfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2d),
.INIT_7(256'hfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2d),
.INIT_8(256'hfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2d),
.INIT_9(256'hfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2d),
.INIT_A(256'hfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2d),
.INIT_B(256'hfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2d),
.INIT_C(256'hfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2d),
.INIT_D(256'hfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2d),
.INIT_E(256'hfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2d),
.INIT_F(256'hfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2dfa2d)
) rom1lo(.RDATA(data_from_rom[1][15:0]),
          .RADDR({3'b 000, addr_from_core[9:2]}),
          .RCLK(clock),
          .RE(rom_select),
          .RCLKE(rom_select));
SB_RAM40_4K #(
.INIT_0(256'hfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3c),
.INIT_1(256'hfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3c),
.INIT_2(256'hfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3c),
.INIT_3(256'hfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3c),
.INIT_4(256'hfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3c),
.INIT_5(256'hfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3c),
.INIT_6(256'hfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3c),
.INIT_7(256'hfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3c),
.INIT_8(256'hfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3c),
.INIT_9(256'hfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3c),
.INIT_A(256'hfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3c),
.INIT_B(256'hfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3c),
.INIT_C(256'hfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3c),
.INIT_D(256'hfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3c),
.INIT_E(256'hfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3c),
.INIT_F(256'hfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3cfa3c)
) rom1hi(.RDATA(data_from_rom[1][31:16]),
          .RADDR({3'b 000, addr_from_core[9:2]}),
          .RCLK(clock),
          .RE(rom_select),
          .RCLKE(rom_select));
SB_RAM40_4K #(
.INIT_0(256'hfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4b),
.INIT_1(256'hfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4b),
.INIT_2(256'hfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4b),
.INIT_3(256'hfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4b),
.INIT_4(256'hfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4b),
.INIT_5(256'hfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4b),
.INIT_6(256'hfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4b),
.INIT_7(256'hfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4b),
.INIT_8(256'hfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4b),
.INIT_9(256'hfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4b),
.INIT_A(256'hfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4b),
.INIT_B(256'hfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4b),
.INIT_C(256'hfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4b),
.INIT_D(256'hfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4b),
.INIT_E(256'hfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4b),
.INIT_F(256'hfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4bfa4b)
) rom2lo(.RDATA(data_from_rom[2][15:0]),
          .RADDR({3'b 000, addr_from_core[9:2]}),
          .RCLK(clock),
          .RE(rom_select),
          .RCLKE(rom_select));
SB_RAM40_4K #(
.INIT_0(256'hfa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5a),
.INIT_1(256'hfa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5a),
.INIT_2(256'hfa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5a),
.INIT_3(256'hfa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5a),
.INIT_4(256'hfa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5a),
.INIT_5(256'hfa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5a),
.INIT_6(256'hfa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5a),
.INIT_7(256'hfa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5a),
.INIT_8(256'hfa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5a),
.INIT_9(256'hfa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5a),
.INIT_A(256'hfa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5a),
.INIT_B(256'hfa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5a),
.INIT_C(256'hfa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5a),
.INIT_D(256'hfa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5a),
.INIT_E(256'hfa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5a),
.INIT_F(256'hfa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5afa5a)
) rom2hi(.RDATA(data_from_rom[2][31:16]),
          .RADDR({3'b 000, addr_from_core[9:2]}),
          .RCLK(clock),
          .RE(rom_select),
          .RCLKE(rom_select));
SB_RAM40_4K #(
.INIT_0(256'hfa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69),
.INIT_1(256'hfa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69),
.INIT_2(256'hfa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69),
.INIT_3(256'hfa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69),
.INIT_4(256'hfa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69),
.INIT_5(256'hfa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69),
.INIT_6(256'hfa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69),
.INIT_7(256'hfa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69),
.INIT_8(256'hfa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69),
.INIT_9(256'hfa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69),
.INIT_A(256'hfa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69),
.INIT_B(256'hfa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69),
.INIT_C(256'hfa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69),
.INIT_D(256'hfa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69),
.INIT_E(256'hfa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69),
.INIT_F(256'hfa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69fa69)
) rom3lo(.RDATA(data_from_rom[3][15:0]),
          .RADDR({3'b 000, addr_from_core[9:2]}),
          .RCLK(clock),
          .RE(rom_select),
          .RCLKE(rom_select));
SB_RAM40_4K #(
.INIT_0(256'hfa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78),
.INIT_1(256'hfa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78),
.INIT_2(256'hfa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78),
.INIT_3(256'hfa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78),
.INIT_4(256'hfa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78),
.INIT_5(256'hfa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78),
.INIT_6(256'hfa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78),
.INIT_7(256'hfa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78),
.INIT_8(256'hfa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78),
.INIT_9(256'hfa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78),
.INIT_A(256'hfa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78),
.INIT_B(256'hfa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78),
.INIT_C(256'hfa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78),
.INIT_D(256'hfa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78),
.INIT_E(256'hfa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78),
.INIT_F(256'hfa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78fa78)
) rom3hi(.RDATA(data_from_rom[3][31:16]),
          .RADDR({3'b 000, addr_from_core[9:2]}),
          .RCLK(clock),
          .RE(rom_select),
          .RCLKE(rom_select));
SB_RAM40_4K #(
.INIT_0(256'hfa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87),
.INIT_1(256'hfa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87),
.INIT_2(256'hfa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87),
.INIT_3(256'hfa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87),
.INIT_4(256'hfa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87),
.INIT_5(256'hfa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87),
.INIT_6(256'hfa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87),
.INIT_7(256'hfa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87),
.INIT_8(256'hfa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87),
.INIT_9(256'hfa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87),
.INIT_A(256'hfa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87),
.INIT_B(256'hfa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87),
.INIT_C(256'hfa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87),
.INIT_D(256'hfa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87),
.INIT_E(256'hfa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87),
.INIT_F(256'hfa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87fa87)
) rom4lo(.RDATA(data_from_rom[4][15:0]),
          .RADDR({3'b 000, addr_from_core[9:2]}),
          .RCLK(clock),
          .RE(rom_select),
          .RCLKE(rom_select));
SB_RAM40_4K #(
.INIT_0(256'hfa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96),
.INIT_1(256'hfa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96),
.INIT_2(256'hfa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96),
.INIT_3(256'hfa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96),
.INIT_4(256'hfa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96),
.INIT_5(256'hfa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96),
.INIT_6(256'hfa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96),
.INIT_7(256'hfa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96),
.INIT_8(256'hfa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96),
.INIT_9(256'hfa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96),
.INIT_A(256'hfa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96),
.INIT_B(256'hfa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96),
.INIT_C(256'hfa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96),
.INIT_D(256'hfa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96),
.INIT_E(256'hfa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96),
.INIT_F(256'hfa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96fa96)
) rom4hi(.RDATA(data_from_rom[4][31:16]),
          .RADDR({3'b 000, addr_from_core[9:2]}),
          .RCLK(clock),
          .RE(rom_select),
          .RCLKE(rom_select));
SB_RAM40_4K #(
.INIT_0(256'hfaa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5),
.INIT_1(256'hfaa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5),
.INIT_2(256'hfaa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5),
.INIT_3(256'hfaa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5),
.INIT_4(256'hfaa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5),
.INIT_5(256'hfaa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5),
.INIT_6(256'hfaa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5),
.INIT_7(256'hfaa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5),
.INIT_8(256'hfaa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5),
.INIT_9(256'hfaa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5),
.INIT_A(256'hfaa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5),
.INIT_B(256'hfaa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5),
.INIT_C(256'hfaa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5),
.INIT_D(256'hfaa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5),
.INIT_E(256'hfaa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5),
.INIT_F(256'hfaa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5faa5)
) rom5lo(.RDATA(data_from_rom[5][15:0]),
          .RADDR({3'b 000, addr_from_core[9:2]}),
          .RCLK(clock),
          .RE(rom_select),
          .RCLKE(rom_select));
SB_RAM40_4K #(
.INIT_0(256'hfab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4),
.INIT_1(256'hfab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4),
.INIT_2(256'hfab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4),
.INIT_3(256'hfab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4),
.INIT_4(256'hfab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4),
.INIT_5(256'hfab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4),
.INIT_6(256'hfab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4),
.INIT_7(256'hfab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4),
.INIT_8(256'hfab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4),
.INIT_9(256'hfab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4),
.INIT_A(256'hfab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4),
.INIT_B(256'hfab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4),
.INIT_C(256'hfab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4),
.INIT_D(256'hfab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4),
.INIT_E(256'hfab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4),
.INIT_F(256'hfab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4fab4)
) rom5hi(.RDATA(data_from_rom[5][31:16]),
          .RADDR({3'b 000, addr_from_core[9:2]}),
          .RCLK(clock),
          .RE(rom_select),
          .RCLKE(rom_select));
SB_RAM40_4K #(
.INIT_0(256'hfac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3),
.INIT_1(256'hfac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3),
.INIT_2(256'hfac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3),
.INIT_3(256'hfac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3),
.INIT_4(256'hfac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3),
.INIT_5(256'hfac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3),
.INIT_6(256'hfac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3),
.INIT_7(256'hfac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3),
.INIT_8(256'hfac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3),
.INIT_9(256'hfac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3),
.INIT_A(256'hfac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3),
.INIT_B(256'hfac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3),
.INIT_C(256'hfac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3),
.INIT_D(256'hfac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3),
.INIT_E(256'hfac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3),
.INIT_F(256'hfac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3fac3)
) rom6lo(.RDATA(data_from_rom[6][15:0]),
          .RADDR({3'b 000, addr_from_core[9:2]}),
          .RCLK(clock),
          .RE(rom_select),
          .RCLKE(rom_select));
SB_RAM40_4K #(
.INIT_0(256'hfad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2),
.INIT_1(256'hfad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2),
.INIT_2(256'hfad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2),
.INIT_3(256'hfad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2),
.INIT_4(256'hfad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2),
.INIT_5(256'hfad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2),
.INIT_6(256'hfad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2),
.INIT_7(256'hfad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2),
.INIT_8(256'hfad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2),
.INIT_9(256'hfad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2),
.INIT_A(256'hfad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2),
.INIT_B(256'hfad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2),
.INIT_C(256'hfad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2),
.INIT_D(256'hfad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2),
.INIT_E(256'hfad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2),
.INIT_F(256'hfad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2fad2)
) rom6hi(.RDATA(data_from_rom[6][31:16]),
          .RADDR({3'b 000, addr_from_core[9:2]}),
          .RCLK(clock),
          .RE(rom_select),
          .RCLKE(rom_select));
SB_RAM40_4K #(
.INIT_0(256'hfae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1),
.INIT_1(256'hfae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1),
.INIT_2(256'hfae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1),
.INIT_3(256'hfae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1),
.INIT_4(256'hfae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1),
.INIT_5(256'hfae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1),
.INIT_6(256'hfae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1),
.INIT_7(256'hfae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1),
.INIT_8(256'hfae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1),
.INIT_9(256'hfae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1),
.INIT_A(256'hfae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1),
.INIT_B(256'hfae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1),
.INIT_C(256'hfae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1),
.INIT_D(256'hfae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1),
.INIT_E(256'hfae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1),
.INIT_F(256'hfae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1fae1)
) rom7lo(.RDATA(data_from_rom[7][15:0]),
          .RADDR({3'b 000, addr_from_core[9:2]}),
          .RCLK(clock),
          .RE(rom_select),
          .RCLKE(rom_select));
SB_RAM40_4K #(
.INIT_0(256'hfaf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0),
.INIT_1(256'hfaf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0),
.INIT_2(256'hfaf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0),
.INIT_3(256'hfaf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0),
.INIT_4(256'hfaf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0),
.INIT_5(256'hfaf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0),
.INIT_6(256'hfaf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0),
.INIT_7(256'hfaf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0),
.INIT_8(256'hfaf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0),
.INIT_9(256'hfaf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0),
.INIT_A(256'hfaf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0),
.INIT_B(256'hfaf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0),
.INIT_C(256'hfaf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0),
.INIT_D(256'hfaf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0),
.INIT_E(256'hfaf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0),
.INIT_F(256'hfaf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0faf0)
) rom7hi(.RDATA(data_from_rom[7][31:16]),
          .RADDR({3'b 000, addr_from_core[9:2]}),
          .RCLK(clock),
          .RE(rom_select),
          .RCLKE(rom_select));
