----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.11.2020 19:21:37
-- Design Name: 
-- Module Name: accumulator_tb - Behavioral
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

entity accumulator_tb is
--  Port ( );
end accumulator_tb;

architecture Behavioral of accumulator_tb is
constant T : time := 1 us;
signal a , b , n : std_logic_vector(7 downto 0);
signal output : std_logic_vector(15 downto 0);
signal clk , done : std_logic;
signal start : std_logic := '1';
signal y : std_logic_vector(15 downto 0) := (others => '0');
begin
dut : entity work.accumulator(arch)
port map (  a => a,
            b => b,
            n => n,
            y => y,
            clk => clk,
            start => start,
            output => output,
            done => done);
process
begin
clk <= '0';
wait for T/2;
clk <= '1';
wait for T/2;
end process;
process
begin
--------------------------------n=2
n <= X"02";   -- n=2
a <= X"f9";   -- a=-7
b <= X"09";   -- b=9
wait until falling_edge(clk);
start <= '0';
wait until falling_edge(clk);
start <= '1';
for i in 1 to 260 loop
wait until falling_edge(clk);
end loop;
wait until falling_edge(clk);
y <= X"003c";      -- f(x)=x^2 - 2x -3   so f(-7)=60
wait until falling_edge(clk);
y <= X"fffc";      -- f(1)=-4
wait until falling_edge(clk);
y <= X"0000";
wait until done = '1';
for i in 1 to 5 loop
wait until falling_edge(clk);
end loop;
--------------------------------n=4
n <= X"04";   -- n=4
a <= X"f9";   -- a=-7
b <= X"09";   -- b=9
wait until falling_edge(clk);
start <= '0';
wait until falling_edge(clk);
start <= '1';
for i in 1 to 260 loop
wait until falling_edge(clk);
end loop;
wait until falling_edge(clk);
y <= X"003c";      -- f(-7)=60
wait until falling_edge(clk);
y <= X"000c";      -- f(-3)=12
wait until falling_edge(clk);
y <= X"fffc";      -- f(1)=-4
wait until falling_edge(clk);
y <= X"000c";      -- f(5)=12
wait until falling_edge(clk);
y <= X"0000";
wait until done = '1';
for i in 1 to 5 loop
wait until falling_edge(clk);
end loop;
--------------------------------n=8
n <= X"08";   -- n=8
a <= X"f9";   -- a=-7
b <= X"09";   -- b=9
wait until falling_edge(clk);
start <= '0';
wait until falling_edge(clk);
start <= '1';
for i in 1 to 260 loop
wait until falling_edge(clk);
end loop;
wait until falling_edge(clk);
y <= X"003c";      -- f(-7)=60
wait until falling_edge(clk);
y <= X"0020";      -- f(-5)=32
wait until falling_edge(clk);
y <= X"000c";      -- f(-3)=12
wait until falling_edge(clk);
y <= X"0000";      -- f(-1)=0
wait until falling_edge(clk);
y <= X"fffc";      -- f(1)=-4
wait until falling_edge(clk);
y <= X"0000";      -- f(3)=0
wait until falling_edge(clk);
y <= X"000c";      -- f(5)=12
wait until falling_edge(clk);
y <= X"0020";      -- f(7)=32
wait until falling_edge(clk);
y <= X"0000";
wait until done = '1';
for i in 1 to 5 loop
wait until falling_edge(clk);
end loop;
--------------------------------n=16
n <= X"10";   -- n=16
a <= X"f9";   -- a=-7
b <= X"09";   -- b=9
wait until falling_edge(clk);
start <= '0';
wait until falling_edge(clk);
start <= '1';
for i in 1 to 260 loop
wait until falling_edge(clk);
end loop;
wait until falling_edge(clk);
y <= X"003c";      -- f(-7)=60
wait until falling_edge(clk);
y <= X"002d";      -- f(-6)=45
wait until falling_edge(clk);
y <= X"0020";      -- f(-5)=32
wait until falling_edge(clk);
y <= X"0015";      -- f(-4)=21
wait until falling_edge(clk);
y <= X"000c";      -- f(-3)=12
wait until falling_edge(clk);
y <= X"0005";      -- f(-2)=5
wait until falling_edge(clk);
y <= X"0000";      -- f(-1)=0
wait until falling_edge(clk);
y <= X"fffd";      -- f(0)=-3
wait until falling_edge(clk);
y <= X"fffc";      -- f(1)=-4
wait until falling_edge(clk);
y <= X"fffd";      -- f(2)=-3
wait until falling_edge(clk);
y <= X"0000";      -- f(3)=0
wait until falling_edge(clk);
y <= X"0005";      -- f(4)=5
wait until falling_edge(clk);
y <= X"000c";      -- f(5)=12
wait until falling_edge(clk);
y <= X"0015";      -- f(6)=21
wait until falling_edge(clk);
y <= X"0020";      -- f(7)=32
wait until falling_edge(clk);
y <= X"002d";      -- f(8)=45
wait until falling_edge(clk);
y <= X"0000";
wait until done = '1';
for i in 1 to 5 loop
wait until falling_edge(clk);
end loop;
assert false
    report "Simulation Completed"
severity failure;
end process;
end Behavioral;
