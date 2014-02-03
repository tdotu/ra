LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY dFlipFlop IS
	PORT
	(
		c : IN std_logic;
		i : IN std_logic;
		q : OUT std_logic
	);
END dFlipFlop;


ARCHITECTURE behavior OF dFlipFlop IS

SIGNAL state : std_logic;

BEGIN
	save : PROCESS(c, i)
	BEGIN
		IF(rising_edge(c)) THEN
			state <= i;
		END IF;
	END PROCESS;

	q <= state;
END behavior;
