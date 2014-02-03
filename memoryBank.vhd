LIBRARY ieee ;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY memoryBank IS
	GENERIC
	(
		adressWidth : integer;
		memorySize  : integer;
		wordLength : integer
	);
	PORT
	(
		adress : IN std_logic_vector(adressWidth-1 downto 0);
		writeBit : IN std_logic; -- if 1 then write input to adressed dword
		input : IN std_logic_vector(wordLength-1 downto 0);
		output : OUT std_logic_vector(wordLength-1 downto 0) -- value of the selected dword
	);
END memoryBank;



ARCHITECTURE behaviour OF memoryBank IS

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
	SUBTYPE cellLane IS std_logic_vector(wordLength-1 downto 0);
	TYPE memoryLane IS ARRAY(integer RANGE 0 TO memorySize-1) OF cellLane;
	
	SIGNAL outputLane  : memoryLane;
	SIGNAL cellWrite : std_logic_vector(memorySize-1 downto 0);

BEGIN
	gen0 : FOR X IN 0 TO memorySize-1 GENERATE
		regx : reg GENERIC MAP (wordLength) PORT MAP (cellWrite(X),input,outputLane(X)); -- create cells
		output <= outputLane(X) WHEN (adress = std_logic_vector(to_unsigned(X, adressWidth))) ELSE (OTHERS => 'Z');
		cellWrite(X) <= writeBit WHEN adress = std_logic_vector(to_unsigned(X, adressWidth))  ELSE '0';
	END GENERATE;
END behaviour;
