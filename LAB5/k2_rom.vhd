---------------------------------------------
--  Lab Work #5: compact reversive S-box kxx 
---------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
--use IEEE.std_logic_arith.all; -- old solution
--use IEEE.std_logic_unsigned.all; -- old solution
use IEEE.numeric_std.all; -- new solution

entity kxx_rom is
	port (
		R : in STD_LOGIC;
		X : in STD_LOGIC_VECTOR(3 downto 0);
		Y : out STD_LOGIC_VECTOR(3 downto 0)
	);
end entity;

architecture kxx_rom_arc of kxx_rom is  
	signal inp_addr : STD_LOGIC_VECTOR(4 downto 0);
	type sbox_array is array (0 to 31) of STD_LOGIC_VECTOR(3 downto 0);
	constant kxx : sbox_array := (
	    x"d", x"2", x"8", x"4", x"6", x"f", x"b", x"1",  --R=0;X:0-7
	    x"f", x"2", x"5", x"b", x"c", x"8", x"6", x"0",  --R=0;X:8-15
	    x"d", x"7", x"1", x"a", x"3", x"c", x"4", x"f",  --R=1;X:0-7
	    x"2", x"9", x"8", x"6", x"e", x"0", x"b", x"5"	 --R=1;X:8-15
	); 								   begin
	inp_addr <= R & X;
	-- Y <= kxx(conv_integer(inp_vec)); -- old solution
	Y <= kxx(to_integer(unsigned(inp_addr))); -- new solution
end architecture;