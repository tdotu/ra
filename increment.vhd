LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY increment IS
	GENERIC
	(
		length : integer
	);
	PORT
	(
      input : IN std_logic_vector(length-1 downto 0);
		output : OUT std_logic_vector(length-1 downto 0);
		overflow : OUT std_logic
	);
END increment;


ARCHITECTURE behavior OF increment IS
COMPONENT halfAdder
	PORT
	(
		in1   : IN  std_logic;
		in2   : IN  std_logic;
		res   : OUT std_logic;
		carry : OUT std_logic
    );
END COMPONENT;
SIGNAL carry : std_logic_vector(length downto 0);
BEGIN
	carry(0) <= '1';

	gen: FOR X IN 0 TO length-1 GENERATE
		addx : halfAdder PORT MAP (input(X), carry(X), output(X), carry(X+1));
	END GENERATE gen;

	overflow <= carry(length);
END behavior;