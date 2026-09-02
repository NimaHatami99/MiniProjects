----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.12.2020 23:11:04
-- Design Name: 
-- Module Name: ACC - Behavioral
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ACC is
    Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           b : in STD_LOGIC_VECTOR (7 downto 0);
           n : in STD_LOGIC_VECTOR (7 downto 0);
           y : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           start : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (15 downto 0);
           done : out STD_LOGIC);
end ACC;

architecture arch of ACC is
signal q : std_logic_vector (7 downto 0);
signal rect , sum : signed(23 downto 0);
signal ds , qs : signed(7 downto 0);
signal count : integer := 0;
begin
ds <= signed(b) - signed(a);
q <= std_logic_vector(to_signed(to_integer(ds / signed(n)),8));
qs <= signed(q);
process(clk,start)
begin
if(start'event and start='0') then
sum <= (others => '0');
elsif(start = '1') then
if( clk'event and clk='1') then
sum <= sum + rect;
end if;
end if;
end process;
process(y,start)
begin
if (y'event) then
count <= count + 1;
elsif( start='0' ) then
count <= 0;
end if;
end process;
rect <= qs * signed(y);
output <= std_logic_vector(sum(15 downto 0));
done <= '1' when ( y = X"0000" and sum /= X"000000" and count >= signed(n) ) else '0';
end arch;