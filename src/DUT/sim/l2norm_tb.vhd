-------------------------------------------------------------------------------
-- Title      : Testbench for design "l2norm"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : l2norm_tb.vhd
-- Author     : julian  <julian@ichbiach>
-- Company    : 
-- Created    : 2016-06-02
-- Last update: 2017-01-30
-- Platform   : 
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2016 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2016-06-02  1.0      julian	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity l2norm_tb is

end l2norm_tb;

-------------------------------------------------------------------------------

architecture test of l2norm_tb is

  component l2norm is
    port (
      histIN_V_dout    : IN  STD_LOGIC_VECTOR (31 downto 0);
      histIN_V_empty_n : IN  STD_LOGIC;
      histIN_V_read    : OUT STD_LOGIC;
      histOUT_V_din    : OUT STD_LOGIC_VECTOR (31 downto 0);
      histOUT_V_full_n : IN  STD_LOGIC;
      histOUT_V_write  : OUT STD_LOGIC;
      ap_clk         : IN  STD_LOGIC;
      ap_rst         : IN  STD_LOGIC);
  end component l2norm;

  -- component ports
  signal histIN_V_dout    : STD_LOGIC_VECTOR (31 downto 0);
  signal histIN_V_empty_n : STD_LOGIC;
  signal histIN_V_read    : STD_LOGIC;
  signal histOUT_V_din    : STD_LOGIC_VECTOR (31 downto 0);
  signal histOUT_V_full_n : STD_LOGIC;
  signal histOUT_V_write  : STD_LOGIC;

  
  signal ap_clk        : STD_LOGIC := '0';
  signal ap_rst        : STD_LOGIC;


begin  -- test

  -- component instantiation
  DUT: l2norm
    port map (
      histIN_V_dout    => histIN_V_dout,
      histIN_V_empty_n => histIN_V_empty_n,
      histIN_V_read    => histIN_V_read,
      histOUT_V_din    => histOUT_V_din,
      histOUT_V_full_n => histOUT_V_full_n,
      histOUT_V_write  => histOUT_V_write,
      ap_clk         => ap_clk,
      ap_rst         => ap_rst);
  
  -- clock generation
  ap_Clk <= not ap_Clk after 10 ns;
  ap_rst <= '1', '0' after 20 ns;

  -- waveform generation
  WaveGen_Proc: process
  begin
    -- insert signal assignments here
    histIN_V_dout    <= (others => '0');
    histIN_V_empty_n <= '0';
    histOUT_V_full_n <= '1';
    
    wait for 50 ns;
    wait until ap_Clk = '1';

    
    histIN_V_dout    <= X"00000000";       --0.0 (IEEE 754)
    histIN_V_empty_n <= '1';
    wait until ap_clk = '0';
    if histIN_V_read = '0' then
      wait until histIN_V_read = '1';      
    end if;
    wait until ap_clk = '1' and ap_clk'event;


    
    histIN_V_dout    <= X"3f800000";       --1.0 (IEEE 754)
    histIN_V_empty_n <= '1';
    wait until ap_clk = '0';
    if histIN_V_read = '0' then
      wait until histIN_V_read = '1';      
    end if;
    wait until ap_clk = '1' and ap_clk'event;

    
    histIN_V_dout    <= X"40000000";       --2.0 (IEEE 754)
    histIN_V_empty_n <= '1';
    wait until ap_clk = '0';
    if histIN_V_read = '0' then
      wait until histIN_V_read = '1';      
    end if;
    wait until ap_clk = '1' and ap_clk'event;

    histIN_V_dout    <= X"40400000";       --3.0 (IEEE 754)
    histIN_V_empty_n <= '1';
    wait until ap_clk = '0';
    if histIN_V_read = '0' then
      wait until histIN_V_read = '1';      
    end if;
    wait until ap_clk = '1' and ap_clk'event;

    histIN_V_dout    <= X"40800000";       --4.0 (IEEE 754)
    histIN_V_empty_n <= '1';
    wait until ap_clk = '0';
    if histIN_V_read = '0' then
      wait until histIN_V_read = '1';      
    end if;
    wait until ap_clk = '1' and ap_clk'event;


    histIN_V_dout    <= X"40a00000";       --5.0 (IEEE 754)
    histIN_V_empty_n <= '1';
    wait until ap_clk = '0';
    if histIN_V_read = '0' then
      wait until histIN_V_read = '1';      
    end if;
    wait until ap_clk = '1' and ap_clk'event;

    
    histIN_V_dout    <= X"40c00000";       --6.0 (IEEE 754)
    histIN_V_empty_n <= '1';
    wait until ap_clk = '0';
    if histIN_V_read = '0' then
      wait until histIN_V_read = '1';      
    end if;
    wait until ap_clk = '1' and ap_clk'event;

    
    histIN_V_dout    <= X"40e00000";       --7.0 (IEEE 754)
    histIN_V_empty_n <= '1';
    wait until ap_clk = '0';
    if histIN_V_read = '0' then
      wait until histIN_V_read = '1';      
    end if;
    wait until ap_clk = '1' and ap_clk'event;

    
    histIN_V_dout    <= X"41000000";       --8.0 (IEEE 754)
    histIN_V_empty_n <= '1';
    wait until ap_clk = '0';
    if histIN_V_read = '0' then
      wait until histIN_V_read = '1';      
    end if;
    wait until ap_clk = '1' and ap_clk'event;

        
    histIN_V_dout    <= X"41100000";       --9.0 (IEEE 754)
    histIN_V_empty_n <= '1';
    wait until ap_clk = '0';
    if histIN_V_read = '0' then
      wait until histIN_V_read = '1';      
    end if;
    wait until ap_clk = '1' and ap_clk'event;

        
    histIN_V_dout    <= X"41200000";       --10.0 (IEEE 754)
    histIN_V_empty_n <= '1';
    wait until ap_clk = '0';
    if histIN_V_read = '0' then
      wait until histIN_V_read = '1';      
    end if;
    wait until ap_clk = '1' and ap_clk'event;

        
    histIN_V_dout    <= X"41300000";       --11.0 (IEEE 754)
    histIN_V_empty_n <= '1';
    wait until ap_clk = '0';
    if histIN_V_read = '0' then
      wait until histIN_V_read = '1';      
    end if;
    wait until ap_clk = '1' and ap_clk'event;
    
    histIN_V_dout    <= X"41400000";       --12.0 (IEEE 754)
    histIN_V_empty_n <= '1';
    wait until ap_clk = '0';
    if histIN_V_read = '0' then
      wait until histIN_V_read = '1';      
    end if;
    wait until ap_clk = '1' and ap_clk'event;
    
    histIN_V_dout    <= X"41500000";       --13.0 (IEEE 754)
    histIN_V_empty_n <= '1';
    wait until ap_clk = '0';
    if histIN_V_read = '0' then
      wait until histIN_V_read = '1';      
    end if;
    wait until ap_clk = '1' and ap_clk'event;

        
    histIN_V_dout    <= X"41600000";       --14.0 (IEEE 754)
    histIN_V_empty_n <= '1';
    wait until ap_clk = '0';
    if histIN_V_read = '0' then
      wait until histIN_V_read = '1';      
    end if;
    wait until ap_clk = '1' and ap_clk'event;
    
    histIN_V_dout    <= X"41700000";       --15.0 (IEEE 754)
    histIN_V_empty_n <= '1';
    wait until ap_clk = '0';
    if histIN_V_read = '0' then
      wait until histIN_V_read = '1';      
    end if;
    wait until ap_clk = '1' and ap_clk'event;


    histIN_V_dout <= (others => '0');
    histIN_V_empty_n <= '0';
    
    
    wait;
  end process WaveGen_Proc;

  

end test;
