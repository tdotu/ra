LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY genOR IS
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
END genOR;

ARCHITECTURE behavior OF genOR IS
BEGIN
	output <= input0 OR input1;
END behavior;