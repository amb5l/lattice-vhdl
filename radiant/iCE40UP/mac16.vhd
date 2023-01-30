-- mac16.vhd
-- simple VHDL model for simulation purposes only

library ieee;
use ieee.std_logic_1164.all;

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

  subtype u8 is unsigned(7 downto 0);

  signal cfg       : std_logic_vector(24 downto 0);

  signal ci        : std_logic_vector(15 downto 0); -- raw inputs
  signal ai        : std_logic_vector(15 downto 0);
  signal bi        : std_logic_vector(15 downto 0);
  signal di        : std_logic_vector(15 downto 0);

  signal ai_q      : std_logic_vector(15 downto 0); -- registered inputs
  signal bi_q      : std_logic_vector(15 downto 0);
  signal ci_q      : std_logic_vector(15 downto 0);
  signal di_q      : std_logic_vector(15 downto 0);

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

  signal o         : std_logic_vector(31 downto 0);    -- output vector

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
  end function str_to_sl;

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
      q <= (others => '0');
    elsif clk'event and ce = '1' then
      if (neg_trigger = "0b0" and clk = '1')
      or (neg_trigger = "0b1" and clk = '0')
      then
        q <= d;
      else
        q <= (others => 'X');
    end if;
  end procedure;

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
  reg_bus(neg_trigger,irsttop,clk,ce,chold,ci,ci_q);
  reg_bus(neg_trigger,irsttop,clk,ce,ahold,ai,ai_q);
  reg_bus(neg_trigger,irstbot,clk,ce,bhold,bi,bi_q);
  reg_bus(neg_trigger,irstbot,clk,ce,dhold,di,di_q);
  c <= ci when cfg(0) = '0' else ci_q when cfg(0) = '1' else (others => 'X');
  a <= ai when cfg(1) = '0' else ai_q when cfg(1) = '1' else (others => 'X');
  b <= bi when cfg(2) = '0' else bi_q when cfg(2) = '1' else (others => 'X');
  d <= di when cfg(3) = '0' else di_q when cfg(3) = '1' else (others => 'X');

  -- 8x8
  ah_x_bh <= std_logic_vector(unsigned(a(15 downto 8))*unsigned(b(15 downto 8)));
  al_x_bh <= std_logic_vector(unsigned(a( 7 downto 0))*unsigned(b(15 downto 8)));
  ah_x_bl <= std_logic_vector(unsigned(a(15 downto 8))*unsigned(b( 7 downto 0)));
  al_x_bl <= std_logic_vector(unsigned(a( 7 downto 0))*unsigned(b( 7 downto 0)));
  reg_bus(neg_trigger,irsttop,clk,ce,zero   ,ax_x_bx,ax_x_bx_q);
  reg_bus(neg_trigger,irsttop,clk,ce,cfg(22),ax_x_bx,ax_x_bx_q);
  reg_bus(neg_trigger,irstbot,clk,ce,cfg(22),ax_x_bx,ax_x_bx_q);
  reg_bus(neg_trigger,irstbot,clk,ce,zero   ,ax_x_bx,ax_x_bx_q);
  f <= ah_x_bh when cfg(4) = '0' else ax_x_bx_q when cfg(4) = '1' else (others => 'X');
  j <= al_x_bh when cfg(4) = '0' else ax_x_bx_q when cfg(6) = '1' else (others => 'X');
  k <= ah_x_bl when cfg(4) = '0' else ax_x_bx_q when cfg(6) = '1' else (others => 'X');
  g <= al_x_bl when cfg(4) = '0' else ax_x_bx_q when cfg(5) = '1' else (others => 'X');

  -- 16x16
  process(mux_f,mux_j,mux_k,mux_g,ppc12,ppc23)
    variable fh : u8;
    variable fl : u8;
    variable jh : u8;
    variable jl : u8;
    variable kh : u8;
    variable kl : u8;
    variable gh : u8;
    variable gl : u8;
    variable s1 : unsigned(8 downto 0);
    variable s2 : unsigned(8 downto 0);
    variable s3 : unsigned(7 downto 0);
  begin
    fh := unsigned(mux_f(15 downto 8));
    fl := unsigned(mux_f( 7 downto 0));
    jh := unsigned(mux_j(15 downto 8));
    jl := unsigned(mux_j( 7 downto 0));
    kh := unsigned(mux_k(15 downto 8));
    kl := unsigned(mux_k( 7 downto 0));
    gh := unsigned(mux_g(15 downto 8));
    gl := unsigned(mux_g( 7 downto 0));
    s1 := jl + kl + gh;
    s2 := fl + jh + kh + s1(8 downto 8);
    s3 := fh + s2(8 downto 8);
    l <= std_logic_vector(s3 & s2(7 downto 0) & s1(7 downto 0) & gl);
  end process;
  reg_bus(neg_trigger,irstbot,clk,ce,c(22),l,l_q);
  h <= l when cfg(7) = '0' else l_q when cfg(7) = '1' else (others => 'X');

  -- accumulators
  w <= q when when cfg(12) = '0' else c when cfg(12) = '1' else (others => 'X');
  with cfg(11 downto 10) select x <=
    a                     when "00",
    f                     when "01",
    h(31 downto 16)       when "10",
    (others => z(15))     when "11",
    (others => 'X')       when others;
  y <= s when when cfg(12) = '0' else d when cfg(12) = '1' else (others => 'X');
  with cfg(18 downto 17) select z <=
    b                     when "00",
    g                     when "01",
    h(15 downto 0)        when "10",
    (others => signextin) when "11",
    (others => 'X')       when others;
  with cfg(14 downto 13) select hci <=
    "0"      when "00",
    "1"      when "01",
    laccumco when "10",
    lco      when "11",
    "X"      when others;
  w_addsub_x <=
    std_logic_vector(unsigned(w)+unsigned(x)+hci) when addsubtop = '0' else
    std_logic_vector(unsigned(w)-unsigned(x)-hci) when addsubtop = '1' else
    (others => 'X');
  co <=
        w_addsub_x(16) when addsubtop = '0' else
    not w_addsub_x(16) when addsubtop = '1' else
    'X';
  accumco <= w_addsub_x(16);
  signextout <= x(15);
  with cfg(21 downto 20) select lci <=
    "0"     when "00",
    "1"     when "01",
    accumci when "10",
    ci      when "11",
    "X"     when others;
  y_addsub_z <=
    std_logic_vector(unsigned(y)+unsigned(z)+lci) when addsubbot = '0' else
    std_logic_vector(unsigned(y)-unsigned(z)-lci) when addsubbot = '1' else
    (others => 'X');
  lco <=
        y_addsub_z(16) when addsubbot = '0' else
    not y_addsub_z(16) when addsubbot = '1' else
    'X';
  laccumco <= y_addsub_z(16);
  p <= w_addsub_x when oloadtop = '0' else c when oloadtop = '1' else (others => 'X');
  r <= y_addsub_z when oloadbot = '0' else d when oloadbot = '1' else (others => 'X');
  reg_bus(neg_trigger,orsttop,clk,ce,oholdtop,p,q);
  reg_bus(neg_trigger,orstbot,clk,ce,oholdbot,r,s);
  with cfg(9 downto 8) select o(31 downto 16) <=
    p               when "00",
    q               when "01",
    f               when "10",
    h(31 downto 16) when "11",
    (others => 'X') when others;
  with cfg(16 downto 15) select o(15 downto 0) <=
    r               when "00",
    s               when "01",
    g               when "10",
    h(15 downto 0)  when "11",
    (others => 'X') when others;

  -- vector stuffing and unstuffing
  ai(0)   <= a0;
  ai(1)   <= a1;
  ai(2)   <= a2;
  ai(3)   <= a3;
  ai(4)   <= a4;
  ai(5)   <= a5;
  ai(6)   <= a6;
  ai(7)   <= a7;
  ai(8)   <= a8;
  ai(9)   <= a9;
  ai(10) <= a10;
  ai(11) <= a11;
  ai(12) <= a12;
  ai(13) <= a13;
  ai(14) <= a14;
  ai(15) <= a15;
  bi(0)   <= b0;
  bi(1)   <= b1;
  bi(2)   <= b2;
  bi(3)   <= b3;
  bi(4)   <= b4;
  bi(5)   <= b5;
  bi(6)   <= b6;
  bi(7)   <= b7;
  bi(8)   <= b8;
  bi(9)   <= b9;
  bi(10) <= b10;
  bi(11) <= b11;
  bi(12) <= b12;
  bi(13) <= b13;
  bi(14) <= b14;
  bi(15) <= b15;
  ci(0)   <= c0;
  ci(1)   <= c1;
  ci(2)   <= c2;
  ci(3)   <= c3;
  ci(4)   <= c4;
  ci(5)   <= c5;
  ci(6)   <= c6;
  ci(7)   <= c7;
  ci(8)   <= c8;
  ci(9)   <= c9;
  ci(10) <= c10;
  ci(11) <= c11;
  ci(12) <= c12;
  ci(13) <= c13;
  ci(14) <= c14;
  ci(15) <= c15;
  di(0)   <= d0;
  di(1)   <= d1;
  di(2)   <= d2;
  di(3)   <= d3;
  di(4)   <= d4;
  di(5)   <= d5;
  di(6)   <= d6;
  di(7)   <= d7;
  di(8)   <= d8;
  di(9)   <= d9;
  di(10) <= d10;
  di(11) <= d11;
  di(12) <= d12;
  di(13) <= d13;
  di(14) <= d14;
  di(15) <= d15;
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
