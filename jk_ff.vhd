LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY jk_ff IS
	PORT (	clock: IN STD_LOGIC;
		j: IN STD_LOGIC;
		k: IN STD_LOGIC;
		reset: IN STD_LOGIC;
		q: OUT STD_LOGIC;
		q_neg: OUT STD_LOGIC);
END jk_ff;

ARCHITECTURE behavior OF jk_ff IS
	SIGNAL state: STD_LOGIC;
	SIGNAL input: STD_LOGIC_VECTOR(1 downto 0);
	
	BEGIN	
		input <= j & k;
		
		PROCESS(clock, reset) IS BEGIN
			IF (reset='1') THEN
				state <= '0';
			ELSIF(rising_edge(clock)) THEN
				CASE(input) IS
					WHEN "11" => state <= NOT state;
					WHEN "10" => state <= '1';
					WHEN "01" => state <= '0';
					WHEN "00" => state <= state;
				END CASE;
			END IF;
		END PROCESS;

		q <= state;
		q_neg <= NOT state;
	END behavior;