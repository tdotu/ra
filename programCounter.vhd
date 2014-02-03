LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY programCounter IS
	GENERIC
	(

	);

	PORT
	(

	);
END programCounter;




ARCHITECTURE behaviour OF programCounter IS

COMPONENT reg IS
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
END COMPONENT;
	
BEGIN
	
END behaviour;