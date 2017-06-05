library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top_DOUBLE2_stream is
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

    histOUT_din    : IN  STD_LOGIC_VECTOR (31 downto 0);
    histOUT_write  : IN  STD_LOGIC;
    histOUT_full_n : OUT STD_LOGIC;

    timeClock : IN STD_LOGIC_VECTOR (31 downto 0);

    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC);
end;


architecture behav of top_DOUBLE2_stream is
  
  component top_DOUBLE1_CALL_MON
    port (
      ap_clk              : IN  STD_LOGIC;
      ap_rst              : IN  STD_LOGIC;
      timeClock           : IN  STD_LOGIC_VECTOR (31 downto 0);
      callcount_a         : OUT STD_LOGIC_VECTOR (31 downto 0);
      trigger_a           : IN  STD_LOGIC;
      callTime_a_V_din    : OUT STD_LOGIC_VECTOR (31 downto 0);
      callTime_a_V_full_n : IN  STD_LOGIC;
      callTime_a_V_write  : OUT STD_LOGIC);
  end component;

  component top_DOUBLE2_EXPECT_MON
    port (
      ap_clk               : IN  STD_LOGIC;
      ap_rst               : IN  STD_LOGIC;
      intervalDelay_a      : IN  STD_LOGIC_VECTOR (31 downto 0);
      failcount_a          : OUT STD_LOGIC_VECTOR (31 downto 0);
      buffer_a_V_dout      : IN  STD_LOGIC_VECTOR (31 downto 0);
      buffer_a_V_empty_n   : IN  STD_LOGIC;
      buffer_a_V_read      : OUT STD_LOGIC;
      callTime_a_V_dout    : IN  STD_LOGIC_VECTOR (31 downto 0);
      callTime_a_V_empty_n : IN  STD_LOGIC;
      callTime_a_V_read    : OUT STD_LOGIC;
      expect_a_V_dout      : IN  STD_LOGIC_VECTOR (31 downto 0);
      expect_a_V_empty_n   : IN  STD_LOGIC;
      expect_a_V_read      : OUT STD_LOGIC;
      fail_a_V_din         : OUT STD_LOGIC_VECTOR (159 downto 0);
      fail_a_V_full_n      : IN  STD_LOGIC;
      fail_a_V_write       : OUT STD_LOGIC);
  end component top_DOUBLE2_EXPECT_MON;
  
  --component top_DOUBLE2_EXPECT_MON
  --  port (
  --    ap_clk             : IN  STD_LOGIC;
  --    ap_rst             : IN  STD_LOGIC;
  --    timeClock          : IN  STD_LOGIC_VECTOR (31 downto 0);
  --    intervalDelay_a    : IN  STD_LOGIC_VECTOR (31 downto 0);
  --    failcount_a        : OUT STD_LOGIC_VECTOR (31 downto 0);
  --    buffer_a_V_dout    : IN  STD_LOGIC_VECTOR (31 downto 0);
  --    buffer_a_V_empty_n : IN  STD_LOGIC;
  --    buffer_a_V_read    : OUT STD_LOGIC;
  --    expect_a_V_dout    : IN  STD_LOGIC_VECTOR (31 downto 0);
  --    expect_a_V_empty_n : IN  STD_LOGIC;
  --    expect_a_V_read    : OUT STD_LOGIC;
  --    fail_a_V_din       : OUT STD_LOGIC_VECTOR (159 downto 0);
  --    fail_a_V_full_n    : IN  STD_LOGIC;
  --    fail_a_V_write     : OUT STD_LOGIC);
  --end component;
  
  component internal_fifo32
    port (
      clk   : IN  STD_LOGIC;
      srst  : IN  STD_LOGIC;
      din   : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
      wr_en : IN  STD_LOGIC;
      rd_en : IN  STD_LOGIC;
      dout  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      full  : OUT STD_LOGIC;
      empty : OUT STD_LOGIC);
  end component;
  
  component internal_fifo160
    port (
      clk   : IN  STD_LOGIC;
      srst  : IN  STD_LOGIC;
      din   : IN  STD_LOGIC_VECTOR(159 DOWNTO 0);
      wr_en : IN  STD_LOGIC;
      rd_en : IN  STD_LOGIC;
      dout  : OUT STD_LOGIC_VECTOR(159 DOWNTO 0);
      full  : OUT STD_LOGIC;
      empty : OUT STD_LOGIC);
  end component;

  component top_REG_1 is
    port (
      ap_clk    : IN  STD_LOGIC;
      ap_rst    : IN  STD_LOGIC;
      input_r   : IN  STD_LOGIC_VECTOR (31 downto 0);
      input_vld : IN  STD_LOGIC;
      output_r  : OUT STD_LOGIC_VECTOR (31 downto 0));
  end component top_REG_1;

  signal buffer_histOUT_V_dout    : STD_LOGIC_VECTOR (31 downto 0);
  signal buffer_histOUT_V_empty_n : STD_LOGIC;
  signal buffer_histOUT_V_read    : STD_LOGIC;
  signal buffer_histOUT_full      : STD_LOGIC;
  signal buffer_histOUT_empty     : STD_LOGIC;
  
  signal expect_histOUT_V_dout       : STD_LOGIC_VECTOR (31 downto 0);
  signal expect_histOUT_V_empty_n    : STD_LOGIC;
  signal expect_histOUT_V_read       : STD_LOGIC;
  signal buffer_expect_histOUT_full  : STD_LOGIC;
  signal buffer_expect_histOUT_empty : STD_LOGIC;
  
  signal callTime_histOUT_V_din        : STD_LOGIC_VECTOR (31 downto 0);
  signal callTime_histOUT_V_full_n     : STD_LOGIC;
  signal callTime_histOUT_V_write      : STD_LOGIC;
  signal buffer_callTime_histOUT_full  : STD_LOGIC;
  signal buffer_callTime_histOUT_empty : STD_LOGIC;
  
  signal fail_histOUT_V_din        : STD_LOGIC_VECTOR (159 downto 0);
  signal fail_histOUT_V_full_n     : STD_LOGIC;
  signal fail_histOUT_V_write      : STD_LOGIC;
  signal buffer_fail_histOUT_full  : STD_LOGIC;
  signal buffer_fail_histOUT_empty : STD_LOGIC;
  
  
  signal callTime_histOUT_mon_dout    : STD_LOGIC_VECTOR (31 downto 0);
  signal callTime_histOUT_mon_read    : STD_LOGIC;
  signal callTime_histOUT_mon_full    : STD_LOGIC;
  signal callTime_histOUT_mon_full_n  : STD_LOGIC;
  signal callTime_histOUT_mon_empty   : STD_LOGIC;
  signal callTime_histOUT_mon_empty_n : STD_LOGIC;
  
  signal intervalDelay_histOUT_i      : STD_LOGIC_VECTOR (31 downto 0);
  
begin

  top_REG_1_1: top_REG_1
    port map (
      ap_clk    => ap_clk,
      ap_rst    => ap_rst,
      input_r   => intervalDelay_histOUT,
      input_vld => intervalDelay_histOUT_ap_vld,
      output_r  => intervalDelay_histOUT_i);

    histOUT_full_n <= not buffer_histOUT_full;
    buffer_histOUT_V_empty_n <= not buffer_histOUT_empty;
    
    buffer_histOUT: internal_fifo32
      port map (
        clk   => ap_clk,
        srst  => ap_rst,
        din   => histOUT_din,
        wr_en => histOUT_write,
        rd_en => buffer_histOUT_V_read,
        dout  => buffer_histOUT_V_dout,
        full  => buffer_histOUT_full,
        empty => buffer_histOUT_empty);

  
    expect_histOUT_V_full_n <= not buffer_expect_histOUT_full;
    expect_histOUT_V_empty_n <= not buffer_expect_histOUT_empty;
  
    buffer_expect_histOUT: internal_fifo32
      port map (
        clk   => ap_clk,
        srst  => ap_rst,
        din   => expect_histOUT_V_din,
        wr_en => expect_histOUT_V_write,
        rd_en => expect_histOUT_V_read,
        dout  => expect_histOUT_V_dout,
        full  => buffer_expect_histOUT_full,
        empty => buffer_expect_histOUT_empty);

  
    callTime_histOUT_V_full_n <= not buffer_callTime_histOUT_full;
    callTime_histOUT_V_empty_n <= not buffer_callTime_histOUT_empty;
      
    buffer_callTime_histOUT: internal_fifo32
      port map (
        clk   => ap_clk,
        srst  => ap_rst,
        din   => callTime_histOUT_V_din,
        wr_en => callTime_histOUT_V_write,
        rd_en => callTime_histOUT_V_read,
        dout  => callTime_histOUT_V_dout,
        full  => buffer_callTime_histOUT_full,
        empty => buffer_callTime_histOUT_empty);
  
    callTime_histOUT_mon_full_n <= not callTime_histOUT_mon_full;
    callTime_histOUT_mon_empty_n <= not callTime_histOUT_mon_empty;
      
    buffer_callTime_histOUT_mon : internal_fifo32
      port map (
        clk   => ap_clk,
        srst  => ap_rst,
        din   => callTime_histOUT_V_din,
        wr_en => callTime_histOUT_V_write,
        rd_en => callTime_histOUT_mon_read,
        dout  => callTime_histOUT_mon_dout,
        full  => callTime_histOUT_mon_full,
        empty => callTime_histOUT_mon_empty);
  
    top_DOUBLE2_CALL_MON_1: top_DOUBLE1_CALL_MON
      port map (
        ap_clk              => ap_clk,
        ap_rst              => ap_rst,
        timeClock           => timeClock,
        callcount_a         => callcount_histOUT,
        trigger_a           => histOUT_write,  
        callTime_a_V_din    => callTime_histOUT_V_din,
        callTime_a_V_full_n => callTime_histOUT_V_full_n,
        callTime_a_V_write  => callTime_histOUT_V_write);


  top_DOUBLE2_EXPECT_MON_2: top_DOUBLE2_EXPECT_MON
    port map (
      ap_clk               => ap_clk,
      ap_rst               => ap_rst,
      intervalDelay_a    => intervalDelay_histOUT_i,
      failcount_a        => failcount_histOUT,
      buffer_a_V_dout    => buffer_histOUT_V_dout,
      buffer_a_V_empty_n => buffer_histOUT_V_empty_n,
      buffer_a_V_read    => buffer_histOUT_V_read,      
      callTime_a_V_dout    => callTime_histOUT_mon_dout,
      callTime_a_V_empty_n => callTime_histOUT_mon_empty_n,
      callTime_a_V_read    => callTime_histOUT_mon_read,      
      expect_a_V_dout    => expect_histOUT_V_dout,
      expect_a_V_empty_n => expect_histOUT_V_empty_n,
      expect_a_V_read    => expect_histOUT_V_read,
      fail_a_V_din       => fail_histOUT_V_din,
      fail_a_V_full_n    => fail_histOUT_V_full_n,
      fail_a_V_write     => fail_histOUT_V_write);
      

    --top_DOUBLE2_EXPECT_MON_2: top_DOUBLE2_EXPECT_MON
    --  port map (
    --    ap_clk             => ap_clk,
    --    ap_rst             => ap_rst,
    --    timeClock          => timeClock,
    --    intervalDelay_a    => intervalDelay_histOUT_i,
    --    failcount_a        => failcount_histOUT,
    --    buffer_a_V_dout    => buffer_histOUT_V_dout,
    --    buffer_a_V_empty_n => buffer_histOUT_V_empty_n,
    --    buffer_a_V_read    => buffer_histOUT_V_read,
    --    expect_a_V_dout    => expect_histOUT_V_dout,
    --    expect_a_V_empty_n => expect_histOUT_V_empty_n,
    --    expect_a_V_read    => expect_histOUT_V_read,
    --    fail_a_V_din       => fail_histOUT_V_din,
    --    fail_a_V_full_n    => fail_histOUT_V_full_n,
    --    fail_a_V_write     => fail_histOUT_V_write);

  fail_histOUT_V_empty_n <= not buffer_fail_histOUT_empty;
  fail_histOUT_V_full_n <= not buffer_fail_histOUT_full;
  
  buffer_fail_histOUT: internal_fifo160
      port map (
        clk   => ap_clk,
        srst  => ap_rst,
        din   => fail_histOUT_V_din,
        wr_en => fail_histOUT_V_write,
        rd_en => fail_histOUT_V_read,
        dout  => fail_histOUT_V_dout,
        full  => buffer_fail_histOUT_full,
        empty => buffer_fail_histOUT_empty);
    
end behav;
