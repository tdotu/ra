LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY reg IS
	GENERIC
	(
		width : integer
	);

	PORT
	(
		clock : IN std_logic;
		change : IN std_logic_vector(width-1 downto 0);
		state : OUT std_logic_vector(width-1 downto 0)
	);
END reg;




ARCHITECTURE behaviour OF reg IS

COMPONENT dFlipFlop IS
	PORT
	(
		c : IN std_logic;
		i : IN std_logic;
		q : OUT std_logic
	);
END COMPONENT;
	
BEGIN
	gen: FOR X IN 0 TO width-1 GENERATE
		flipflopx : dFlipFlop PORT MAP (clock, change(X), state(X));
	END GENERATE gen;
END behaviour;
