LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY rs IS
	PORT
	(
		r : IN std_logic;
		s : IN std_logic;
		q : OUT std_logic;
		qi : OUT std_logic
	);
END rs;


ARCHITECTURE behavior OF rs IS
SIGNAL a, b : std_logic;
BEGIN
	q <= a;
	qi <= b;
	a <= s nand b;
	b <= r nand a;
END behavior;
