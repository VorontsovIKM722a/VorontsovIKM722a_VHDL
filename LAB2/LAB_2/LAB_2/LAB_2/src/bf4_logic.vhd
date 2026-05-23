-------------------------------------------------------------------------------
-- Lab Work 2 - Combinatorial Logic Implementations
-- Example: multiply output combinatorial circuit
-- using logic operators (2 variants)
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity bf4_logic is
port(
    X : in STD_LOGIC_VECTOR(3 downto 0);
    Y : out STD_LOGIC_VECTOR(3 downto 0)
);
end bf4_logic;

architecture bf4_logic of bf4_logic is

signal P : STD_LOGIC_VECTOR(14 downto 0); -- .p 15

begin

-- Variant 1: equations built on default results of minimization

P(0) <= X(3) and not X(2) and not X(1) and X(0);  -- 1001
P(1) <= X(3) and X(2) and X(1) and not X(0);      -- 1110
P(2) <= X(3) and not X(2) and not X(1) and not X(0); -- 1000
P(3) <= not X(3) and X(2) and not X(1) and X(0);   -- 0101
P(4) <= X(3) and X(2) and X(1) and not X(0);       -- 0110
P(5) <= X(3) and X(2) and not X(0);               -- 1100
P(6) <= X(3) and not X(2) and X(1) and X(0);       -- 1010
P(7) <= not X(3) and X(2) and not X(1) and X(0);  -- 0-10
P(8) <= X(3) and not X(2) and not X(0);           -- 10-1
P(9) <= not X(2) and X(1) and X(0);               -- -011
P(10) <= not X(3) and not X(2) and X(0);          -- 0-01
P(11) <= not X(3) and X(1) and X(2) and X(3);     -- -111
P(12) <= not X(3) and not X(2) and not X(1) and not X(0); -- 0000
P(13) <= not X(3) and X(2) and not X(0);          -- 010-
P(14) <= X(3) and not X(2) and X(1) and X(0);     -- 1-11

Y(3) <= P(1) or P(2) or P(7) or P(11) or P(12);

Y(2) <= P(0) or P(1) or P(3) or P(5) or P(6) or P(8);

Y(1) <= P(2) or P(4) or P(7) or P(9) or P(13);

Y(0) <= P(0) or P(3) or P(4) or P(5) or P(8) or P(14);

-- Variant 2: equations obtained with option "-o eqntott"

-- Y(3) = ...
-- Y(2) = ...
-- Y(1) = ...
-- Y(0) = ...

end bf4_logic;