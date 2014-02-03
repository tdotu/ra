LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY ALU IS
	GENERIC
	(
		size : integer
	);
	PORT
	(
		input0 	: IN std_logic_vector(size-1 downto 0);
		input1 	: IN std_logic_vector(size-1 downto 0);
		control 	: IN std_logic_vector(3 downto 0);
		clock : IN std_logic;
		output 	: OUT std_logic_vector(size-1 downto 0);
		zero 		: OUT std_logic
	);
END ALU;

ARCHITECTURE behavior OF ALU IS

COMPONENT genAND IS
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
END COMPONENT;

COMPONENT genOR IS
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
END COMPONENT;

COMPONENT genAdder IS
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

COMPONENT slt IS
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
END COMPONENT;

COMPONENT genNOR IS
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
END COMPONENT;

COMPONENT selfOR IS
	GENERIC
	(
		size : integer
	);
	PORT
	(
		input : IN std_logic_vector(size-1 downto 0);
		output : OUT std_logic
	);
END COMPONENT;

COMPONENT dFlipFlop IS
	PORT
	(
		c : IN std_logic;
		i : IN std_logic;
		q : OUT std_logic
	);
END COMPONENT;

SIGNAL andres 	: std_logic_vector(size-1 downto 0);
SIGNAL orres 	: std_logic_vector(size-1 downto 0);
SIGNAL addres 	: std_logic_vector(size-1 downto 0);
SIGNAL subres 	: std_logic_vector(size-1 downto 0);
SIGNAL sltres 	: std_logic_vector(size-1 downto 0);
SIGNAL norres 	: std_logic_vector(size-1 downto 0);

SIGNAL result : std_logic_vector(size-1 downto 0);

SIGNAL zerosafe : std_logic;

SIGNAL dontcare0 : std_logic;
SIGNAL dontcare1 : std_logic;

BEGIN
	andu 	: genAND 	GENERIC MAP (size) PORT MAP (input0, input1, andres);
	oru 	: genOR 		GENERIC MAP (size) PORT MAP (input0, input1, orres);
	addu 	: genAdder 	GENERIC MAP (size) PORT MAP (input0, input1, addres, dontcare0);
	subu 	: subtract 	GENERIC MAP (size) PORT MAP (input0, input1, subres, dontcare1);
	sltu 	: slt 		GENERIC MAP (size) PORT MAP (input0, input1, sltres);
	noru 	: genNOR 	GENERIC MAP (size) PORT MAP (input0, input1, norres);

	WITH control SELECT
		result <= andres 				WHEN "0000",
					 orres 				WHEN "0001",
					 addres				WHEN "0010",
					 subres 				WHEN "0110",
					 sltres				WHEN "0111",
					 norres				WHEN "1100",
					 input0				WHEN "1110",
					 input1				WHEN "1111",
					 (OTHERS => '0')	WHEN OTHERS;
					
	output <= result;			 
	z : selfOR GENERIC MAP (size) PORT MAP (result, zerosafe);
	safe : dFlipFlop PORT MAP(NOT clock, zerosafe, zero);
END behavior;