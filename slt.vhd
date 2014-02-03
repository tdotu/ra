LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY slt IS
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
END slt;

ARCHITECTURE behavior OF slt IS

COMPONENT subtract IS
	GENERIC(
		value_len : integer
	);
	PORT(
		minuend : IN std_logic_vector(value_len-1 downto 0);
		subtrahend : IN std_logic_vector(value_len-1 downto 0);
		output : OUT std_logic_vector(value_len-1 downto 0);
		overflow : OUT std_logic
	);
END COMPONENT;

SIGNAL subres : std_logic_vector(size-1 downto 0);
SIGNAL dontcare : std_logic;

BEGIN
	sub : subtract GENERIC MAP (size) PORT MAP (input0, input1, subres, dontcare);
		
	output(size-1 downto 1) <= (OTHERS => '0');
	output(0) <= subres(size-1);
END behavior;