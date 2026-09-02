----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.11.2020 11:50:28
-- Design Name: 
-- Module Name: sub8 - Behavioral
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

entity sub8 is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           R : out STD_LOGIC_VECTOR (7 downto 0);
           Z : out STD_LOGIC);
end sub8;

architecture Behavioral of sub8 is
signal cx : std_logic_vector(7 downto 1);
constant low : std_logic := '0';

component fsub is
port( a : in STD_LOGIC;
           b : in STD_LOGIC;
           cin : in STD_LOGIC;
           s : out STD_LOGIC;
           co : out STD_LOGIC);
           end component;
begin
u1 : fsub port map ( a => A(0) , b => B(0) , cin => low , co => cx(1) , s => R(0));
u2 : fsub port map ( a => A(1) , b => B(1) , cin => cx(1) , co => cx(2) , s => R(1));
u3 : fsub port map ( a => A(2) , b => B(2) , cin => cx(2) , co => cx(3) , s => R(2));
u4 : fsub port map ( a => A(3) , b => B(3) , cin => cx(3) , co => cx(4) , s => R(3));
u5 : fsub port map ( a => A(4) , b => B(4) , cin => cx(4) , co => cx(5) , s => R(4));
u6 : fsub port map ( a => A(5) , b => B(5) , cin => cx(5) , co => cx(6) , s => R(5));
u7 : fsub port map ( a => A(6) , b => B(6) , cin => cx(6) , co => cx(7) , s => R(6));
u8 : fsub port map ( a => A(7) , b => B(7) , cin => cx(7) , co => Z , s => R(7));
end Behavioral;
