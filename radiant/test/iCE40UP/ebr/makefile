################################################################################
# makefile for tb_ebr
################################################################################

all: vsim

################################################################################
# assume make-fpga is located alongside this repo

REPO_ROOT?=$(shell git rev-parse --show-toplevel)
ifeq ($(OS),Windows_NT)
REPO_ROOT:=$(shell cygpath -m $(REPO_ROOT))
endif
MAKE_FPGA?=$(REPO_ROOT)/../make-fpga

include $(MAKE_FPGA)/start.mak

$(call check_null,LATTICE_RADIANT)

################################################################################

SIM_LIB:=work
SIM_SRC.work:=\
    $(REPO_ROOT)/radiant/src/iCE40UP/iCE40UP_wrappers.vhd \
    $(MAKE_DIR)/tb_ebr.vhd
SIM_SRC.iCE40UP:=$(LATTICE_RADIANT)/cae_library/synthesis/vhdl/iCE40UP.vhd
SIM_TOP:=tb_ebr

################################################################################
# ModelSim/Questa

ifeq ($(OS),Windows_NT)
VSIM_BIN_DIR?=$(LATTICE_RADIANT)/modeltech/win32loem
endif

VSIM_LIB:=$(SIM_LIB)
VSIM_SRC.$(SIM_LIB):=$(SIM_SRC.$(SIM_LIB))
VSIM_RUN:=$(SIM_TOP)
include $(MAKE_FPGA)/vsim.mak

################################################################################
# VSCode & V4P

VSCODE_LIB:=$(SIM_LIB) iCE40UP
VSCODE_SRC.$(SIM_LIB):=$(SIM_SRC.$(SIM_LIB))
VSCODE_SRC.iCE40UP:=$(LATTICE_RADIANT)/cae_library/synthesis/vhdl/iCE40UP.vhd
V4P_TOP:=$(SIM_TOP)
include $(MAKE_FPGA)/vscode.mak

################################################################################
# cleanup

clean:
	rm -rf $(VSIM_DIR)

################################################################################
