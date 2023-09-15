--------------------------------------------------------------------------------
-- mac16.vhd                                                                  --
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

entity mac16 is
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
end entity mac16;

architecture model of mac16 is

  signal cfg       : std_logic_vector(24 downto 0);
  signal c_i       : std_logic_vector(15 downto 0); -- raw inputs
  signal a_i       : std_logic_vector(15 downto 0);
  signal b_i       : std_logic_vector(15 downto 0);
  signal d_i       : std_logic_vector(15 downto 0);
  signal a_q       : std_logic_vector(15 downto 0); -- registered inputs
  signal b_q       : std_logic_vector(15 downto 0);
  signal c_q       : std_logic_vector(15 downto 0);
  signal d_q       : std_logic_vector(15 downto 0);
  signal a         : std_logic_vector(15 downto 0); -- raw or registered inputs
  signal b         : std_logic_vector(15 downto 0);
  signal c         : std_logic_vector(15 downto 0);
  signal d         : std_logic_vector(15 downto 0);
  signal ah_x_bh   : std_logic_vector(15 downto 0); -- 8x8 raw outputs
  signal al_x_bh   : std_logic_vector(15 downto 0); -- "
  signal ah_x_bl   : std_logic_vector(15 downto 0); -- "
  signal al_x_bl   : std_logic_vector(15 downto 0); -- "
  signal ah_x_bh_q : std_logic_vector(15 downto 0); -- 8x8 pipeline registers
  signal al_x_bh_q : std_logic_vector(15 downto 0); -- "
  signal ah_x_bl_q : std_logic_vector(15 downto 0); -- "
  signal al_x_bl_q : std_logic_vector(15 downto 0); -- "
  signal f         : std_logic_vector(15 downto 0); -- 8x8 raw or registered outputs
  signal j         : std_logic_vector(15 downto 0); -- "
  signal k         : std_logic_vector(15 downto 0); -- "
  signal g         : std_logic_vector(15 downto 0); -- "
  signal l         : std_logic_vector(31 downto 0); -- 16x16 raw output
  signal l_q       : std_logic_vector(31 downto 0); -- 16x16 registered output
  signal h         : std_logic_vector(31 downto 0); -- 16x16 raw or registered output
  signal w         : std_logic_vector(15 downto 0);
  signal x         : std_logic_vector(15 downto 0);
  signal y         : std_logic_vector(15 downto 0);
  signal z         : std_logic_vector(15 downto 0);
  signal hci       : std_logic_vector(0 downto 0);
  signal haccum    : std_logic_vector(16 downto 0);
  signal lci       : std_logic_vector(0 downto 0);
  signal laccum    : std_logic_vector(16 downto 0);
  signal laccumco  : std_logic;
  signal lco       : std_logic;
  signal p         : std_logic_vector(15 downto 0);
  signal q         : std_logic_vector(15 downto 0);
  signal r         : std_logic_vector(15 downto 0);
  signal s         : std_logic_vector(15 downto 0);
  signal o         : std_logic_vector(31 downto 0);    -- output vector
  signal zero      : std_logic := '0';

  function str_to_sl(s : string) return std_logic is
  begin
    if s = "0b0" then
      return '0';
    elsif s = "0b1" then
      return '1';
    else
      return 'X';
    end if;
  end function str_to_sl;

  function str_to_slv2(s : string) return std_logic_vector is
  begin
    if s = "0b00" then
      return "00";
    elsif s = "0b01" then
      return "01";
    elsif s = "0b10" then
      return "10";
    elsif s = "0b11" then
      return "11";
    else
      return "XX";
    end if;
  end function str_to_slv2;

  procedure reg_bus(
    neg_trigger : in  string;
    signal  rst : in  std_logic;
    signal  clk : in  std_logic;
    signal   ce : in  std_logic;
    signal hold : in  std_logic;
    signal    d : in  std_logic_vector;
    signal    q : out std_logic_vector
  ) is
  begin
    if rst = '1' then
      q <= (q'range => '0');
    elsif rst = '0' then
      if clk'event then
        if clk = '1' then
          if neg_trigger = "0b0" then
            if ce = '0' or hold = '1' then
              null;
            elsif ce = '1' and hold = '0' then
              q <= d;
            else
              q <= (q'range => 'X');
            end if;
          elsif neg_trigger = "0b1" then
            null;
          else
            q <= (q'range => 'X');
          end if;
        elsif clk = '0' then
          if neg_trigger = "0b1" then
            if ce = '0' or hold = '1' then
              null;
            elsif ce = '1' and hold = '0' then
              q <= d;
            else
              q <= (q'range => 'X');
            end if;
          elsif neg_trigger = "0b0" then
            null;
          else
            q <= (q'range => 'X');
          end if;
        else
          q <= (q'range => 'X');
        end if;
      end if;
    else
      q <= (q'range => 'X');
    end if;
  end procedure reg_bus;

begin

  -- configuration bits from generics
  cfg( 0)           <= str_to_sl(   c_reg                    );
  cfg( 1)           <= str_to_sl(   a_reg                    );
  cfg( 2)           <= str_to_sl(   b_reg                    );
  cfg( 3)           <= str_to_sl(   d_reg                    );
  cfg( 4)           <= str_to_sl(   top_8x8_mult_reg         );
  cfg( 5)           <= str_to_sl(   bot_8x8_mult_reg         );
  cfg( 6)           <= str_to_sl(   pipeline_16x16_mult_reg1 );
  cfg( 7)           <= str_to_sl(   pipeline_16x16_mult_reg2 );
  cfg( 9 downto  8) <= str_to_slv2( topoutput_select         );
  cfg(11 downto 10) <= str_to_slv2( topaddsub_lowerinput     );
  cfg(12)           <= str_to_sl(   topaddsub_upperinput     );
  cfg(14 downto 13) <= str_to_slv2( topaddsub_carryselect    );
  cfg(16 downto 15) <= str_to_slv2( botoutput_select         );
  cfg(18 downto 17) <= str_to_slv2( botaddsub_lowerinput     );
  cfg(19)           <= str_to_sl(   botaddsub_upperinput     );
  cfg(21 downto 20) <= str_to_slv2( botaddsub_carryselect    );
  cfg(22)           <= str_to_sl(   mode_8x8                 );
  cfg(23)           <= str_to_sl(   a_signed                 );
  cfg(24)           <= str_to_sl(   b_signed                 );

  -- inputs
  reg_bus(neg_trigger,irsttop,clk,ce,chold,c_i,c_q);
  reg_bus(neg_trigger,irsttop,clk,ce,ahold,a_i,a_q);
  reg_bus(neg_trigger,irstbot,clk,ce,bhold,b_i,b_q);
  reg_bus(neg_trigger,irstbot,clk,ce,dhold,d_i,d_q);
  c <= c_i when cfg(0) = '0' else c_q when cfg(0) = '1' else (others => 'X');
  a <= a_i when cfg(1) = '0' else a_q when cfg(1) = '1' else (others => 'X');
  b <= b_i when cfg(2) = '0' else b_q when cfg(2) = '1' else (others => 'X');
  d <= d_i when cfg(3) = '0' else d_q when cfg(3) = '1' else (others => 'X');

  -- 8x8
  process(a,b,cfg(24 downto 23))
    function mul8(
      x : std_logic_vector(7 downto 0);
      y : std_logic_vector(7 downto 0);
      xs : std_logic;
      ys : std_logic
    ) return std_logic_vector is
      variable x9 : signed(8 downto 0);
      variable y9 : signed(8 downto 0);
      variable m  : signed(17 downto 0);
    begin
      x9(7 downto 0) := signed(x);
      x9(8) := xs and x(7);
      y9(7 downto 0) := signed(y);
      y9(8) := ys and y(7);
      m := x9*y9;
      return std_logic_vector(m(15 downto 0));
    end function mul8;
    variable al : std_logic_vector(7 downto 0);
    variable ah : std_logic_vector(7 downto 0);
    variable bl : std_logic_vector(7 downto 0);
    variable bh : std_logic_vector(7 downto 0);
  begin
    al := a(7 downto 0);
    ah := a(15 downto 8);
    bl := b(7 downto 0);
    bh := b(15 downto 8);
    ah_x_bh <= mul8(ah,bh,cfg(23),cfg(24));
    al_x_bh <= mul8(al,bh,'0',cfg(24));
    ah_x_bl <= mul8(ah,bl,cfg(23),'0');
    al_x_bl <= mul8(al,bl,cfg(22) and cfg(23),cfg(22) and cfg(24));
  end process;
  reg_bus(neg_trigger,irsttop,clk,ce,zero   ,ah_x_bh,ah_x_bh_q);
  reg_bus(neg_trigger,irsttop,clk,ce,cfg(22),al_x_bh,al_x_bh_q);
  reg_bus(neg_trigger,irstbot,clk,ce,cfg(22),ah_x_bl,ah_x_bl_q);
  reg_bus(neg_trigger,irstbot,clk,ce,zero   ,al_x_bl,al_x_bl_q);
  f <= ah_x_bh when cfg(4) = '0' else ah_x_bh_q when cfg(4) = '1' else (others => 'X');
  j <= al_x_bh when cfg(4) = '0' else al_x_bh_q when cfg(6) = '1' else (others => 'X');
  k <= ah_x_bl when cfg(4) = '0' else ah_x_bl_q when cfg(6) = '1' else (others => 'X');
  g <= al_x_bl when cfg(4) = '0' else al_x_bl_q when cfg(5) = '1' else (others => 'X');

  -- 16x16
  process(f,j,k,g)
    variable jx : unsigned(23 downto 0);
    variable kx : unsigned(23 downto 0);
    variable s  : unsigned(31 downto 0);
  begin
    jx(15 downto 0)  := unsigned(j);
    jx(23 downto 16) := (others => cfg(24) and j(15));
    kx(15 downto 0)  := unsigned(k);
    kx(23 downto 16) := (others => cfg(23) and k(15));
    s :=
      shift_left(resize(unsigned(f),32),16) +
      shift_left(resize(jx,32),8) +
      shift_left(resize(kx,32),8) +
      resize(unsigned(g),32);
    l <= std_logic_vector(s);
  end process;
  reg_bus(neg_trigger,irstbot,clk,ce,cfg(22),l,l_q);
  h <= l when cfg(7) = '0' else l_q when cfg(7) = '1' else (others => 'X');

  -- top accumulator
  w <= q when cfg(12) = '0' else c when cfg(12) = '1' else (others => 'X');
  with cfg(11 downto 10) select x <=
    a                     when "00",
    f                     when "01",
    h(31 downto 16)       when "10",
    (others => z(15))     when "11",
    (others => 'X')       when others;
  with cfg(14 downto 13) select hci(0) <=
    '0'      when "00",
    '1'      when "01",
    laccumco when "10",
    lco      when "11",
    'X'      when others;
  haccum <=
    std_logic_vector(resize(unsigned(w),17)+resize(unsigned(x),17)+resize(unsigned(hci),17)) when addsubtop = '0' else
    std_logic_vector(resize(unsigned(w),17)-resize(unsigned(x),17)-resize(unsigned(hci),17)) when addsubtop = '1' else
    (others => 'X');
  accumco <= haccum(16);
  co <=
        haccum(16) when addsubtop = '0' else
    not haccum(16) when addsubtop = '1' else
    'X';
  signextout <= x(15);
  p <= haccum(15 downto 0) when oloadtop = '0' else c when oloadtop = '1' else (others => 'X');
  reg_bus(neg_trigger,orsttop,clk,ce,oholdtop,p,q);
  with cfg(9 downto 8) select o(31 downto 16) <=
    p               when "00",
    q               when "01",
    f               when "10",
    h(31 downto 16) when "11",
    (others => 'X') when others;

  -- bottom accumulator
  y <= s when cfg(12) = '0' else d when cfg(12) = '1' else (others => 'X');
  with cfg(18 downto 17) select z <=
    b                     when "00",
    g                     when "01",
    h(15 downto 0)        when "10",
    (others => signextin) when "11",
    (others => 'X')       when others;
  with cfg(21 downto 20) select lci(0) <=
    '0'     when "00",
    '1'     when "01",
    accumci when "10",
    ci      when "11",
    'X'     when others;
  laccum <=
    std_logic_vector(resize(unsigned(y),17)+resize(unsigned(z),17)+resize(unsigned(lci),17)) when addsubtop = '0' else
    std_logic_vector(resize(unsigned(y),17)-resize(unsigned(z),17)-resize(unsigned(lci),17)) when addsubtop = '1' else
    (others => 'X');
  laccumco <= laccum(16);
  lco <=
        laccum(16) when addsubbot = '0' else
    not laccum(16) when addsubbot = '1' else
    'X';
  r <= laccum(15 downto 0) when oloadbot = '0' else d when oloadbot = '1' else (others => 'X');
  reg_bus(neg_trigger,orstbot,clk,ce,oholdbot,r,s);
  with cfg(16 downto 15) select o(15 downto 0) <=
    r               when "00",
    s               when "01",
    g               when "10",
    h(15 downto 0)  when "11",
    (others => 'X') when others;

  -- vector stuffing and unstuffing
  a_i(0)   <= a0;
  a_i(1)   <= a1;
  a_i(2)   <= a2;
  a_i(3)   <= a3;
  a_i(4)   <= a4;
  a_i(5)   <= a5;
  a_i(6)   <= a6;
  a_i(7)   <= a7;
  a_i(8)   <= a8;
  a_i(9)   <= a9;
  a_i(10) <= a10;
  a_i(11) <= a11;
  a_i(12) <= a12;
  a_i(13) <= a13;
  a_i(14) <= a14;
  a_i(15) <= a15;
  b_i(0)   <= b0;
  b_i(1)   <= b1;
  b_i(2)   <= b2;
  b_i(3)   <= b3;
  b_i(4)   <= b4;
  b_i(5)   <= b5;
  b_i(6)   <= b6;
  b_i(7)   <= b7;
  b_i(8)   <= b8;
  b_i(9)   <= b9;
  b_i(10) <= b10;
  b_i(11) <= b11;
  b_i(12) <= b12;
  b_i(13) <= b13;
  b_i(14) <= b14;
  b_i(15) <= b15;
  c_i(0)   <= c0;
  c_i(1)   <= c1;
  c_i(2)   <= c2;
  c_i(3)   <= c3;
  c_i(4)   <= c4;
  c_i(5)   <= c5;
  c_i(6)   <= c6;
  c_i(7)   <= c7;
  c_i(8)   <= c8;
  c_i(9)   <= c9;
  c_i(10) <= c10;
  c_i(11) <= c11;
  c_i(12) <= c12;
  c_i(13) <= c13;
  c_i(14) <= c14;
  c_i(15) <= c15;
  d_i(0)   <= d0;
  d_i(1)   <= d1;
  d_i(2)   <= d2;
  d_i(3)   <= d3;
  d_i(4)   <= d4;
  d_i(5)   <= d5;
  d_i(6)   <= d6;
  d_i(7)   <= d7;
  d_i(8)   <= d8;
  d_i(9)   <= d9;
  d_i(10) <= d10;
  d_i(11) <= d11;
  d_i(12) <= d12;
  d_i(13) <= d13;
  d_i(14) <= d14;
  d_i(15) <= d15;
  o0     <= o(0);
  o1     <= o(1);
  o2     <= o(2);
  o3     <= o(3);
  o4     <= o(4);
  o5     <= o(5);
  o6     <= o(6);
  o7     <= o(7);
  o8     <= o(8);
  o9     <= o(9);
  o10    <= o(10);
  o11    <= o(11);
  o12    <= o(12);
  o13    <= o(13);
  o14    <= o(14);
  o15    <= o(15);
  o16    <= o(16);
  o17    <= o(17);
  o18    <= o(18);
  o19    <= o(19);
  o20    <= o(20);
  o21    <= o(21);
  o22    <= o(22);
  o23    <= o(23);
  o24    <= o(24);
  o25    <= o(25);
  o26    <= o(26);
  o27    <= o(27);
  o28    <= o(28);
  o29    <= o(29);
  o30    <= o(30);
  o31    <= o(31);

end architecture model;
