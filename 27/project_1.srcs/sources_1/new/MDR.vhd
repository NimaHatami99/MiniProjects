----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.12.2020 13:43:34
-- Design Name: 
-- Module Name: MDR - structural
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

entity Memory is
    generic(
           ADDR_WIDTH : integer := 12;
           DATA_WIDTH : integer := 16
           );
    Port ( address : in STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
           re : in STD_LOGIC;
           CPU_Flag : in STD_LOGIC;
           clk : in STD_LOGIC;
           done : out STD_LOGIC;
           data : inout STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0));
end Memory;

architecture structural of Memory is
type mem_type is array (0 to 99) of std_logic_vector (DATA_WIDTH-1 downto 0);
signal data_reg : mem_type := (
                                0 => X"7032",
                                1 => X"5000",
                                2 => X"3000",
                                3 => X"7033",
                                4 => X"3000",
                                5 => X"2000",
                                6 => X"1032",
                                7 => X"6000",
                                8 => X"4000",
                                50 => X"02df",
                                51 => X"0005",
                                others => X"0000"
                              );
signal sig_in , sig_out : std_logic_vector(DATA_WIDTH-1 downto 0);
begin
process(clk,CPU_Flag,re)
begin
done <= '0';
if(CPU_Flag='1') then
if(clk'event and clk = '1') then
done <= '1';
if(re='1') then
sig_out <= data_reg(to_integer(unsigned(address)));
else
data_reg(to_integer(unsigned(address))) <= sig_in;
end if;
end if;
end if;
end process;
data <= sig_out when re='1' else (others => 'Z');
sig_in <= data;
end structural;
