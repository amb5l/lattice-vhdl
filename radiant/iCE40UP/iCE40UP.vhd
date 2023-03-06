--------------------------------------------------------------------------------
-- iCE40UP.vhd                                                                --
--------------------------------------------------------------------------------
-- (C) Copyright 2023 Adam Barnes <ambarnes@gmail.com>                        --
-- This file is part of lattice-vhdl. lattice-vhdl is free software: you can  --
-- redistribute it and/or modify it under the terms of the GNU Lesser General --
-- Public License as published by the Free Software Foundation, either        --
-- version 3 of the License, or (at your option) any later version.           --
-- lattice-vhdl is distributed in the hope that it will be useful, but        --
-- WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public     --
-- License for more details. You should have received a copy of the GNU       --
-- Lesser General Public License along with lattice-vhdl. If not, see         --
-- https://www.gnu.org/licenses/.                                             --
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package components is

  component mac16 is
    generic (
      neg_trigger              : string;
      a_reg                    : string;
      b_reg                    : string;
      c_reg                    : string;
      d_reg                    : string;
      top_8x8_mult_reg         : string;
      bot_8x8_mult_reg         : string;
      pipeline_16x16_mult_reg1 : string;
      pipeline_16x16_mult_reg2 : string;
      topoutput_select         : string;
      topaddsub_lowerinput     : string;
      topaddsub_upperinput     : string;
      topaddsub_carryselect    : string;
      botoutput_select         : string;
      botaddsub_lowerinput     : string;
      botaddsub_upperinput     : string;
      botaddsub_carryselect    : string;
      mode_8x8                 : string;
      a_signed                 : string;
      b_signed                 : string
    );
    port(
      clk                      : in    std_logic;
      ce                       : in    std_logic;
      ahold                    : in    std_logic;
      bhold                    : in    std_logic;
      chold                    : in    std_logic;
      dhold                    : in    std_logic;
      irsttop                  : in    std_logic;
      irstbot                  : in    std_logic;
      orsttop                  : in    std_logic;
      orstbot                  : in    std_logic;
      oloadtop                 : in    std_logic;
      oloadbot                 : in    std_logic;
      addsubtop                : in    std_logic;
      addsubbot                : in    std_logic;
      oholdtop                 : in    std_logic;
      oholdbot                 : in    std_logic;
      ci                       : in    std_logic;
      accumci                  : in    std_logic;
      signextin                : in    std_logic;
      a0                       : in    std_logic;
      a1                       : in    std_logic;
      a2                       : in    std_logic;
      a3                       : in    std_logic;
      a4                       : in    std_logic;
      a5                       : in    std_logic;
      a6                       : in    std_logic;
      a7                       : in    std_logic;
      a8                       : in    std_logic;
      a9                       : in    std_logic;
      a10                      : in    std_logic;
      a11                      : in    std_logic;
      a12                      : in    std_logic;
      a13                      : in    std_logic;
      a14                      : in    std_logic;
      a15                      : in    std_logic;
      b0                       : in    std_logic;
      b1                       : in    std_logic;
      b2                       : in    std_logic;
      b3                       : in    std_logic;
      b4                       : in    std_logic;
      b5                       : in    std_logic;
      b6                       : in    std_logic;
      b7                       : in    std_logic;
      b8                       : in    std_logic;
      b9                       : in    std_logic;
      b10                      : in    std_logic;
      b11                      : in    std_logic;
      b12                      : in    std_logic;
      b13                      : in    std_logic;
      b14                      : in    std_logic;
      b15                      : in    std_logic;
      c0                       : in    std_logic;
      c1                       : in    std_logic;
      c2                       : in    std_logic;
      c3                       : in    std_logic;
      c4                       : in    std_logic;
      c5                       : in    std_logic;
      c6                       : in    std_logic;
      c7                       : in    std_logic;
      c8                       : in    std_logic;
      c9                       : in    std_logic;
      c10                      : in    std_logic;
      c11                      : in    std_logic;
      c12                      : in    std_logic;
      c13                      : in    std_logic;
      c14                      : in    std_logic;
      c15                      : in    std_logic;
      d0                       : in    std_logic;
      d1                       : in    std_logic;
      d2                       : in    std_logic;
      d3                       : in    std_logic;
      d4                       : in    std_logic;
      d5                       : in    std_logic;
      d6                       : in    std_logic;
      d7                       : in    std_logic;
      d8                       : in    std_logic;
      d9                       : in    std_logic;
      d10                      : in    std_logic;
      d11                      : in    std_logic;
      d12                      : in    std_logic;
      d13                      : in    std_logic;
      d14                      : in    std_logic;
      d15                      : in    std_logic;
      o0                       : out   std_logic;
      o1                       : out   std_logic;
      o2                       : out   std_logic;
      o3                       : out   std_logic;
      o4                       : out   std_logic;
      o5                       : out   std_logic;
      o6                       : out   std_logic;
      o7                       : out   std_logic;
      o8                       : out   std_logic;
      o9                       : out   std_logic;
      o10                      : out   std_logic;
      o11                      : out   std_logic;
      o12                      : out   std_logic;
      o13                      : out   std_logic;
      o14                      : out   std_logic;
      o15                      : out   std_logic;
      o16                      : out   std_logic;
      o17                      : out   std_logic;
      o18                      : out   std_logic;
      o19                      : out   std_logic;
      o20                      : out   std_logic;
      o21                      : out   std_logic;
      o22                      : out   std_logic;
      o23                      : out   std_logic;
      o24                      : out   std_logic;
      o25                      : out   std_logic;
      o26                      : out   std_logic;
      o27                      : out   std_logic;
      o28                      : out   std_logic;
      o29                      : out   std_logic;
      o30                      : out   std_logic;
      o31                      : out   std_logic;
      co                       : out   std_logic;
      accumco                  : out   std_logic;
      signextout               : out   std_logic
    );
  end component mac16;

end package components;
