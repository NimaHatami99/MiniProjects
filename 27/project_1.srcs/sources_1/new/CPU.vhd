----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2020 13:51:52
-- Design Name: 
-- Module Name: CPU - Behavioral
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

entity CPU is
    Port ( address : out STD_LOGIC_VECTOR (11 downto 0);
           re : out STD_LOGIC;
           CPU_Flag : out STD_LOGIC;
           clk : in STD_LOGIC;
           done : in STD_LOGIC;
           data : inout STD_LOGIC_VECTOR (15 downto 0);
           reset : in STD_LOGIC);
end CPU;

architecture Behavioral of CPU is
type state_type is (idle , load , load2 , str , decode , execution);
signal state_reg , state_next : state_type;
signal MAR : unsigned(15 downto 0);
signal PC : unsigned(15 downto 0) := (others => '0');
signal ACC , MDRS , MDR : signed(15 downto 0) := (others => '0');
signal sig_in , sig_out : signed(15 downto 0);
signal MSB : std_logic_vector(3 downto 0):= (others => '0');
signal ADD : std_logic_vector(11 downto 0):= (others => '0');
signal write_en : std_logic;
signal num , num2 , num3 , MDRS_writed , load2_end , load2_add , summed : integer := 0;
begin
process(clk,reset)
begin
if(reset='1') then
state_reg <= idle;
elsif(clk'event and clk='1') then
state_reg <= state_next;
end if;
end process;
process(state_reg,reset,done,MSB,write_en,PC)
begin
state_next <= state_reg;
CPU_Flag <= '0';
write_en <= '0';
summed <= 0;
case state_reg is
when idle =>
state_next <= idle;
PC <= (others => '0');
if(reset='0') then
state_next <= load;
end if;
when load =>
load2_end <= 0;
CPU_Flag <= '1';
re <= '1';
address <= std_logic_vector(MAR(11 downto 0));
if(done'event and done='1') then
MAR <= PC;
if( PC /= MAR + 1) then
PC <= PC + 1;
end if;
--if(PC=X"008") then
--PC <= (others => '0');
--end if;
num <= 1;
--MDR <= sig_in;
end if;
if(MDR=sig_in) then
num2 <= 1;
end if;
if(num=1 and num2=1) then
state_next <= decode;
end if;
when decode =>
CPU_Flag <= '1';
num2 <= 0;
MSB <= std_logic_vector(MDR(15 downto 12));
ADD <= std_logic_vector(MDR(11 downto 0));
state_next <= execution;
summed <= 0;
when execution =>
if(MSB="0001") then
state_next <= str;
num <= 0;
elsif(MSB="0010") then
MDRS <= ACC;
state_next <= load;
CPU_Flag <= '1';
num <= 0;
MAR <= PC;
address <= std_logic_vector(PC(11 downto 0));
elsif(MSB="0011") then
if(summed=0) then
ACC <= ACC + MDRS;
summed <= 1;
end if;
state_next <= load;
CPU_Flag <= '1';
num <= 0;
MAR <= PC;
address <= std_logic_vector(PC(11 downto 0));
elsif(MSB="0100") then
PC <= unsigned("0000" & ADD);
state_next <= load;
CPU_Flag <= '1';
num <= 0;
MAR <= PC;
address <= std_logic_vector(PC(11 downto 0));
elsif(MSB="0101") then
ACC <= (others => '0');
state_next <= load;
CPU_Flag <= '1';
num <= 0;
MAR <= PC;
address <= std_logic_vector(PC(11 downto 0));
elsif(MSB="0110") then
MDRS <= (others => '0');
state_next <= load;
CPU_Flag <= '1';
num <= 0;
MAR <= PC;
address <= std_logic_vector(PC(11 downto 0));
elsif(MSB="0111") then
state_next <= load2;
MDRS_writed <= 0;
CPU_Flag <= '1';----------
load2_add <= 2;
num <= 0;
num3 <= 0;
address <= std_logic_vector(ADD);-----------
end if;
when load2 =>
num3 <= num3 + 1;
CPU_Flag <= '1';
re <= '1';
if(load2_add /= 0) then
address <= std_logic_vector(ADD);
end if;
if(done'event and done='1') then
if(MDRS_writed=0 and num3>=2) then
MDRS <= sig_in;
MDRS_writed <= 1;
end if;
--MDR <= sig_in;
num <= 2;
end if;
if(num=2) then
load2_end <= 1;
MAR <= PC;
if(sig_in = "UUUU") then
address <= std_logic_vector(PC(11 downto 0));
elsif(load2_add = 0 or load2_add = 1) then
address <= std_logic_vector(PC(11 downto 0));
end if;
load2_add <= load2_add - 1;
end if;
if(load2_end=1) then
if(num3=3 or num3=4) then
state_next <= load;
else
state_next <= load;
end if;
num <= 0;
end if;
when str =>
write_en <= '1';
CPU_Flag <= '1';
re <= '0';
address <= std_logic_vector(ADD);
if(done'event and done='1') then
--MDR <= MDRS;
sig_out <= MDRS;
num <= 3;
end if;
if(num=3) then
state_next <= load;
re <= '1';
write_en <= '0';
MAR <= PC;
address <= std_logic_vector(PC(11 downto 0));
end if;
end case;
end process;
MDR <= sig_in;
sig_in <= signed(data);
data <= std_logic_vector(sig_out) when write_en='1' else (others => 'Z');
end Behavioral;
