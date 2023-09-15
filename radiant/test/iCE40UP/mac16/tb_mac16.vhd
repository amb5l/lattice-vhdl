library ieee;
  use ieee.std_logic_1164.all;

library iCE40UP_model;
  use iCE40UP_model.Components.all;

library iCE40UP_vendor;
  use iCE40UP_vendor.Components.all;

library work;
  use work.wrapper_mac16_pkg.all;

entity tb_mac16 is
end entity tb_mac16;

architecture sim of tb_mac16 is

  signal clk   : std_logic;
  signal rst   : std_logic;
  signal orst  : std_logic;
  signal ce    : std_logic;
  signal ihold : std_logic;
  signal a     : std_logic_vector(15 downto 0);
  signal b     : std_logic_vector(15 downto 0);
  signal o1    : std_logic_vector(31 downto 0);
  signal o2    : std_logic_vector(31 downto 0);

begin

  clk <=
    '1' after 5 ns when clk = '0' else
    '0' after 5 ns when clk = '1' else
    '0';

  ce <= '1';
  ihold <= '0';
  a <= x"0001";
  b <= x"0001";

  process
  begin
    rst <= '1';
    orst <= '1';
    wait for 10 ns;
    rst <= '0';
    wait for 20 ns;
    orst <= '0';    
    wait;
  end process;

  -- our model
  DUT_1: component wrapper_mac16
    generic map (
      neg_trigger              => "0b0",
      a_reg                    => "0b1",
      b_reg                    => "0b1",
      c_reg                    => "0b1",
      d_reg                    => "0b1",
      top_8x8_mult_reg         => "0b1",
      bot_8x8_mult_reg         => "0b1",
      pipeline_16x16_mult_reg1 => "0b1",
      pipeline_16x16_mult_reg2 => "0b1",
      topoutput_select         => "0b00", -- P
      topaddsub_lowerinput     => "0b10", -- H
      topaddsub_upperinput     => "0b0",  -- Q
      topaddsub_carryselect    => "0b10", -- from lower adder
      botoutput_select         => "0b00", -- R
      botaddsub_lowerinput     => "0b10", -- H
      botaddsub_upperinput     => "0b0",  -- S
      botaddsub_carryselect    => "0b00", -- zero
      mode_8x8                 => "0b0",
      a_signed                 => "0b1",
      b_signed                 => "0b1"
    )
    port map(
      clk                      => clk,
      ce                       => ce,
      ahold                    => ihold,
      bhold                    => ihold,
      chold                    => '1',
      dhold                    => '1',
      irsttop                  => rst,
      irstbot                  => rst,
      orsttop                  => orst,
      orstbot                  => orst,
      oloadtop                 => '0',
      oloadbot                 => '0',
      addsubtop                => '0',
      addsubbot                => '0',
      oholdtop                 => '0',
      oholdbot                 => '0',
      ci                       => '0',
      accumci                  => '0',
      signextin                => '0',
      a                        => a,
      b                        => b,
      c                        => (others => '0'),
      d                        => (others => '0'),
      o                        => o1,
      co                       => open,
      accumco                  => open,
      signextout               => open
    );

  -- vendor model
  DUT_2: component wrapper_mac16
    generic map (
      neg_trigger              => "0b0",
      a_reg                    => "0b1",
      b_reg                    => "0b1",
      c_reg                    => "0b1",
      d_reg                    => "0b1",
      top_8x8_mult_reg         => "0b1",
      bot_8x8_mult_reg         => "0b1",
      pipeline_16x16_mult_reg1 => "0b1",
      pipeline_16x16_mult_reg2 => "0b1",
      topoutput_select         => "0b00", -- P
      topaddsub_lowerinput     => "0b10", -- H
      topaddsub_upperinput     => "0b0",  -- Q
      topaddsub_carryselect    => "0b10", -- from lower adder
      botoutput_select         => "0b00", -- R
      botaddsub_lowerinput     => "0b10", -- H
      botaddsub_upperinput     => "0b0",  -- S
      botaddsub_carryselect    => "0b00", -- zero
      mode_8x8                 => "0b0",
      a_signed                 => "0b1",
      b_signed                 => "0b1"
    )
    port map(
      clk                      => clk,
      ce                       => ce,
      ahold                    => ihold,
      bhold                    => ihold,
      chold                    => '1',
      dhold                    => '1',
      irsttop                  => rst,
      irstbot                  => rst,
      orsttop                  => orst,
      orstbot                  => orst,
      oloadtop                 => '0',
      oloadbot                 => '0',
      addsubtop                => '0',
      addsubbot                => '0',
      oholdtop                 => '0',
      oholdbot                 => '0',
      ci                       => '0',
      accumci                  => '0',
      signextin                => '0',
      a                        => a,
      b                        => b,
      c                        => (others => '0'),
      d                        => (others => '0'),
      o                        => o2,
      co                       => open,
      accumco                  => open,
      signextout               => open
    );

end architecture sim;
