LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY genNOR IS
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
END genNOR;

ARCHITECTURE behavior OF genNOR IS
BEGIN
	output <= input0 NOR input1;
END behavior;