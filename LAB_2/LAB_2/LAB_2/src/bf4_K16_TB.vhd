library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bf4_test_tb is
end bf4_test_tb;

architecture bf4_test_tb of bf4_test_tb is

    signal X : STD_LOGIC_VECTOR(3 downto 0);

    signal Y_conc_CA   : STD_LOGIC_VECTOR(3 downto 0);
    signal Y_conc_WS   : STD_LOGIC_VECTOR(3 downto 0);
    signal Y_const     : STD_LOGIC_VECTOR(3 downto 0);
    signal Y_logic     : STD_LOGIC_VECTOR(3 downto 0);
    signal Y_proc_IF   : STD_LOGIC_VECTOR(3 downto 0);
    signal Y_proc_CASE : STD_LOGIC_VECTOR(3 downto 0);

    constant p_delay : time := 10 ns;

    signal index : integer;

    type VRF_TYPE is (OK, ERROR);
    signal VERIF_STATE : VRF_TYPE := OK;

    type TST_TYPE is (ETV, UTV, DONE);
    signal TEST_PHASE : TST_TYPE;

    type TV_TYPE is array (natural range <>) of STD_LOGIC_VECTOR(3 downto 0);

    constant EXPECTED_TEST_VECTORS : TV_TYPE(0 to 15) :=
    ("0000","0001","0010","0011","0100","0101","0110","0111",
     "1000","1001","1010","1011","1100","1101","1110","1111");

    constant UNEXP_TEST_VECTORS : TV_TYPE(0 to 15) :=
    ("X000","0X00","00X0","000X","U000","0U00","00U0","000U",
     "H000","0H00","00H0","000H","L000","0L00","00L0","000L");

    -- ? ÒÂÎß ÔÓÍÊÖ²ß (Variant 02)
    constant EXPECTED_RESPONSES : TV_TYPE(0 to 15) :=
    (
    x"D", -- 0000
    x"2", -- 0001
    x"8", -- 0010
    x"4", -- 0011
    x"6", -- 0100
    x"9", -- 0101
    x"3", -- 0110
    x"1", -- 0111
    x"A", -- 1000
    x"9", -- 1001
    x"3", -- 1010
    x"E", -- 1011
    x"5", -- 1100
    x"0", -- 1101
    x"C", -- 1110
    x"7"  -- 1111
    );

begin

    UUT1: entity work.bf4_conc_ca port map (X => X, Y => Y_conc_CA);
    UUT2: entity work.bf4_conc_ws port map (X => X, Y => Y_conc_WS);
    UUT3: entity work.bf4_const   port map (X => X, Y => Y_const);
    UUT4: entity work.bf4_logic   port map (X => X, Y => Y_logic);
    UUT5: entity work.bf4_proc_IF port map (X => X, Y => Y_proc_IF);
    UUT6: entity work.bf4_proc_CASE port map (X => X, Y => Y_proc_CASE);

    stim_gen: process
    begin
        TEST_PHASE <= ETV;

        for i in 0 to 15 loop
            X <= EXPECTED_TEST_VECTORS(i);
            index <= i;
            wait for p_delay;
        end loop;

        TEST_PHASE <= UTV;

        for i in 0 to 15 loop
            X <= UNEXP_TEST_VECTORS(i);
            wait for p_delay;
        end loop;

        TEST_PHASE <= DONE;
        wait;
    end process;

    output_verify: process

        function slv_to_string(slv: std_logic_vector) return string is
            variable str : string(slv'length downto 1) := (others => ' ');
        begin
            for i in slv'length downto 1 loop
                str(i) := std_logic'image(slv(i-1))(2);
            end loop;
            return str;
        end function;

    begin
        wait on Y_logic;
        wait for p_delay/2;

        if TEST_PHASE = ETV then

            assert Y_logic = EXPECTED_RESPONSES(index)
                report "ERROR bf4_logic X=" & slv_to_string(X)
                severity ERROR;

            if (Y_logic /= EXPECTED_RESPONSES(index)) then
                VERIF_STATE <= ERROR;
            else
                VERIF_STATE <= OK;
            end if;

        elsif TEST_PHASE = UTV then

            assert Y_logic = "ZZZZ"
                report "NOT SAFE X=" & slv_to_string(X)
                severity ERROR;

        end if;

    end process;

end bf4_test_tb;