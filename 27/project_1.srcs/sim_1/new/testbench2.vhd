----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2020 07:55:39
-- Design Name: 
-- Module Name: testbench2 - Behavioral
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

entity testbench2 is
generic(    
            ADDR_WIDTH : integer := 12;
            DATA_WIDTH : integer := 16);
--  Port ( );
end testbench2;

architecture test of testbench2 is
constant T : time := 1 us;
signal test_address : std_logic_vector(11 downto 0);
signal test_re , test_CPU_Flag , test_clk , test_done , test_reset : std_logic;
signal test_data : std_logic_vector(15 downto 0);
component CPU is
port (     address : out STD_LOGIC_VECTOR (11 downto 0);
           re : out STD_LOGIC;
           CPU_Flag : out STD_LOGIC;
           clk : in STD_LOGIC;
           done : in STD_LOGIC;
           data : inout STD_LOGIC_VECTOR (15 downto 0);
           reset : in STD_LOGIC);
end component;
component Memory is
generic(    
            ADDR_WIDTH : integer := 12;
            DATA_WIDTH : integer := 16);
Port ( address : in STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
           re : in STD_LOGIC;
           CPU_Flag : in STD_LOGIC;
           clk : in STD_LOGIC;
           done : out STD_LOGIC;
           data : inout STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0));
end component;
begin
dut: CPU port map (     address => test_address,
                        re => test_re,
                        CPU_Flag => test_CPU_Flag,
                        clk => test_clk,
                        done => test_done,
                        data => test_data,
                        reset => test_reset);
uut: Memory port map (  address => test_address,
                        re => test_re,
                        CPU_Flag => test_CPU_Flag,
                        clk => test_clk,
                        done => test_done,
                        data => test_data);
process
begin
test_clk <= '0';
wait for T/2;
test_clk <= '1';
wait for T/2;
end process;
process
begin
test_reset <= '1';
wait until falling_edge(test_clk);
wait until falling_edge(test_clk);
test_reset <= '0';
for i in 1 to 10 loop
wait until falling_edge(test_clk);
end loop;
wait until test_address=X"000";
wait until falling_edge(test_clk);
wait until falling_edge(test_clk);
assert false
    report"simulation completed"
severity failure;
end process;
end test;
