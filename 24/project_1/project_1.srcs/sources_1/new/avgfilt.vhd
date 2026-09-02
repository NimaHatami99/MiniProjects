----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2021 17:24:49
-- Design Name: 
-- Module Name: avgfilt - Behavioral
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

entity avgfilt is
    Port ( input : in STD_LOGIC_VECTOR (7 downto 0);
           row : in STD_LOGIC_VECTOR (11 downto 0);
           column : in STD_LOGIC_VECTOR (11 downto 0);
           clk : in STD_LOGIC;
           start : in STD_LOGIC;
           reset : in STD_LOGIC;
           read_flag : out STD_LOGIC;
           done : out STD_LOGIC;
           output : out STD_LOGIC_VECTOR (7 downto 0));
end avgfilt;

architecture Behavioral of avgfilt is
type state_type is (idle, read_rows, exe, read_pixels, finish_row);
signal state_reg , state_next : state_type;
signal row_ctr , col_ctr : integer :=1;
--signal mat , matr , matl , matu , matd : unsigned (7 downto 0);
signal result : unsigned (11 downto 0);
type input_arr is array (1 to 4095) of unsigned(7 downto 0);
signal input_vec1 , input_vec2 , input_vec3 : input_arr;
signal pixel_add : integer:=0;
signal pix1 : integer:=0;
signal test : integer:=0;
signal t : std_logic := '0';
begin
process(clk,start)
begin
if(reset='1') then
state_reg <= idle;
elsif(clk'event and clk='1') then
state_reg <= state_next;
t <= not t;
end if;
end process;
process(reset, start, input, t)
begin
state_next <= state_reg;
done <= '0';
read_flag <= '0';
case state_reg is
--------------------------------------------------state : idle
when idle =>
result <= (others => '0');
input_vec1 <= (others => X"00");
input_vec2 <= (others => X"00");
input_vec3 <= (others => X"00");
--mat <= (others => '0');
--matr <= (others => '0');
--matl <= (others => '0');
--matu <= (others => '0');
--matd <= (others => '0');
if (reset='0' and rising_edge(start)) then
state_next <= read_rows;
end if;
--------------------------------------------------state : read_rows
when read_rows =>
if(pixel_add <= (to_integer(unsigned(column)))) then
test <= test + 1;
input_vec1(col_ctr) <= unsigned(input);
if(test /= 0) then
col_ctr <= col_ctr + 1;
end if;
if(col_ctr=(to_integer(unsigned(column)))+1) then
row_ctr <= row_ctr + 1;
col_ctr <= 2;
end if;
elsif(pixel_add <= 2 * (to_integer(unsigned(column)))) then
test <= test + 1;
if(col_ctr = (to_integer(unsigned(column)))+1) then
input_vec2(1) <= unsigned(input);
else
input_vec2(col_ctr) <= unsigned(input);
end if;
col_ctr <= col_ctr + 1;
if(col_ctr=(to_integer(unsigned(column)))+1) then
row_ctr <= row_ctr + 1;
col_ctr <= 2;
end if;
elsif(pixel_add <= 3 * (to_integer(unsigned(column)))) then
test <= test + 1;
if(col_ctr = (to_integer(unsigned(column)))+1) then
input_vec3(1) <= unsigned(input);
col_ctr <= 2;
row_ctr <= 3;
else
input_vec3(col_ctr) <= unsigned(input);
end if;
if(col_ctr /= to_integer(unsigned(column))+1) then
col_ctr <= col_ctr + 1;
end if;
if(col_ctr=(to_integer(unsigned(column))) and test >= 3 * (to_integer(unsigned(column)))) then
row_ctr <= row_ctr + 1;
col_ctr <= 2;
state_next <= exe;
end if;
end if;
--------------------------------------------------state : exe
when exe =>
result <= ("0000"&input_vec1(col_ctr-1)+input_vec1(col_ctr)+input_vec1(col_ctr+1)+
                  input_vec2(col_ctr-1)+input_vec2(col_ctr)+input_vec2(col_ctr+1)+
                  input_vec3(col_ctr-1)+input_vec3(col_ctr)+input_vec3(col_ctr+1))/9;
read_flag <= '1';
col_ctr <= col_ctr + 1;
input_vec1(col_ctr-1) <= input_vec2(col_ctr-1);
input_vec2(col_ctr-1) <= input_vec3(col_ctr-1);
input_vec3(col_ctr-1) <= unsigned(input);
if(col_ctr=(to_integer(unsigned(column)))-1 and row_ctr <= (to_integer(unsigned(row)))) then
state_next <= read_pixels;
pix1 <= 0;
col_ctr <= (to_integer(unsigned(column)));
end if;
--------------------------------------------------state : read_pixels
when read_pixels =>
if(pix1=0) then
input_vec1(col_ctr-1) <= input_vec2(col_ctr-1);
input_vec2(col_ctr-1) <= input_vec3(col_ctr-1);
input_vec3(col_ctr-1) <= unsigned(input);
pix1 <= 1;
else
input_vec1(col_ctr) <= input_vec2(col_ctr);
input_vec2(col_ctr) <= input_vec3(col_ctr);
input_vec3(col_ctr) <= unsigned(input);
row_ctr <= row_ctr + 1;
col_ctr <= 2;
state_next <= exe;
if(pixel_add >= to_integer(unsigned(column))*to_integer(unsigned(row))) then
state_next <= finish_row;
end if;
end if;
--------------------------------------------------state : finish_row
when finish_row =>
result <= ("0000"&input_vec1(col_ctr-1)+input_vec1(col_ctr)+input_vec1(col_ctr+1)+
                  input_vec2(col_ctr-1)+input_vec2(col_ctr)+input_vec2(col_ctr+1)+
                  input_vec3(col_ctr-1)+input_vec3(col_ctr)+input_vec3(col_ctr+1))/9;
if(col_ctr = (to_integer(unsigned(column))) - 1) then
done <= '1';
state_next <= idle;
end if;
read_flag <= '1';
col_ctr <= col_ctr + 1;
end case;
end process;
pixel_add <= (row_ctr - 1)*(to_integer(unsigned(column))) + col_ctr;
output <= std_logic_vector(result(7 downto 0));
end Behavioral;
