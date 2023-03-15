--------------------------------------------------------------------------------
-- wrapper_rgbpwm.vhd                                                         --
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

package wrapper_rgbpwm_pkg is

  component wrapper_rgbpwm is
    port (
      leddclk : in    std_logic;
      leddcs  : in    std_logic;
      leddden : in    std_logic;
      leddadr : in    std_logic_vector( 3 downto 0 );
      ledddat : in    std_logic_vector( 7 downto 0 );
      leddexe : in    std_logic;
      leddon  : out   std_logic;
      pwmout  : out   std_logic_vector( 0     to 2 )
    );
  end component wrapper_rgbpwm;

end package wrapper_rgbpwm_pkg;

--------------------------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;

library iCE40UP;
  use iCE40UP.Components.all;

entity wrapper_rgbpwm is
  port (
    leddclk : in    std_logic;
    leddcs  : in    std_logic;
    leddden : in    std_logic;
    leddadr : in    std_logic_vector( 3 downto 0 );
    ledddat : in    std_logic_vector( 7 downto 0 );
    leddexe : in    std_logic;
    leddon  : out   std_logic;
    pwmout  : out   std_logic_vector( 0     to 2 )
  );
end entity wrapper_rgbpwm;

architecture struct of wrapper_rgbpwm is
begin

  U_RGBPWM: component rgbpwm
    port map (
      leddclk   => leddclk,
      leddden   => leddden,
      leddcs    => leddcs,
      leddaddr0 => leddadr(0),
      leddaddr1 => leddadr(1),
      leddaddr2 => leddadr(2),
      leddaddr3 => leddadr(3),
      ledddat0  => ledddat(0),
      ledddat1  => ledddat(1),
      ledddat2  => ledddat(2),
      ledddat3  => ledddat(3),
      ledddat4  => ledddat(4),
      ledddat5  => ledddat(5),
      ledddat6  => ledddat(6),
      ledddat7  => ledddat(7),
      leddexe   => leddexe,
      leddon    => leddon,
      pwmout0   => pwmout(0),
      pwmout1   => pwmout(1),
      pwmout2   => pwmout(2)
    );

end architecture struct;
