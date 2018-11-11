all: bin/friedup_cycle_leds.bin

bin/friedup_%.asc: src/rom_inject.lua bin/friedup.asc bin/%.raw
	lua5.3 src/rom_inject.lua bin/$*.raw < bin/friedup.asc > $@ || (rm -f $@; false)

bin/friedup_rom_inject: src/friedup_rom_inject.c
	cc -std=c99 -Wall -O -g $< -o $@

bin/%.json: src/%.v
	@mkdir -p bin
	yosys -q -p "synth_ice40 -json $@ -blif bin/$*.blif" $^

bin/hx8k_x1.json: src/hx8k_x1.v src/friedice.v src/register_file.v
bin/hx8k_x2.json: src/hx8k_x2.v src/friedice_x2.v src/icyrisc.v src/register_file.v

bin/friedup.json: src/friedup.v src/pwm.v src/friedice.v src/register_file.v src/ice40_minuart.v src/ice40_fifo.v

src/friedup_rom.v: src/gen_friedup_rom.lua
	lua5.3 src/gen_friedup_rom.lua

bin/sim1x_%: src/sim1x.v src/friedice.v src/register_file.v src/memory_sim_%.v
	@mkdir -p bin
	iverilog -Wall -DNO_ALLSTATE -DLONG_PC -o $@ -s sim1x $^

bin/%.asc: bin/%.json src/friedup.pcf
#	arachne-pnr -d 5k -P sg48 -p src/friedup.pcf bin/$*.blif -o $@
	nextpnr-ice40 --freq 1 --up5k --package sg48 --pcf src/friedup.pcf --json $< --asc $@

obj/%.o: src/%.S
	@mkdir -p obj
	riscv32-unknown-elf-gcc -o $@ -c $<

bin/%.elf: obj/%.o
	@mkdir -p bin
	riscv32-unknown-elf-ld -T src/simimg.ld $^ -o $@

bin/%.raw: bin/%.elf
	riscv32-unknown-elf-objcopy -O binary $< $@
	riscv32-unknown-elf-objdump -D $< > bin/$*.dis.txt

bin/%.hex: bin/%.raw
	@echo "hexdump -e ... < $< > $@"
	@(echo "@0"; hexdump -ve '/1 "%02X\n"') < $< > $@ || (rm -f $@; true)

bin/%.bin: bin/%.asc
	icepack $< $@

clean:
	rm -rf bin obj

.PHONY: all clean
.SECONDARY: # keep secondary files
MAKEFLAGS += --no-builtin-rules # out! out, vile built-in rules!
