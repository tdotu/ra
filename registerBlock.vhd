LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.numeric_std.all;

ENTITY registerBlock IS
	GENERIC
	(
		regSize : integer
	);
	PORT
	(
		regWrite : IN std_logic;
	
		read0 : IN std_logic_vector(4 downto 0);
		read1 : IN std_logic_vector(4 downto 0);
		write0 : IN std_logic_vector(4 downto 0);

		input0 : IN std_logic_vector(regSize-1 downto 0);
		output0 : OUT std_logic_vector(regSize-1 downto 0);
		output1 : OUT std_logic_vector(regSize-1 downto 0)
	);
END registerBlock;

ARCHITECTURE behavior OF registerBlock IS

COMPONENT reg IS
	GENERIC
	(
		width : integer
	);

	PORT
	(
		clock : IN std_logic;
		change : IN std_logic_vector(width-1 downto 0);
		state : OUT std_logic_vector(width-1 downto 0)
	);
END COMPONENT;

SUBTYPE outSignal IS std_logic_vector(regSize-1 downto 0);
TYPE outSignalArray IS ARRAY(integer RANGE 0 TO 31) OF outSignal;

SIGNAL outSignals : outSignalArray;
SIGNAL writeBit : std_logic_vector(31 downto 0);

BEGIN
	output0 <= "00000000000000000000000000000100" WHEN read0 = std_logic_vector(to_unsigned(0, 5)) ELSE (OTHERS => 'Z');
	output1 <= "00000000000000000000000000000100" WHEN read1 = std_logic_vector(to_unsigned(0, 5)) ELSE (OTHERS => 'Z');

	gen0 : FOR X IN 1 TO 31 GENERATE
		regx : reg GENERIC MAP (regSize) PORT MAP (writeBit(X), input0, outSignals(X));
		output0 <= outSignals(X) WHEN read0 = std_logic_vector(to_unsigned(X, 5)) ELSE (OTHERS => 'Z');
		output1 <= outSignals(X) WHEN read1 = std_logic_vector(to_unsigned(X, 5)) ELSE (OTHERS => 'Z');
		writeBit(X) <= regWrite WHEN write0 = std_logic_vector(to_unsigned(X, 5)) ELSE '0';
	END GENERATE gen0;
END behavior;
