----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.11.2020 16:06:33
-- Design Name: 
-- Module Name: div88_tb - Behavioral
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

entity div88_tb is
--  Port ( );
end div88_tb;

architecture Behavioral of div88_tb is
signal clr : std_logic := '0';
signal clk : std_logic := '0';
signal start : std_logic := '0';
signal A : std_logic_vector(7 downto 0) := (others => '0');
signal B : std_logic_vector(7 downto 0) := (others => '0');
signal Q : std_logic_vector(7 downto 0);
signal R : std_logic_vector(7 downto 0);
constant T : time := 100 ns;
begin
uut : entity work.div88(behavioral)
port map(   clr => clr,
            clk => clk,
            start => start,
            A => A,
            B => B,
            Q => Q,
            R => R
            );
process
begin
clk <= '0';
wait for T/2;
clk <= '1';
wait for T/2;
end process;
clr <= '1' , '0' after 50 ns;
start <= '0' , '1' after 70 ns;
process
begin
A <= "11111111";
B <= "00000001";
wait;
end process;
end Behavioral;
