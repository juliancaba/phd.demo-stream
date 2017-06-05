library IEEE;
use IEEE.std_logic_1164.all;

entity topTesting is
port (
    din_V_dout    : IN  STD_LOGIC_VECTOR (31 downto 0);
    din_V_empty_n : IN  STD_LOGIC;
    din_V_read    : OUT STD_LOGIC;
    dout_V_din    : OUT STD_LOGIC_VECTOR (31 downto 0);
    dout_V_full_n : IN  STD_LOGIC;
    dout_V_write  : OUT STD_LOGIC;
    
    flagRD : out STD_LOGIC;
    flagWR : out STD_LOGIC;
    
    clk_en    : in STD_LOGIC;
    timeClock : IN STD_LOGIC_VECTOR (31 downto 0);

    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC);
end;


architecture behav of topTesting is

  component top_CTRL
    port (
      din_V_dout                   : IN  STD_LOGIC_VECTOR (31 downto 0);
      din_V_empty_n                : IN  STD_LOGIC;
      din_V_read                   : OUT STD_LOGIC;
      dout_V_din                   : OUT STD_LOGIC_VECTOR (31 downto 0);
      dout_V_full_n                : IN  STD_LOGIC;
      dout_V_write                 : OUT STD_LOGIC;
      buffer_histIN_V_din          : OUT STD_LOGIC_VECTOR (31 downto 0);
      buffer_histIN_V_full_n       : IN  STD_LOGIC;
      buffer_histIN_V_write        : OUT STD_LOGIC;
      callCount_histIN             : IN  STD_LOGIC_VECTOR (31 downto 0);
      callTime_histIN_V_dout       : IN  STD_LOGIC_VECTOR (31 downto 0);
      callTime_histIN_V_empty_n    : IN  STD_LOGIC;
      callTime_histIN_V_read       : OUT STD_LOGIC;
      expect_histOUT_V_din         : OUT STD_LOGIC_VECTOR (31 downto 0);
      expect_histOUT_V_full_n      : IN  STD_LOGIC;
      expect_histOUT_V_write       : OUT STD_LOGIC;
      callCount_histOUT            : IN  STD_LOGIC_VECTOR (31 downto 0);
      callTime_histOUT_V_dout      : IN  STD_LOGIC_VECTOR (31 downto 0);
      callTime_histOUT_V_empty_n   : IN  STD_LOGIC;
      callTime_histOUT_V_read      : OUT STD_LOGIC;
      failCount_histOUT            : IN  STD_LOGIC_VECTOR (31 downto 0);
      fail_histOUT_V_dout          : IN  STD_LOGIC_VECTOR (159 downto 0);
      fail_histOUT_V_empty_n       : IN  STD_LOGIC;
      fail_histOUT_V_read          : OUT STD_LOGIC;
      intervalDelay_histOUT        : OUT STD_LOGIC_VECTOR (31 downto 0);
      intervalDelay_histOUT_ap_vld : OUT STD_LOGIC;
      ap_clk                       : IN  STD_LOGIC;
      ap_rst                       : IN  STD_LOGIC);
  end component;

  component top_DOUBLE1_stream
    port (
      buffer_histIN_V_din       : IN  STD_LOGIC_VECTOR (31 downto 0);
      buffer_histIN_V_full_n    : OUT STD_LOGIC;
      buffer_histIN_V_write     : IN  STD_LOGIC;
      callcount_histIN          : OUT STD_LOGIC_VECTOR (31 downto 0);
      callTime_histIN_V_dout    : OUT STD_LOGIC_VECTOR (31 downto 0);
      callTime_histIN_V_empty_n : OUT STD_LOGIC;
      callTime_histIN_V_read    : IN  STD_LOGIC;
      histIN_dout               : OUT STD_LOGIC_VECTOR (31 downto 0);
      histIN_read               : IN  STD_LOGIC;
      histIN_empty_n            : OUT STD_LOGIC;
      timeClock                 : IN  STD_LOGIC_VECTOR (31 downto 0);
      clk_en                    : in  STD_LOGIC;
      ap_clk                    : IN  STD_LOGIC;
      ap_rst                    : IN  STD_LOGIC);
  end component;

  component top_DOUBLE2_stream
    port (
      expect_histOUT_V_din         : IN  STD_LOGIC_VECTOR (31 downto 0);
      expect_histOUT_V_full_n      : OUT STD_LOGIC;
      expect_histOUT_V_write       : IN  STD_LOGIC;
      callCount_histOUT            : OUT STD_LOGIC_VECTOR (31 downto 0);
      callTime_histOUT_V_dout      : OUT STD_LOGIC_VECTOR (31 downto 0);
      callTime_histOUT_V_empty_n   : OUT STD_LOGIC;
      callTime_histOUT_V_read      : IN  STD_LOGIC;
      failCount_histOUT            : OUT STD_LOGIC_VECTOR (31 downto 0);
      fail_histOUT_V_dout          : OUT STD_LOGIC_VECTOR (159 downto 0);
      fail_histOUT_V_empty_n       : OUT STD_LOGIC;
      fail_histOUT_V_read          : IN  STD_LOGIC;
      intervalDelay_histOUT        : IN  STD_LOGIC_VECTOR (31 downto 0);
      intervalDelay_histOUT_ap_vld : IN  STD_LOGIC;
      histOUT_din                  : IN  STD_LOGIC_VECTOR (31 downto 0);
      histOUT_write                : IN  STD_LOGIC;
      histOUT_full_n               : OUT STD_LOGIC;
      timeClock                    : IN  STD_LOGIC_VECTOR (31 downto 0);
      ap_clk                       : IN  STD_LOGIC;
      ap_rst                       : IN  STD_LOGIC);
  end component;
  
  component l2norm is
    port (
      histIN_V_dout    : IN  STD_LOGIC_VECTOR (31 downto 0);
      histIN_V_empty_n : IN  STD_LOGIC;
      histIN_V_read    : OUT STD_LOGIC;
      histOUT_V_din    : OUT STD_LOGIC_VECTOR (31 downto 0);
      histOUT_V_full_n : IN  STD_LOGIC;
      histOUT_V_write  : OUT STD_LOGIC;
      ap_clk           : IN  STD_LOGIC;
      ap_rst           : IN  STD_LOGIC);
  end component l2norm;
  
  --component inc_stream is
  --  port (
  --    ap_clk    : IN  STD_LOGIC;
  --    ap_rst    : IN  STD_LOGIC;
  --    histIN_dout    : IN  STD_LOGIC_VECTOR (31 downto 0);
  --    histIN_empty_n : IN  STD_LOGIC;
  --    histIN_read    : OUT STD_LOGIC;
  --    histOUT_din     : OUT STD_LOGIC_VECTOR (31 downto 0);
  --    histOUT_full_n  : IN  STD_LOGIC;
  --    histOUT_write   : OUT STD_LOGIC);
  --end component inc_stream;


  signal buffer_histIN_V_din          : STD_LOGIC_VECTOR (31 downto 0);
  signal buffer_histIN_V_full_n       : STD_LOGIC;
  signal buffer_histIN_V_write        : STD_LOGIC;
  signal callCount_histIN             : STD_LOGIC_VECTOR (31 downto 0);
  signal callTime_histIN_V_dout       : STD_LOGIC_VECTOR (31 downto 0);
  signal callTime_histIN_V_empty_n    : STD_LOGIC;
  signal callTime_histIN_V_read       : STD_LOGIC;
  signal expect_histOUT_V_din         : STD_LOGIC_VECTOR (31 downto 0);
  signal expect_histOUT_V_full_n      : STD_LOGIC;
  signal expect_histOUT_V_write       : STD_LOGIC;
  signal callCount_histOUT            : STD_LOGIC_VECTOR (31 downto 0);
  signal callTime_histOUT_V_dout      : STD_LOGIC_VECTOR (31 downto 0);
  signal callTime_histOUT_V_empty_n   : STD_LOGIC;
  signal callTime_histOUT_V_read      : STD_LOGIC;
  signal failCount_histOUT            : STD_LOGIC_VECTOR (31 downto 0);
  signal fail_histOUT_V_dout          : STD_LOGIC_VECTOR (159 downto 0);
  signal fail_histOUT_V_empty_n       : STD_LOGIC;
  signal fail_histOUT_V_read          : STD_LOGIC;
  signal intervalDelay_histOUT        : STD_LOGIC_VECTOR (31 downto 0);
  signal intervalDelay_histOUT_ap_vld : STD_LOGIC;

  signal histIN_V_dout    : STD_LOGIC_VECTOR (31 downto 0);
  signal histIN_V_empty_n : STD_LOGIC;
  signal histIN_V_read    : STD_LOGIC;
  signal histOUT_V_din    : STD_LOGIC_VECTOR (31 downto 0);
  signal histOUT_V_full_n : STD_LOGIC;
  signal histOUT_V_write  : STD_LOGIC;
  
  --signal histIN_dout    : STD_LOGIC_VECTOR (31 downto 0);
  --signal histIN_empty_n : STD_LOGIC;
  --signal histIN_read    : STD_LOGIC;
  --signal histOUT_din     : STD_LOGIC_VECTOR (31 downto 0);
  --signal histOUT_full_n  : STD_LOGIC;
  --signal histOUT_write   : STD_LOGIC;

  --signal ap_clk_i    : STD_LOGIC;
  --signal ap_rst_i    : STD_LOGIC;
  --signal histIN_empty_n_i : STD_LOGIC;
  --signal histOUT_full_n_i  : STD_LOGIC;
  
begin

  flagRD <= '1' when histIN_V_read = '1' else '0';
  flagWR <= '1' when histOUT_V_write = '1' else '0';


  --ap_clk_i <= ap_clk when ap_clk_en = '1' else '0';
  --ap_rst_i <= ap_rst when ap_clk_en = '1' else '1';
  --histIN_empty_n_i <= histIN_empty_n when ap_clk_en = '1' else '0';
  --histOUT_full_n_i <= histOUT_full_n when ap_clk_en = '1' else '0';


  top_CTRL_1 : top_CTRL
    port map (
      din_V_dout                   => din_V_dout,
      din_V_empty_n                => din_V_empty_n,
      din_V_read                   => din_V_read,
      dout_V_din                   => dout_V_din,
      dout_V_full_n                => dout_V_full_n,
      dout_V_write                 => dout_V_write,
      buffer_histIN_V_din          => buffer_histIN_V_din,
      buffer_histIN_V_full_n       => buffer_histIN_V_full_n,
      buffer_histIN_V_write        => buffer_histIN_V_write,
      callCount_histIN             => callCount_histIN,
      callTime_histIN_V_dout       => callTime_histIN_V_dout,
      callTime_histIN_V_empty_n    => callTime_histIN_V_empty_n,
      callTime_histIN_V_read       => callTime_histIN_V_read,
      expect_histOUT_V_din         => expect_histOUT_V_din,
      expect_histOUT_V_full_n      => expect_histOUT_V_full_n,
      expect_histOUT_V_write       => expect_histOUT_V_write,
      callCount_histOUT            => callCount_histOUT,
      callTime_histOUT_V_dout      => callTime_histOUT_V_dout,
      callTime_histOUT_V_empty_n   => callTime_histOUT_V_empty_n,
      callTime_histOUT_V_read      => callTime_histOUT_V_read,
      failCount_histOUT            => failCount_histOUT,
      fail_histOUT_V_dout          => fail_histOUT_V_dout,
      fail_histOUT_V_empty_n       => fail_histOUT_V_empty_n,
      fail_histOUT_V_read          => fail_histOUT_V_read,
      intervalDelay_histOUT        => intervalDelay_histOUT,
      intervalDelay_histOUT_ap_vld => intervalDelay_histOUT_ap_vld,
      ap_clk                       => ap_clk,
      ap_rst                       => ap_rst);

  top_DOUBLE1_stream_1 : top_DOUBLE1_stream
    port map (
      buffer_histIN_V_din       => buffer_histIN_V_din,
      buffer_histIN_V_full_n    => buffer_histIN_V_full_n,
      buffer_histIN_V_write     => buffer_histIN_V_write,
      callcount_histIN          => callcount_histIN,
      callTime_histIN_V_dout    => callTime_histIN_V_dout,
      callTime_histIN_V_empty_n => callTime_histIN_V_empty_n,
      callTime_histIN_V_read    => callTime_histIN_V_read,
      histIN_dout               => histIN_V_dout,
      histIN_read               => histIN_V_read,
      histIN_empty_n            => histIN_V_empty_n,
      timeClock                 => timeClock,
      clk_en                    => clk_en,
      ap_clk                    => ap_clk,
      ap_rst                    => ap_rst);


  l2norm_1: l2norm
    port map (
      histIN_V_dout    => histIN_V_dout,
      histIN_V_empty_n => histIN_V_empty_n,
      histIN_V_read    => histIN_V_read,
      histOUT_V_din    => histOUT_V_din,
      histOUT_V_full_n => histOUT_V_full_n,
      histOUT_V_write  => histOUT_V_write,
      ap_clk           => ap_clk,
      ap_rst           => ap_rst);
  
  
  top_DOUBLE2_stream_1 : top_DOUBLE2_stream
    port map (
      expect_histOUT_V_din         => expect_histOUT_V_din,
      expect_histOUT_V_full_n      => expect_histOUT_V_full_n,
      expect_histOUT_V_write       => expect_histOUT_V_write,
      callCount_histOUT            => callCount_histOUT,
      callTime_histOUT_V_dout      => callTime_histOUT_V_dout,
      callTime_histOUT_V_empty_n   => callTime_histOUT_V_empty_n,
      callTime_histOUT_V_read      => callTime_histOUT_V_read,
      failCount_histOUT            => failCount_histOUT,
      fail_histOUT_V_dout          => fail_histOUT_V_dout,
      fail_histOUT_V_empty_n       => fail_histOUT_V_empty_n,
      fail_histOUT_V_read          => fail_histOUT_V_read,
      intervalDelay_histOUT        => intervalDelay_histOUT,
      intervalDelay_histOUT_ap_vld => intervalDelay_histOUT_ap_vld,
      histOUT_din                  => histOUT_V_din,
      histOUT_write                => histOUT_V_write,
      histOUT_full_n               => histOUT_V_full_n,
      timeClock                    => timeClock,
      ap_clk                       => ap_clk,
      ap_rst                       => ap_rst);

  
end behav;
