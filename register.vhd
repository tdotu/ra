LIBRARY ieee;

USE ieee.std_logic_1164.all;


ENTITY register IS
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

END register;




ARCHITECTURE behaviour OF register IS


COMPONENT dLatch IS

	PORT
	(
		d : IN std_logic;
		c : IN std_logic;
		q : OUT std_logic;
		qi : OUT std_logic
	);

END COMPONENT;

	SIGNAL ignore : std_logic_vector(width-1 downto 0);


BEGIN

	gen: FOR X IN 0 TO width-1 GENERATE
		flipflopx : dLatch PORT MAP (change(X), clock, state(X), ignore(X));
	END GENERATE gen;
END behaviour;
