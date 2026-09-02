----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2020 18:31:00
-- Design Name: 
-- Module Name: AddSub_Nbit - Behavioral
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

entity AddSub_Nbit is
    generic(N : integer := 4);
    Port ( a : in STD_LOGIC_VECTOR (N-1 downto 0);
           b : in STD_LOGIC_VECTOR (N-1 downto 0);
           cin : in STD_LOGIC;
           addsub : in STD_LOGIC;
           s : out STD_LOGIC_VECTOR (N-1 downto 0);
           cout : out STD_LOGIC);
end AddSub_Nbit;

architecture Behavioral of AddSub_Nbit is
signal B_comp : std_logic_vector(N-1 downto 0);
signal c : std_logic_vector(N downto 0);
begin
xorgen: for i in 0 to N-1 generate
B_comp(i) <= addsub xor b(i);
end generate;
c(0) <= cin xor addsub;
cout <= c(N);
FAgen: for i in 0 to N-1 generate
FA_unit : entity work.FA_1bit(Behavioral)
port map (  A => a(i),
            B => B_comp(i),
            Cin => c(i),
            Cout => c(i+1),
            S => s(i));
end generate;
end Behavioral;
