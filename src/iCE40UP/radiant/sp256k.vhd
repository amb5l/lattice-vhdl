--------------------------------------------------------------------------------
-- sp256k.vhd                                                                 --
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
  use ieee.numeric_std.all;

library iCE40UP;
  use iCE40UP.Components.all;

entity sp256k is
  port (
    clk      : in   std_logic;
    cs       : in   std_logic;
    we       : in   std_logic;
    mwe      : in   std_logic_vector(3 downto 0);
    addr     : in   std_logic_vector(13 downto 0);
    din      : in   std_logic_vector(15 downto 0);
    dout     : out  std_logic_vector(15 downto 0)
  );
end entity sp256k;

architecture infer of sp256k is

  type ram_t is array(0 to 16383) of std_logic_vector(15 downto 0);
  signal ram : ram_t;

  attribute syn_ramstyle : string;
  attribute syn_ramstyle of ram : signal is "no_rw_check";

begin

  process(clk)
    variable a : integer range 0 to 16383;
  begin
    if rising_edge(clk) then
      a := to_integer(unsigned(addr));
      if cs = '1' then
        for i in 0 to 3 loop
          dout <= ram(a);
          if we = '1' and mwe(i) = '1' then
            ram(a)(3+(i*4) downto i*4) <= din(3+(i*4) downto i*4);
          end if;
        end loop;
      end if;
    end if;
  end process;

end architecture infer;
