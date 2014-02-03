LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

--FPGA main entity
ENTITY FirstProject IS

	PORT (
			SW : IN std_logic_vector(17 downto 0);
			KEY : IN std_logic_vector(3 downto 0);
			LEDG : OUT std_logic_vector(7 downto 0);
			LEDR : OUT std_logic_vector(17 downto 0);
			HEX0 : OUT std_logic_vector(6 downto 0);
			HEX1 : OUT std_logic_vector(6 downto 0);
			HEX2 : OUT std_logic_vector(6 downto 0);
			HEX3 : OUT std_logic_vector(6 downto 0);
			HEX4 : OUT std_logic_vector(6 downto 0);
			HEX5 : OUT std_logic_vector(6 downto 0);
			HEX6 : OUT std_logic_vector(6 downto 0);
			HEX7 : OUT std_logic_vector(6 downto 0);
			clock_50 : IN std_logic		
	);
END FirstProject ;


ARCHITECTURE behavior OF FirstProject IS
--components
COMPONENT memoryBank IS
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
END COMPONENT;

COMPONENT ALU IS
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
END COMPONENT;

COMPONENT registerBlock IS
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
END COMPONENT;

COMPONENT codeBank IS
	PORT
	(
		adress : IN std_logic_vector(31 downto 0);
		output : OUT std_logic_vector(31 downto 0)
	);
END COMPONENT;

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

COMPONENT increment IS
	GENERIC
	(
		length : integer
	);
	PORT
	(
      input : IN std_logic_vector(length-1 downto 0);
		output : OUT std_logic_vector(length-1 downto 0);
		overflow : OUT std_logic
	);
END COMPONENT;


COMPONENT sevenseghex IS

	PORT(
		nibble : IN std_logic_vector(3 downto 0);
		segments : OUT std_logic_vector(6 downto 0)
	);
	
END COMPONENT;


COMPONENT control IS
	PORT
	(
		instruction : IN std_logic_vector(5 downto 0);
		RegDst : OUT std_logic;
		Branch : OUT std_logic_vector(1 downto 0);
		MemtoReg : OUT std_logic;
		ALUOp : OUT std_logic_vector(3 downto 0);
		MemWrite : OUT std_logic;
		ALUSrc : OUT std_logic;
		RegWrite : OUT std_logic
	);
END COMPONENT;

SIGNAL memAdress : std_logic_vector(31 downto 0);
SIGNAL memIn : std_logic_vector(31 downto 0);
SIGNAL memOut : std_logic_vector(31 downto 0);

SIGNAL aluIn0 : std_logic_vector(31 downto 0);
SIGNAL aluIn1 : std_logic_vector(31 downto 0);
SIGNAL aluControl : std_logic_vector(3 downto 0);
SIGNAL aluOut : std_logic_vector(31 downto 0);
SIGNAL aluZero : std_logic;

SIGNAL regW : std_logic;
SIGNAL regRead0 : std_logic_vector(4 downto 0);
SIGNAL regRead1 : std_logic_vector(4 downto 0);
SIGNAL regWrite0 : std_logic_vector(4 downto 0);
SIGNAL regIn0 : std_logic_vector(31 downto 0);
SIGNAL regOut0 : std_logic_vector(31 downto 0);
SIGNAL regOut1 : std_logic_vector(31 downto 0);

SIGNAL RegDst : std_logic;
SIGNAL Branch : std_logic_vector(1 downto 0);
SIGNAL MemToReg : std_logic;
SIGNAL ALUOp : std_logic_vector(3 downto 0);
SIGNAL MemWrite : std_logic;
SIGNAL ALUSrc : std_logic;
SIGNAL RegWrite : std_logic;

SIGNAL codeAdress : std_logic_vector(31 downto 0);
SIGNAL codeOut : std_logic_vector(31 downto 0);

SIGNAL pcChange : std_logic_vector(31 downto 0);
SIGNAL newPC : std_logic_vector(31 downto 0);

SIGNAL nextCmd : std_logic_vector(31 downto 0);
SIGNAL jmpTarget : std_logic_vector(31 downto 0);

SIGNAL altALUIn : std_logic_vector(31 downto 0);

SIGNAL clock : std_logic;

SIGNAL dsp : std_logic_vector(15 downto 0);
	
BEGIN
	mem: memoryBank GENERIC MAP(32, 64, 32) PORT MAP(memAdress, MemWrite, memIn, memOut);
	code : codeBank PORT MAP(codeAdress, codeOut);
	palu : ALU GENERIC MAP(32) PORT MAP(aluIn0, aluIn1, aluControl, clock, aluOut, aluZero);
	regFile : registerBlock GENERIC MAP(32) PORT MAP(regW, regRead0, regRead1, regWrite0, regIn0, regOut0, regOut1);
	pc : reg GENERIC MAP(32) PORT MAP(clock, newPC, codeAdress);
	cpinc : increment GENERIC MAP(32) PORT MAP(codeAdress, nextCmd, LEDG(0));
	jmp : genAdder GENERIC MAP(32) PORT MAP(nextCmd, altALUIn, jmpTarget, LEDG(1));
	ctrl : control PORT MAP(codeOut(31 downto 26), RegDst, Branch, MemToReg, ALUOp, MemWrite, ALUSrc, RegWrite);
	
	clock <= NOT KEY(0);
	regW <= RegWrite;
	memAdress <= aluOut;
	memIn <= regOut1;
	aluIn0 <= regOut0;
	aluControl <= aluOp;
	regRead0 <= codeOut(25 downto 21);
	regRead1 <= codeOut(20 downto 16);
	altALUIn <= (31 downto 16 => codeOut(15)) & codeOut(15 downto 0);
	LEDR <= SW;
	LEDG(2) <= RegWrite;
	hexseg0 : sevenseghex PORT MAP(regIn0(3 downto 0), HEX0);
	hexseg1 : sevenseghex PORT MAP(regIn0(7 downto 4), HEX1);
	hexseg2 : sevenseghex PORT MAP(regWrite0(3 downto 0), HEX2);
	hexseg3 : sevenseghex PORT MAP(dsp(3 downto 0), HEX3);
	hexseg4 : sevenseghex PORT MAP(codeAdress(3 downto 0), HEX4);
	hexseg5 : sevenseghex PORT MAP(codeAdress(7 downto 4), HEX5);
	hexseg6 : sevenseghex PORT MAP(codeAdress(11 downto 8), HEX6);
	hexseg7 : sevenseghex PORT MAP(codeAdress(15 downto 12), HEX7);
	
	WITH ALUSrc SELECT
		aluIn1 <= 	regOut1 WHEN '0',
						altALUIn WHEN '1',
						(OTHERS => '0') WHEN OTHERS;
						
	WITH MemToReg SELECT
		regIn0 <=	aluOut WHEN '0',
						memOut WHEN '1',
						(OTHERS => '0') WHEN OTHERS;
							
	WITH RegDst SELECT
		regWrite0 <=	codeOut(20 downto 16) WHEN '0',
							codeOut(15 downto 11) WHEN '1',
							(OTHERS => '0') WHEN OTHERS;
	
	WITH memAdress SELECT
		dsp <= 	memIn(15 downto 0) WHEN (OTHERS => '0'),
					dsp 	WHEN OTHERS;
					
	WITH (Branch & aluZero) SELECT
		pcChange <=	jmpTarget WHEN "100",
						jmpTarget WHEN "111",
						nextCmd WHEN OTHERS;
						
	WITH KEY(1) SELECT
		newPC		<= pcChange WHEN '1',
						(OTHERS => '0') WHEN OTHERS;
		
END behavior;
