LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY fullAdder IS
	PORT(
		in0      : IN std_logic;
		in1      : IN std_logic;
		carryIn  : IN std_logic;
		result   : OUT std_logic;
		carryOut : OUT std_logic
	);
END fullAdder;


ARCHITECTURE behaviour OF fullAdder IS
COMPONENT halfAdder
	PORT (
			in1   : IN  std_logic;
			in2   : IN  std_logic;
			res   : OUT std_logic;
			carry : OUT std_logic
	);
END COMPONENT;
	SIGNAL x : std_logic;
	SIGNAL y : std_logic;
	SIGNAL z : std_logic;
BEGIN
	ad0: halfAdder PORT MAP(in0, in1, x, y);
	ad1: halfAdder PORT MAP(x, carryIn, result, z);
	carryOut <= y OR z;
END behaviour;