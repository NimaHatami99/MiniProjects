----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.11.2020 23:45:58
-- Design Name: 
-- Module Name: accumulator - arch
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

entity accumulator is
    Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           b : in STD_LOGIC_VECTOR (7 downto 0);
           n : in STD_LOGIC_VECTOR (7 downto 0);
           y : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           start : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (15 downto 0);
           done : out STD_LOGIC);
end accumulator;

architecture arch of accumulator is
signal clr_div , start_div , divisible , begin_en : std_logic;
signal d , q : std_logic_vector (7 downto 0);
signal rect , sum : signed(23 downto 0);
signal ds , qs : signed(7 downto 0);
signal count : integer := 0;
begin
ds <= signed(b) - signed(a);
d <= std_logic_vector(ds);
qs <= signed(q);
division : entity work.div88(Behavioral)
port map (  A => d,
            B => n,
            Q => q,
            start => start_div,
            clr => clr_div,
            divisible => divisible,
            clk => clk);
process(clk,divisible,start)
begin
if(start='0') then
sum <= (others => '0');
clr_div <= '1';
start_div <= '0';
count <= 0;
begin_en <= '0';
elsif(start='1') then
clr_div <= '0';
start_div <= '1';
end if;
if(divisible='1' and clk'event and clk='1') then
sum <= sum + rect;
if(rect /= X"000000") then
begin_en <= '1';
end if;
if(begin_en='1') then
count <= count + 1;
end if;
end if;
end process;
rect <= qs * signed(y);
output <= std_logic_vector(sum(15 downto 0));
done <= '1' when ( y = X"0000" and sum /= X"000000" and count >= signed(n) ) else '0';
end arch;
