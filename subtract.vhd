LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY subtract IS
	GENERIC(
		value_len : integer
	);
	PORT(
		minuend : IN std_logic_vector(value_len-1 downto 0);
		subtrahend : IN std_logic_vector(value_len-1 downto 0);
		output : OUT std_logic_vector(value_len-1 downto 0);
		overflow : OUT std_logic
	);
END subtract;


ARCHITECTURE behavior OF subtract IS
COMPONENT genAdder
	GENERIC(
		value_len : integer
	);
	PORT(
		value0 : IN std_logic_vector(value_len-1 downto 0);
		value1 : IN std_logic_vector(value_len-1 downto 0);
		output : OUT std_logic_vector(value_len-1 downto 0);
		overflow : OUT std_logic
	);
END COMPONENT;
COMPONENT invert_arithmetic
	GENERIC
	(
		length : integer
	);
	PORT
	(
		input : IN std_logic_vector(length-1 downto 0);
		output : OUT std_logic_vector(length-1 downto 0)
	);
END COMPONENT;
	SIGNAL subtrahend_negative : std_logic_vector(value_len-1 downto 0);
BEGIN
	inv : invert_arithmetic GENERIC MAP (value_len) PORT MAP (subtrahend, subtrahend_negative);
	add : genAdder GENERIC MAP (value_len) PORT MAP (minuend, subtrahend_negative, output, overflow);
END behavior;