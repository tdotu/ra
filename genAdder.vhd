LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY genAdder IS
	GENERIC(
		value_len : integer
	);
	PORT(
		value0 : IN std_logic_vector(value_len-1 downto 0);
		value1 : IN std_logic_vector(value_len-1 downto 0);
		output : OUT std_logic_vector(value_len-1 downto 0);
		overflow : OUT std_logic
	);
END genAdder;


ARCHITECTURE behavior OF genAdder IS

COMPONENT fullAdder
	PORT(
		in0      : IN std_logic;
		in1      : IN std_logic;
		carryIn  : IN std_logic;
		result   : OUT std_logic;
		carryOut : OUT std_logic
	);
END COMPONENT;
	SIGNAL carry  : std_logic_vector(value_len-1 downto 0);
BEGIN
	add0 : fullAdder PORT MAP (value0(0), value1(0), '0', output(0), carry(0));

	gen: FOR I IN 1 TO value_len-1 GENERATE
		addi : fullAdder PORT MAP (value0(I), value1(I), carry(I-1), output(I), carry(I));
	END GENERATE gen;
	
	overflow <= carry(value_len-1);
	
END behavior;