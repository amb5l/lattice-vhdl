--------------------------------------------------------------------------------
-- wrapper_rgb.vhd                                                            --
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

package wrapper_rgb_pkg is

  constant RGB_CURRENT_FULL : string := "0";
  constant RGB_CURRENT_HALF : string := "1";
  constant RGB_CURRENT_0mA  : string := "0b000000";
  constant RGB_CURRENT_4mA  : string := "0b000001";
  constant RGB_CURRENT_8mA  : string := "0b000011";
  constant RGB_CURRENT_12mA : string := "0b000111";
  constant RGB_CURRENT_16mA : string := "0b001111";
  constant RGB_CURRENT_20mA : string := "0b011111";
  constant RGB_CURRENT_24mA : string := "0b111111";

  component wrapper_rgb is
    generic (
      mode    : string;
      current : string
    );
    port(
      pwm     : in    std_logic_vector(0 to 2);
      led     : out   std_logic_vector(0 to 2)
    );
  end component wrapper_rgb;

end package wrapper_rgb_pkg;

--------------------------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;

library iCE40UP;
  use iCE40UP.Components.all;

entity wrapper_rgb is
  generic (
    mode    : string;
    current : string
  );
  port(
    pwm     : in    std_logic_vector(0 to 2);
    led     : out   std_logic_vector(0 to 2)
  );
end entity wrapper_rgb;

architecture struct of wrapper_rgb is
begin

  U_RGB: component rgb
    generic map (
      current_mode => mode,
      rgb0_current => current,
      rgb1_current => current,
      rgb2_current => current
    )
    port map (
      curren       => '1',
      rgbleden     => '1',
      rgb0pwm      => pwm(0),
      rgb1pwm      => pwm(1),
      rgb2pwm      => pwm(2),
      rgb0         => led(0),
      rgb1         => led(1),
      rgb2         => led(2)
    );

end architecture struct;
