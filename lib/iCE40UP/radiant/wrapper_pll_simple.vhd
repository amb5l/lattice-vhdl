--------------------------------------------------------------------------------
-- wrapper_pll_simple.vhd                                                     --
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

package wrapper_pll_simple_pkg is

  component wrapper_pll_simple is
    generic (
      divr      : string;
      divf      : string;
      divq      : string
    );
    port (
      rst       : in    std_logic;
      rclk      : in    std_logic;
      gclk      : out   std_logic;
      lclk      : out   std_logic;
      gclk_div2 : out   std_logic;
      lclk_div2 : out   std_logic;
      lock      : out   std_logic
    );
  end component wrapper_pll_simple;

end package wrapper_pll_simple_pkg;

--------------------------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;

library iCE40UP;
  use iCE40UP.Components.all;

entity wrapper_pll is
  generic (
    divr      : string;
    divf      : string;
    divq      : string
  );
  port (
    rst       : in    std_logic;
    rclk      : in    std_logic;
    gclk      : out   std_logic;
    lclk      : out   std_logic;
    gclk_div2 : out   std_logic;
    lclk_div2 : out   std_logic;
    lock      : out   std_logic
  );
end entity wrapper_pll;

architecture struct of wrapper_pll is

  signal fb : std_logic;

begin

  U_PLL: component pll_b
    generic map (
      divr                            => divr,
      divf                            => divf,
      divq                            => divq,
      filter_range                    => "1",
      feedback_path                   => "SIMPLE",
      delay_adjustment_mode_feedback  => "FIXED",
      fda_feedback                    => "0",
      delay_adjustment_mode_relative  => "FIXED",
      fda_relative                    => "0",
      shiftreg_div_mode               => "0",
      pllout_select_porta             => "GENCLK",
      pllout_select_portb             => "GENCLK_HALF",
      enable_icegate_porta            => "0",
      enable_icegate_portb            => "0",
      external_divide_factor          => "NONE",
      test_mode                       => "0"
    )
    port map (
      reset_n       => not rst,
      referenceclk  => rclk,
      feedback      => fb,
      bypass        => '0',
      dynamicdelay0 => '0',
      dynamicdelay1 => '0',
      dynamicdelay2 => '0',
      dynamicdelay3 => '0',
      dynamicdelay4 => '0',
      dynamicdelay5 => '0',
      dynamicdelay6 => '0',
      dynamicdelay7 => '0',
      latch         => '0',
      sclk          => '0',
      sdi           => '0',
      sdo           => open,
      intfbout		  => fb,
      outcore       => lclk,
      outglobal     => gclk,
      outcoreb      => lclk_div2,
      outglobalb    => gclk_div2,
      lock          => lock
    );

end architecture struct;
