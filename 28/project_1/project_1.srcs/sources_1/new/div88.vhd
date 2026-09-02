----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.11.2020 00:04:12
-- Design Name: 
-- Module Name: div88 - Behavioral
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
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity div88 is
    Port ( clr : in STD_LOGIC;
           clk : in STD_LOGIC;
           start : in STD_LOGIC;
           divisible : out STD_LOGIC;
           A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Q : out STD_LOGIC_VECTOR (7 downto 0);
           R : out STD_LOGIC_VECTOR (7 downto 0));
end div88;

architecture Behavioral of div88 is
type state_type is (sx_in , sx_proc , sx_done);
signal state_now , state_next : state_type;
signal B_zero , M : std_logic;
signal x_now , x_next , y_now , y_next , z_now , n_now , n_next : std_logic_vector(7 downto 0);
begin
U0 : entity work.sub8(Behavioral)
port map ( A => x_now,
            B => y_now,
            R => z_now,
            Z => M);
process(clr,clk)
begin
if clr='1' then
x_now <= (others => '0');
y_now <= (others => '0');
n_now <= (others => '0');
state_now <= sx_in;
elsif clk'event and clk='1' then
state_now <= state_next;
x_now <= x_next;
y_now <= y_next;
n_now <= n_next;
end if;
end process;
B_zero <= B(7) or B(6) or B(5) or B(4) or B(3) or B(2) or B(1) or B(0);
process(start , A , B , state_now , x_now , y_now , n_now , B_zero , M , z_now)
begin
state_next <= state_now;
x_next <= x_now;
y_next <= y_now;
n_next <= n_now;
case state_now is
when sx_in =>
Q <= (others => '0');
R <= (others => '0');
if start = '1' then
if B_zero = '1' then
x_next <= A;
y_next <= B;
n_next <= X"00";
state_next <= sx_proc;
end if;
end if;
when sx_proc =>
Q <= n_now;
R <= x_now;
if M='1' then
x_next <= x_now;
n_next <= n_now;
state_next <= sx_done;
else
x_next <= z_now;
n_next <= n_now + 1 ;
end if;
when sx_done =>
Q <= n_now;
R <= x_now;
end case;
end process;
process(x_now , clr)
begin
if (x_now=0 and clr='0') then
divisible <= '1';
else
divisible <= '0';
end if;
end process;
end Behavioral;
