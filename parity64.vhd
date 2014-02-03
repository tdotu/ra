LIBRARY ieee ;
USE ieee.std_logic_1164.all ;


ENTITY parity64 IS

	PORT(
		field : IN std_logic_vector(63 downto 0);
		paritybit :	OUT std_logic
	);
	
END parity64;


ARCHITECTURE behavior OF parity64 IS
COMPONENT parity8
	PORT(
		byte : IN std_logic_vector(7 downto 0);
		paritybit :	OUT std_logic
	);
END COMPONENT;

SIGNAL p : std_logic_vector(7 downto 0);

BEGIN
	bp1: parity8 PORT MAP (field(7 downto 0), p(7));
	bp2: parity8 PORT MAP (field(14 downto 7), p(6));
	bp3: parity8 PORT MAP (field(21 downto 14), p(5));
	bp4: parity8 PORT MAP (field(28 downto 21), p(4));
	bp5: parity8 PORT MAP (field(35 downto 28), p(3));
	bp6: parity8 PORT MAP (field(42 downto 35), p(2));
	bp7: parity8 PORT MAP (field(49 downto 42), p(1));
	bp8: parity8 PORT MAP (field(56 downto 49), p(0));
	cp: parity8 PORT MAP (p, paritybit);
END behavior;
