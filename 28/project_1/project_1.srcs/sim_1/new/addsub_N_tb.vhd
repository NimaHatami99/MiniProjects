----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.11.2020 11:17:55
-- Design Name: 
-- Module Name: addsub_N_tb - Behavioral
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

entity addsub_N_tb is
generic( N : integer := 8 );
--  Port ( );
end addsub_N_tb;

architecture Behavioral of addsub_N_tb is
signal test_A , test_B , test_Sum : std_logic_vector(N-1 downto 0);
signal test_Cin , test_AddSub , test_Cout : std_logic;
begin
uut : entity work.addsub_N(Behavioral)
generic map ( N => 8 )
port map (
            a => test_A,
            b => test_B,
            s => test_Sum,
            cin => test_Cin,
            addsub => test_AddSub,
            cout => test_Cout
            );
process
begin
            test_A <= "00110000";
            test_B <= "00001111";
            test_Cin <= '0';
            test_AddSub <= '1';
            wait for 100 ns ;
            assert false
                report "Simulation Completed"
            severity failure;
            end process;
end Behavioral;

