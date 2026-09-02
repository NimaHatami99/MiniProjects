----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.02.2021 16:31:52
-- Design Name: 
-- Module Name: avgfilt_tb - Behavioral
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
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity avgfilt_tb is
--  Port ( );
end avgfilt_tb;

architecture test of avgfilt_tb is
constant T : time := 1 us;
signal test_input : std_logic_vector (7 downto 0);
signal test_output : std_logic_vector (7 downto 0);
signal test_row , test_column : std_logic_vector (11 downto 0);
signal test_clk , test_start , test_reset , test_read_flag , test_done , read_en : std_logic;
component avgfilt is
port(      input : in STD_LOGIC_VECTOR (7 downto 0);
           row : in STD_LOGIC_VECTOR (11 downto 0);
           column : in STD_LOGIC_VECTOR (11 downto 0);
           clk : in STD_LOGIC;
           start : in STD_LOGIC;
           reset : in STD_LOGIC;
           read_flag : out STD_LOGIC;
           done : out STD_LOGIC;
           output : out STD_LOGIC_VECTOR (7 downto 0));
end component;
begin
uut: avgfilt port map(     input => test_input,
                           row => test_row,
                           column => test_column,
                           clk => test_clk,
                           start => test_start,
                           reset => test_reset,
                           read_flag => test_read_flag,
                           done => test_done,
                           output => test_output);
process
begin
test_clk <= '0';
wait for T/2;
test_clk <= '1';
wait for T/2;
end process;
process
begin
test_row <= X"13F";
test_column <= X"25D";
test_reset <= '1';
test_start <= '0';
read_en <= '0';
wait until falling_edge(test_clk);
test_reset <= '0';
wait until falling_edge(test_clk);
test_start <= '1';
wait for T/3;
read_en <= '1';
wait until falling_edge(test_clk);
test_start <= '0';
wait until rising_edge(test_done);
read_en <= '0';
wait until falling_edge(test_done);
assert false
    report"simulation completed"
severity failure;
end process;
read_input_vector : process(test_clk)
file input_text : text open read_mode is "E:\terme 7\FPGA\Prj1\B_input_vector.txt";
variable LI1 : line;
variable LI1_var : integer;
begin
if(test_clk'event and test_clk='1' and read_en='1') then
readline(input_text , LI1);
read(LI1,LI1_var);
test_input <= std_logic_vector(to_unsigned(LI1_var,8));
end if;
end process;
write_output_vector : process(test_clk)
file output_text : text open write_mode is "E:\terme 7\FPGA\Prj1\B_output_vector_avgfilt.txt";
variable LO1 : line;
begin
if(test_clk'event and test_clk='1' and test_read_flag='1' and test_done='0') then
write(LO1,to_integer(unsigned(test_output)));
writeline(output_text , LO1);
end if;
end process;
end test;
