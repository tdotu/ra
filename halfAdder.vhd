LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY halfAdder IS

	PORT (
			in1   : IN  std_logic;
			in2   : IN  std_logic;
			res   : OUT std_logic;
			carry : OUT std_logic
	);

END halfAdder;


ARCHITECTURE behavior OF halfAdder IS
BEGIN

	res <= in1 XOR in2;
	carry <= in1 AND in2;

END behavior;
