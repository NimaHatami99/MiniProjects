----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.12.2020 09:12:18
-- Design Name: 
-- Module Name: testbench1 - test
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testbench1 is
generic(    
            ADDR_WIDTH : integer := 12;
            DATA_WIDTH : integer := 16);
--  Port ( );
end testbench1;

architecture test of testbench1 is
constant T : time := 1 us;
signal test_address : std_logic_vector(11 downto 0);
signal test_re , test_CPU_Flag , test_clk , test_done , test_reset : std_logic;
signal test_data : std_logic_vector(15 downto 0);
begin
dut: entity work.CPU(Behavioral)
port map (  address => test_address,
            re => test_re,
            CPU_Flag => test_CPU_Flag,
            clk => test_clk,
            done => test_done,
            data => test_data,
            reset => test_reset);
--uut: entity work.Memory(structural)
--generic map (   ADDR_WIDTH => 12 , DATA_WIDTH => 16 );
--port map (  address => test_address,
--            re => test_re,
--            CPU_Flag => test_CPU_Flag,
--            clk => test_clk,
--            done => test_done,
--            data => test_data);
end test;
