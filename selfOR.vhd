LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY selfOR IS
	GENERIC
	(
		size : integer
	);
	PORT
	(
		input : IN std_logic_vector(size-1 downto 0);
		output : OUT std_logic
	);
END selfOR;

ARCHITECTURE behavior OF selfOR IS
	SIGNAL tempres : std_logic_vector(size downto 0);
BEGIN
	tempres(0) <= '0';

	gen : FOR I IN 0 TO size-1 GENERATE
		tempres(I+1) <= input(I) OR tempres(I);
	END GENERATE gen;
	
	output <= tempres(size);
END behavior;