library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top_DOUBLE1_stream is
port (
  buffer_histIN_V_din       : IN STD_LOGIC_VECTOR (31 downto 0);
  buffer_histIN_V_full_n    : OUT  STD_LOGIC;
  buffer_histIN_V_write     : IN STD_LOGIC;
  callcount_histIN          : OUT  STD_LOGIC_VECTOR (31 downto 0);
  callTime_histIN_V_dout    : OUT  STD_LOGIC_VECTOR (31 downto 0);
  callTime_histIN_V_empty_n : OUT  STD_LOGIC;
  callTime_histIN_V_read    : IN STD_LOGIC;

  histIN_dout    : OUT STD_LOGIC_VECTOR (31 downto 0);
  histIN_read    : IN  STD_LOGIC;
  histIN_empty_n : OUT STD_LOGIC;
      
  timeClock : IN STD_LOGIC_VECTOR (31 downto 0);
  clk_en    : IN STD_LOGIC;

  ap_clk : IN STD_LOGIC;
  ap_rst : IN STD_LOGIC);
end;


architecture behav of top_DOUBLE1_stream is

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

  component top_DOUBLE1_REPLAST_A
    port (
      ap_clk            : IN  STD_LOGIC;
      ap_rst            : IN  STD_LOGIC;
      a_input_V_dout    : IN  STD_LOGIC_VECTOR (31 downto 0);
      a_input_V_empty_n : IN  STD_LOGIC;
      a_input_V_read    : OUT STD_LOGIC;
      a_dout            : OUT STD_LOGIC_VECTOR (31 downto 0);
      a_empty_n         : OUT STD_LOGIC;
      a_read            : IN  STD_LOGIC;
      clk_en            : IN  STD_LOGIC);
  end component;

  signal callTime_histIN_V_din        : STD_LOGIC_VECTOR (31 downto 0);
  signal callTime_histIN_V_full_n     : STD_LOGIC;
  signal callTime_histIN_V_write      : STD_LOGIC;
  signal buffer_histIN_full           : STD_LOGIC;
  signal buffer_histIN_empty          : STD_LOGIC;
  signal buffer_callTime_histIN_full  : STD_LOGIC;
  signal buffer_callTime_histIN_empty : STD_LOGIC;

  signal histIN_input_V_dout    : STD_LOGIC_VECTOR (31 downto 0);
  signal histIN_input_V_empty_n : STD_LOGIC;
  signal histIN_input_V_read    : STD_LOGIC;
  
begin

    top_DOUBLE1_REPLAST_A_1: top_DOUBLE1_REPLAST_A
      port map (
        ap_clk            => ap_clk,
        ap_rst            => ap_rst,
        a_input_V_dout    => histIN_input_V_dout,
        a_input_V_empty_n => histIN_input_V_empty_n,
        a_input_V_read    => histIN_input_V_read,
        a_dout            => histIN_dout,
        a_empty_n         => histIN_empty_n,
        a_read            => histIN_read,
        clk_en            => clk_en);
    
    
 
    buffer_histIN_V_full_n <= not buffer_histIN_full;
    histIN_input_V_empty_n <= not buffer_histIN_empty;
      
    buffer_histIN: internal_fifo32
      port map (
        clk   => ap_clk,
        srst  => ap_rst,
        din   => buffer_histIN_V_din,
        wr_en => buffer_histIN_V_write,
        rd_en => histIN_input_V_read,
        dout  => histIN_input_V_dout,
        full  => buffer_histIN_full,
        empty => buffer_histIN_empty);

    callTime_histIN_V_full_n <= not buffer_callTime_histIN_full;
    callTime_histIN_V_empty_n <= not buffer_callTime_histIN_empty;
      
    buffer_callTime_histIN: internal_fifo32
      port map (
        clk   => ap_clk,
        srst  => ap_rst,
        din   => callTime_histIN_V_din,
        wr_en => callTime_histIN_V_write,
        rd_en => callTime_histIN_V_read,
        dout  => callTime_histIN_V_dout,
        full  => buffer_callTime_histIN_full,
        empty => buffer_callTime_histIN_empty);


    top_DOUBLE1_CALL_MON_1 : top_DOUBLE1_CALL_MON
      port map (
        ap_clk              => ap_clk,
        ap_rst              => ap_rst,
        timeClock           => timeClock,
        callcount_a         => callcount_histIN,
        trigger_a           => histIN_read,
        callTime_a_V_din    => callTime_histIN_V_din,
        callTime_a_V_full_n => callTime_histIN_V_full_n,
        callTime_a_V_write  => callTime_histIN_V_write);
    
end behav;
