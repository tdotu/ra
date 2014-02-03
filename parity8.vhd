LIBRARY ieee ;
USE ieee.std_logic_1164.all ;


ENTITY parity8 IS

	PORT(
		byte : IN std_logic_vector(7 downto 0);
		paritybit :	OUT std_logic
	);
	
END parity8;


ARCHITECTURE behavior OF parity8 IS
BEGIN	
	paritybit <= byte(7) XOR byte(6) XOR byte(5) XOR byte(4) XOR byte(3) XOR byte(2) XOR byte(1) XOR byte(0);
END behavior;
