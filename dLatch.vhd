LIBRARY ieee;

USE ieee.std_logic_1164.all;


ENTITY dLatch IS

	PORT
	
	(

		d : IN std_logic;

		c : IN std_logic;

		q : OUT std_logic;

		qi : OUT std_logic
	
	);

END dLatch;




ARCHITECTURE behaviour OF dLatch IS


COMPONENT rs IS

    PORT

    (

		r : IN std_logic;

		s : IN std_logic;

		q : OUT std_logic;

		qi : OUT std_logic

    );

END COMPONENT;


SIGNAL r,s : std_logic;


BEGIN

	r <= s nand c;

	s <= d nand c;

	rsLatch : rs PORT MAP(r, s, q, qi);

END behaviour;




ARCHITECTURE betterBehaviour OF dLatch IS


SIGNAL value : std_logic;


BEGIN

	save : PROCESS(d, c)
	BEGIN
		IF(d = '1' AND (d'event OR c'event)) THEN
			value <= c;
		END IF;
	END PROCESS;

	q <= c;
	qi <= NOT c;
END betterBehaviour;
