LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY rsc IS
	PORT
	(
		r : IN std_logic;
		s : IN std_logic;
		c : IN std_logic;
		q : OUT std_logic;
		qi : OUT std_logic
	);
END rsc;


ARCHITECTURE behavior OF rsc IS
COMPONENT rs IS
	PORT
	(
		r : IN std_logic;
		s : IN std_logic;
		q : OUT std_logic;
		qi : OUT std_logic
	);
END COMPONENT;
SIGNAL a, b : std_logic;
BEGIN
	a <= s and c;
	b <= r and c;
	flipflop : rs PORT MAP(a, b, q, qi);
END behavior;