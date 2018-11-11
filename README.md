FriedICE is a no-wait unpipelined in-order RV32I core. Yes, that's as awful as it sounds.

FriedUp is a simple SOC incorporating a FriedICE core, designed to fit into an iCE40 UP5k.

Neither of them is ready for real use yet.

All of it is written in Verilog.

If you have `iverilog` and a `riscv32-unknown-elf` toolchain:

```sh
git submodule init
git submodule update
cd test
./test.sh
```

will show you that FriedICE does, in fact, pass all the RV32I compliance tests in simulation, somehow.
