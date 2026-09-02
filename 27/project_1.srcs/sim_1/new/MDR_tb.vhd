----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.12.2020 11:37:51
-- Design Name: 
-- Module Name: MDR_tb - Behavioral
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

entity Memory_tb is
generic (   ADDR_WIDTH : integer := 12;
            DATA_WIDTH : integer := 16
        );
end Memory_tb;

architecture Behavioral of Memory_tb is
constant T : time := 1 us;
signal address : std_logic_vector(ADDR_WIDTH-1 downto 0);
signal re , CPU_Flag , clk , done : std_logic;
signal data : std_logic_vector(DATA_WIDTH-1 downto 0):= (others => 'Z');
begin
uut : entity work.Memory(structural)
port map (  address => address,
            re => re,
            CPU_Flag => CPU_Flag,
            clk => clk,
            done => done,
            data => data
         );
process
begin
clk <= '0';
wait for T/2;
clk <= '1';
wait for T/2;
end process;
process
begin
CPU_Flag <= '0';
address <= X"000";
re <= '1';
wait until falling_edge(clk);
CPU_Flag <= '1';
wait until done='1';
wait until falling_edge(clk);
CPU_Flag <= '0';
address <= X"001";
re <= '1';
wait until falling_edge(clk);
CPU_Flag <= '1';
wait until done='1';
wait until falling_edge(clk);
CPU_Flag <= '0';
address <= X"002";
re <= '1';
wait until falling_edge(clk);
CPU_Flag <= '1';
wait until done='1';
wait until falling_edge(clk);
CPU_Flag <= '0';
address <= X"003";
re <= '1';
wait until falling_edge(clk);
CPU_Flag <= '1';
wait until done='1';
wait until falling_edge(clk);
CPU_Flag <= '0';
address <= X"004";
re <= '1';
wait until falling_edge(clk);
CPU_Flag <= '1';
wait until done='1';
wait until falling_edge(clk);
CPU_Flag <= '0';
address <= X"005";
re <= '1';
wait until falling_edge(clk);
CPU_Flag <= '1';
wait until done='1';
wait until falling_edge(clk);
CPU_Flag <= '0';
address <= X"006";
re <= '1';
wait until falling_edge(clk);
CPU_Flag <= '1';
wait until done='1';
wait until falling_edge(clk);
CPU_Flag <= '0';
address <= X"007";
re <= '1';
wait until falling_edge(clk);
CPU_Flag <= '1';
wait until done='1';
wait until falling_edge(clk);
CPU_Flag <= '0';
address <= X"008";
re <= '1';
wait until falling_edge(clk);
CPU_Flag <= '1';
wait until done='1';
wait until falling_edge(clk);
CPU_Flag <= '0';
address <= X"032";
re <= '1';
wait until falling_edge(clk);
CPU_Flag <= '1';
wait until done='1';
wait until falling_edge(clk);
CPU_Flag <= '0';
address <= X"033";
re <= '1';
wait until falling_edge(clk);
CPU_Flag <= '1';
wait until done='1';
wait until falling_edge(clk);
CPU_Flag <= '0';
address <= X"020";
re <= '1';
wait until falling_edge(clk);
CPU_Flag <= '1';
wait until done='1';
wait until falling_edge(clk);
CPU_Flag <= '0';
address <= X"020";
re <= '0';
data <= X"2128";
wait until falling_edge(clk);
CPU_Flag <= '1';
wait until done='1';
wait until falling_edge(clk);
CPU_Flag <= '0';
address <= X"020";
re <= '1';
wait until falling_edge(clk);
CPU_Flag <= '1';
wait until done='1';
wait until falling_edge(clk);
assert false
    report"simulation completed"
severity failure;
end process;
end Behavioral;
