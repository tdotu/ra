LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY invert_logic IS
	GENERIC
	(
		length : integer
	);
	PORT
	(
		input : IN std_logic_vector(length-1 downto 0);
		output : OUT std_logic_vector(length-1 downto 0)
	);
END invert_logic;


ARCHITECTURE behavior OF invert_logic IS
BEGIN
	output <= not input;
END behavior;