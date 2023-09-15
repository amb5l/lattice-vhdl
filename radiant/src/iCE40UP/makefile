SRC:=$(wildcard *.vhd)
SRC_WRAPPER:=$(wildcard wrapper_*.vhd)
SRC_MODEL:=$(filter-out $(SRC_WRAPPER),$(SRC))
VSCODE_LIB:=wrapper model iCE40UP
VSCODE_SRC.wrapper:=$(SRC_WRAPPER)
VSCODE_SRC.model:=$(SRC_MODEL)
VSCODE_SRC.iCE40UP:=$(LATTICE_RADIANT)/cae_library/synthesis/vhdl/iCE40UP.vhd

default: vscode

REPO_ROOT:=$(shell git rev-parse --show-toplevel)
ifeq ($(OS),Windows_NT)
REPO_ROOT:=$(shell cygpath -m $(REPO_ROOT))
endif
MAKE_FPGA:=$(REPO_ROOT)/../make-fpga/make-fpga.mak
include $(MAKE_FPGA)
