LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY invert_arithmetic IS
	GENERIC
	(
		length : integer
	);
	PORT
	(
		input : IN std_logic_vector(length-1 downto 0);
		output : OUT std_logic_vector(length-1 downto 0)
	);
END invert_arithmetic;


ARCHITECTURE behavior OF invert_arithmetic IS
COMPONENT invert_logic IS
	GENERIC
	(
		length : integer
	);
	PORT
	(
		input : IN std_logic_vector(length-1 downto 0);
		output : OUT std_logic_vector(length-1 downto 0)
	);
END COMPONENT;
COMPONENT increment IS
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
END COMPONENT;
SIGNAL x : std_logic_vector(length-1 downto 0);
SIGNAL dontcare : std_logic;
BEGIN
	inv : invert_logic GENERIC MAP(length) PORT MAP(input, x);
	inc : increment GENERIC MAP(length) PORT MAP(x, output, dontcare);
END behavior;