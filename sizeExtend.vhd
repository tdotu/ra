LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY sizeExtend IS
	PORT
	(
		signd  : IN std_logic;
		input  : IN std_logic_vector(15 downto 0);
		output : OUT std_logic_vector(31 downto 0)
	);
END sizeExtend;

ARCHITECTURE behavior OF sizeExtend IS
BEGIN
	WITH signd SELECT
		output <=	(15 downto 0 => input, OTHERS => 0) WHEN '0',
						(14 downto 0 => input(14 downto 0), OTHERS => input(15)) WHEN '1',
						(OTHERS => '0') WHEN OTHERS;
END behavior;