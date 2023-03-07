SRC.iCE40_vendor.VLOG:=\
	$(LATTICE_RADIANT)/cae_library/simulation/verilog/iCE40UP/ACCUM_ADDER.v    \
	$(LATTICE_RADIANT)/cae_library/simulation/verilog/iCE40UP/ACCUM_REG.v      \
	$(LATTICE_RADIANT)/cae_library/simulation/verilog/iCE40UP/ADDER_A_IN_MUX.v \
	$(LATTICE_RADIANT)/cae_library/simulation/verilog/iCE40UP/ADDER_B_IN_MUX.v \
	$(LATTICE_RADIANT)/cae_library/simulation/verilog/iCE40UP/CARRY_IN_MUX.v   \
	$(LATTICE_RADIANT)/cae_library/simulation/verilog/iCE40UP/LOAD_ADD_MUX.v   \
	$(LATTICE_RADIANT)/cae_library/simulation/verilog/iCE40UP/MAC16.v          \
	$(LATTICE_RADIANT)/cae_library/simulation/verilog/iCE40UP/MAC16_SIM.v      \
	$(LATTICE_RADIANT)/cae_library/simulation/verilog/iCE40UP/MPY16X16.v       \
	$(LATTICE_RADIANT)/cae_library/simulation/verilog/iCE40UP/MPY8x8.v         \
	$(LATTICE_RADIANT)/cae_library/simulation/verilog/iCE40UP/MULT_ACCUM.v     \
	$(LATTICE_RADIANT)/cae_library/simulation/verilog/iCE40UP/OUT_MUX_4.v      \
	$(LATTICE_RADIANT)/cae_library/simulation/verilog/iCE40UP/REG_BYPASS_MUX.v \
	$(LATTICE_RADIANT)/cae_library/simulation/verilog/iCE40UP/booth_encoder.v  \
	$(LATTICE_RADIANT)/cae_library/simulation/verilog/iCE40UP/booth_selector.v \
	$(LATTICE_RADIANT)/cae_library/simulation/verilog/iCE40UP/fa.v             \
	$(LATTICE_RADIANT)/cae_library/simulation/verilog/iCE40UP/fcla16.v         \
	$(LATTICE_RADIANT)/cae_library/simulation/verilog/iCE40UP/fcla8.v          \
	$(LATTICE_RADIANT)/cae_library/simulation/verilog/iCE40UP/ha.v             \
	$(LATTICE_RADIANT)/cae_library/simulation/verilog/iCE40UP/mac16_physical.v \
	$(LATTICE_RADIANT)/cae_library/simulation/verilog/iCE40UP/mclg16.v         \
	$(LATTICE_RADIANT)/cae_library/simulation/verilog/iCE40UP/mclg4.v          \
	$(LATTICE_RADIANT)/cae_library/simulation/verilog/iCE40UP/mpfa.v
SRC.iCE40_vendor.VHDL:=\
	$(LATTICE_RADIANT)/cae_library/synthesis/vhdl/iCE40UP.vhd
SRC.iCE40_model.VHDL:=\
	../../../../model/iCE40UP/radiant/mac16.vhd   \
	../../../../model/iCE40UP/radiant/iCE40UP.vhd
SRC.work.VHDL:=\
	../../../../lib/iCE40UP/radiant/wrapper_mac16.vhd \
	tb_mac16.vhd                                      \
	cfg_tb_mac16.vhd

all:
	vlib iCE40UP_vendor
	vlog -work iCE40UP_vendor +incdir+$(LATTICE_RADIANT)/cae_library/simulation/verilog/iCE40UP $(SRC.iCE40_vendor.VLOG)
	vcom -work iCE40UP_vendor $(SRC.iCE40_vendor.VHDL)
	vmap iCE40UP iCE40UP_vendor
	vcom -work iCE40UP_model $(SRC.iCE40_model.VHDL)
	vlib work
	vcom -work work $(SRC.work.VHDL)

clean:
	rm -rf iCE40UP_vendor iCE40UP_model work
	rm -f modelsim.ini
