----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.11.2020 11:59:19
-- Design Name: 
-- Module Name: freq_devider - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity freq_divider is
    generic(K : integer := 8);
    Port ( clk : in STD_LOGIC;
           n : in STD_LOGIC_VECTOR (K-1 downto 0);
           reset : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end freq_divider;

architecture Behavioral of freq_divider is
signal count : integer := 0;
signal temp : std_logic := '0';
begin
process(clk , reset)
begin
if( reset = '1' ) then
count <= 0;
temp <= '0';
elsif( rising_edge(clk) ) then
count <= count + 1;
if( count = to_integer(signed(n))-1 ) then
temp <= not temp;
count <= 0;
end if;
end if;
if( reset = '1' ) then
count <= 0;
temp <= '0';
elsif( falling_edge(clk) ) then
count <= count + 1;
if( count = to_integer(signed(n))-1 ) then
temp <= not temp;
count <= 0;
end if;
end if;
end process;
clk_out <= temp;
end Behavioral;
