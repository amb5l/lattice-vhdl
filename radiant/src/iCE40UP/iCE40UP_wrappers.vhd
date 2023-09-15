--------------------------------------------------------------------------------
-- iCE40UP_wrappers.vhd                                                       --
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

package iCE40UP_wrappers is

  component wrapper_mac16 is
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
      a                        : in    std_logic_vector(15 downto 0);
      b                        : in    std_logic_vector(15 downto 0);
      c                        : in    std_logic_vector(15 downto 0);
      d                        : in    std_logic_vector(15 downto 0);
      o                        : out   std_logic_vector(31 downto 0);
      co                       : out   std_logic;
      accumco                  : out   std_logic;
      signextout               : out   std_logic
    );
  end component wrapper_mac16;

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
    port (
      pwm     : in    std_logic_vector(0 to 2);
      led     : out   std_logic_vector(0 to 2)
    );
  end component wrapper_rgb;

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

end package iCE40UP_wrappers;

--------------------------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;

library iCE40UP;
  use iCE40UP.Components.all;

entity wrapper_mac16 is
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
    a                        : in    std_logic_vector(15 downto 0);
    b                        : in    std_logic_vector(15 downto 0);
    c                        : in    std_logic_vector(15 downto 0);
    d                        : in    std_logic_vector(15 downto 0);
    o                        : out   std_logic_vector(31 downto 0);
    co                       : out   std_logic;
    accumco                  : out   std_logic;
    signextout               : out   std_logic
  );
end entity wrapper_mac16;

architecture struct of wrapper_mac16 is
begin

  U_MAC16: component mac16
    generic map (
      neg_trigger              => neg_trigger,
      a_reg                    => a_reg,
      b_reg                    => b_reg,
      c_reg                    => c_reg,
      d_reg                    => d_reg,
      top_8x8_mult_reg         => top_8x8_mult_reg,
      bot_8x8_mult_reg         => bot_8x8_mult_reg,
      pipeline_16x16_mult_reg1 => pipeline_16x16_mult_reg1,
      pipeline_16x16_mult_reg2 => pipeline_16x16_mult_reg2,
      topoutput_select         => topoutput_select,
      topaddsub_lowerinput     => topaddsub_lowerinput,
      topaddsub_upperinput     => topaddsub_upperinput,
      topaddsub_carryselect    => topaddsub_carryselect,
      botoutput_select         => botoutput_select,
      botaddsub_lowerinput     => botaddsub_lowerinput,
      botaddsub_upperinput     => botaddsub_upperinput,
      botaddsub_carryselect    => botaddsub_carryselect,
      mode_8x8                 => mode_8x8,
      a_signed                 => a_signed,
      b_signed                 => b_signed
    )
    port map (
      clk        => clk,
      ce         => ce,
      ahold      => ahold,
      bhold      => bhold,
      chold      => chold,
      dhold      => dhold,
      irsttop    => irsttop,
      irstbot    => irstbot,
      orsttop    => orsttop,
      orstbot    => orstbot,
      oloadtop   => oloadtop,
      oloadbot   => oloadbot,
      addsubtop  => addsubtop,
      addsubbot  => addsubbot,
      oholdtop   => oholdtop,
      oholdbot   => oholdbot,
      ci         => ci,
      accumci    => accumci,
      signextin  => signextin,
      a0         => a(0),
      a1         => a(1),
      a2         => a(2),
      a3         => a(3),
      a4         => a(4),
      a5         => a(5),
      a6         => a(6),
      a7         => a(7),
      a8         => a(8),
      a9         => a(9),
      a10        => a(10),
      a11        => a(11),
      a12        => a(12),
      a13        => a(13),
      a14        => a(14),
      a15        => a(15),
      b0         => b(0),
      b1         => b(1),
      b2         => b(2),
      b3         => b(3),
      b4         => b(4),
      b5         => b(5),
      b6         => b(6),
      b7         => b(7),
      b8         => b(8),
      b9         => b(9),
      b10        => b(10),
      b11        => b(11),
      b12        => b(12),
      b13        => b(13),
      b14        => b(14),
      b15        => b(15),
      c0         => c(0),
      c1         => c(1),
      c2         => c(2),
      c3         => c(3),
      c4         => c(4),
      c5         => c(5),
      c6         => c(6),
      c7         => c(7),
      c8         => c(8),
      c9         => c(9),
      c10        => c(10),
      c11        => c(11),
      c12        => c(12),
      c13        => c(13),
      c14        => c(14),
      c15        => c(15),
      d0         => d(0),
      d1         => d(1),
      d2         => d(2),
      d3         => d(3),
      d4         => d(4),
      d5         => d(5),
      d6         => d(6),
      d7         => d(7),
      d8         => d(8),
      d9         => d(9),
      d10        => d(10),
      d11        => d(11),
      d12        => d(12),
      d13        => d(13),
      d14        => d(14),
      d15        => d(15),
      o0         => o(0),
      o1         => o(1),
      o2         => o(2),
      o3         => o(3),
      o4         => o(4),
      o5         => o(5),
      o6         => o(6),
      o7         => o(7),
      o8         => o(8),
      o9         => o(9),
      o10        => o(10),
      o11        => o(11),
      o12        => o(12),
      o13        => o(13),
      o14        => o(14),
      o15        => o(15),
      o16        => o(16),
      o17        => o(17),
      o18        => o(18),
      o19        => o(19),
      o20        => o(20),
      o21        => o(21),
      o22        => o(22),
      o23        => o(23),
      o24        => o(24),
      o25        => o(25),
      o26        => o(26),
      o27        => o(27),
      o28        => o(28),
      o29        => o(29),
      o30        => o(30),
      o31        => o(31),
      co         => co,
      accumco    => accumco,
      signextout => signextout
    );

end architecture struct;

--------------------------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;

library iCE40UP;
  use iCE40UP.Components.all;

entity wrapper_pll_simple is
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
end entity wrapper_pll_simple;

architecture struct of wrapper_pll_simple is

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

--------------------------------------------------------------------------------
