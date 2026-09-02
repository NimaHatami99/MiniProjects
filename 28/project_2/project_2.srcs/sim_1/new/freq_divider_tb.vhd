----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.11.2020 13:08:16
-- Design Name: 
-- Module Name: freq_divider_tb - Behavioral
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

entity freq_divider_tb is
--  Port ( );
generic(K : integer := 8);
end freq_divider_tb;

architecture Behavioral of freq_divider_tb is
signal clk : std_logic := '0';
signal reset : std_logic := '0';
signal clk_out : std_logic;
signal n : std_logic_vector(K-1 downto 0);
constant T : time := 20 ns;
begin 
uut : entity work.freq_divider(Behavioral)
port map (      clk => clk,
                n => n,
                reset => reset,
                clk_out => clk_out);
process
begin
clk <= '0';
wait for T/2;
clk <= '1';
wait for T/2;
end process;
process
begin
n <= X"02";
reset <= '1';
wait for 40 ns;
reset <= '0';
for i in 1 to 3 loop
wait until falling_edge(clk_out);
end loop;
n <= X"03";
reset <= '1';
wait for 40 ns;
wait until falling_edge(clk);
reset <= '0';
for i in 1 to 3 loop
wait until falling_edge(clk_out);
end loop;
assert false
    report "Simulation Completed"
severity failure;
end process;
end Behavioral;
