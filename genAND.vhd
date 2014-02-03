LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY genAND IS
	GENERIC
	(
		size : integer
	);
	PORT
	(
		input0 : IN std_logic_vector(size-1 downto 0);
		input1 : IN std_logic_vector(size-1 downto 0);
		output : OUT std_logic_vector(size-1 downto 0)
	);
END genAND;

ARCHITECTURE behavior OF genAND IS
BEGIN
	output <= input0 AND input1;
END behavior;