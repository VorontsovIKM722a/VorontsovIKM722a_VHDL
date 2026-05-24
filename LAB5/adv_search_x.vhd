---------------------------------------------------------
-- Lab Work #5: Advanced Searcher - full scheme 
---------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity adv_search_x is 
	port (
		CLK    : in  STD_LOGIC;
		RST    : in  STD_LOGIC;
		Y_FIND : in  STD_LOGIC_VECTOR(3 downto 0);
		START  : in  STD_LOGIC;
		X_R0_F : out STD_LOGIC_VECTOR(3 downto 0);
		X_R1_F : out STD_LOGIC_VECTOR(3 downto 0);
		FINISH : out STD_LOGIC;
		ERROR  : out STD_LOGIC
	);
end entity;

architecture adv_search_x_arch of adv_search_x is
	signal Y_buf : STD_LOGIC_VECTOR(3 downto 0);
	signal X_buf : STD_LOGIC_VECTOR(3 downto 0);
	signal R_buf : STD_LOGIC;
begin
	-- components (direct use, without preliminary declaration)
	Kxx_unit: entity work.kxx_rom
	port map (
		R => R_buf,
		X => X_buf,
		Y => Y_buf
	);
	FSM_unit: entity work.fsm_adv_search_x
	port map (
		CLK => CLK,
		RST => RST,
		Y_F => Y_FIND,
		STR => START,
		Y_S => Y_buf,
		X_S => X_buf,
		R_S => R_buf,
		XR0	=> X_R0_F,
		XR1	=> X_R1_F,
		FIN => FINISH,
		ERR => ERROR
	); 
end architecture;