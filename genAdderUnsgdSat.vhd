LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY genAdderUnsgndSat IS
	GENERIC(
		value_len : integer
	);
	PORT(
		value0 : IN std_logic_vector(value_len-1 downto 0);
		value1 : IN std_logic_vector(value_len-1 downto 0);
		output : OUT std_logic_vector(value_len-1 downto 0)
	);
END genAdderUnsgndSat;


ARCHITECTURE behavior OF genAdderUnsgndSat IS

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
	SIGNAL result : std_logic_vector(value_len-1 downto 0);
	SIGNAL overflow : std_logic;
BEGIN
	add : genAdder GENERIC MAP (value_len) PORT MAP (value0, value1, result, overflow);

	WITH overflow SELECT
		output	<= 	result 				WHEN '0',
							(OTHERS => '1') 	WHEN '1',
							result				WHEN OTHERS;
END behavior;
