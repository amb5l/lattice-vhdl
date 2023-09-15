-- shows that EBR is read-before-write

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

library std;
  use std.env.finish;

library iCE40UP;
  use iCE40UP.Components.all;

library work;
  use work.iCE40UP_wrappers.all;

entity tb_ebr is
end entity tb_ebr;

architecture sim of tb_ebr is

  signal clk    : std_logic;

  signal raddr  : std_logic_vector(10 downto 0);
  signal waddr  : std_logic_vector(10 downto 0);
  signal wdata  : std_logic_vector(15 downto 0);
  signal re     : std_logic;
  signal we     : std_logic;
  signal rdata  : std_logic_vector(15 downto 0);

begin

  clk <=
    '1' after 5 ns when clk = '0' else
    '0' after 5 ns when clk = '1' else
    '0';

  process
  begin
    we    <= '0';
    waddr <= (others => '0');
    wdata <= (others => '0');
    re    <= '0';
    raddr <= (others => '0');
    wait until rising_edge(clk);
    we <= '1';
    re <= '1';
    loop
      waddr <= std_logic_vector((unsigned(waddr)+1) mod 4);
      wdata <= "00000" & waddr;
      raddr <= std_logic_vector((unsigned(raddr)+1) mod 3);
      wait until rising_edge(clk);
      if now > 1 uS then
        finish;
      end if;
    end loop;
  end process;

  DUT: component wrapper_ebr
    generic map (
      data_width_w => "16",
      data_width_r => "16"
    )
    port map (
      raddr => raddr,
      waddr => waddr,
      mask  => (others => '0'),
      wdata => wdata,
      rclke => '1',
      rclk  => clk,
      re    => re,
      wclke => '1',
      wclk  => clk,
      we    => we,
      rdata => rdata
    );

end architecture sim;
