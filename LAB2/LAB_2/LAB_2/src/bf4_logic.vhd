library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity bf4_logic is
	port(
		X : in STD_LOGIC_VECTOR(3 downto 0);
		Y : out STD_LOGIC_VECTOR(3 downto 0)
		);
end bf4_logic;

architecture bf4_logic of bf4_logic is
	signal P : STD_LOGIC_VECTOR(14 downto 0);
	signal not_x3, not_x2, not_x1, not_x0 : STD_LOGIC;
begin
	not_x3 <= not X(3);
	not_x2 <= not X(2);
	not_x1 <= not X(1);
	not_x0 <= not X(0);

	process(X, P, not_x3, not_x2, not_x1, not_x0)
	begin
		
		if (is_X(X)) then
			Y <= "ZZZZ";
		else
			P(0)  <= not_x3 and not_x2 and not_x1 and not_x0; -- 0000
			P(1)  <= not_x3 and not_x2 and not_x1 and X(0);     -- 0001
			P(2)  <= not_x3 and not_x2 and X(1) and not_x0;     -- 0010
			P(3)  <= not_x3 and not_x2 and X(1) and X(0);         -- 0011
			P(4)  <= not_x3 and X(2) and not_x1 and not_x0;     -- 0100
			P(5)  <= not_x3 and X(2) and not_x1 and X(0);         -- 0101
			P(6)  <= not_x3 and X(2) and X(1) and not_x0;         -- 0110
			P(7)  <= not_x3 and X(2) and X(1) and X(0);             -- 0111
			P(8)  <= X(3) and not_x2 and not_x1 and not_x0;     -- 1000
			P(9)  <= X(3) and not_x2 and not_x1 and X(0);         -- 1001
			P(10) <= X(3) and not_x2 and X(1) and not_x0;         -- 1010
			P(11) <= X(3) and not_x2 and X(1) and X(0);             -- 1011
			P(12) <= X(3) and X(2) and not_x1 and not_x0;         -- 1100
			P(13) <= X(3) and X(2) and X(1) and not_x0;         -- 1110
			P(14) <= X(3) and X(2) and X(1) and X(0);             -- 1111

			
			Y(3) <= P(0) or P(2) or P(5) or P(6) or P(8) or P(9) or P(11) or P(13);

			Y(2) <= P(0) or P(3) or P(4) or P(5) or P(11) or P(12) or P(13) or P(14);

			Y(1) <= P(1) or P(4) or P(5) or P(6) or P(8) or P(10) or P(11) or P(14);

			Y(0) <= P(0) or P(5) or P(6) or P(7) or P(9) or P(10) or P(12) or P(14);
		end if;
	end process;

end bf4_logic;