LIBRARY ieee ;
USE ieee.std_logic_1164.all ;


ENTITY control IS
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
END control;


ARCHITECTURE behavior OF control IS
BEGIN
	WITH instruction SELECT					-- 00 = Branch
		Branch <=	"10" WHEN "000000",	-- 3 downto 0 = equal zero or not equal zero
						"11" WHEN "001111",
						"00" WHEN OTHERS;
							
	WITH instruction SELECT					-- 01 = ALU
		ALUOp <= "0000" WHEN	"010000",	-- 3 downto 0 = ALU-Code
					"0001" WHEN	"010001",
					"0010" WHEN	"010010",
					"0110" WHEN	"010110",
					"0111" WHEN	"010111",
					"1100" WHEN	"011100",
					"1111" WHEN "100000",	
					"1111" WHEN OTHERS;
					
	WITH instruction SELECT
		MemWrite <= '1' WHEN "100000",
						'0' WHEN OTHERS;
						
	WITH instruction SELECT
		MemtoReg <= '1' WHEN "100001",
						'0' WHEN OTHERS;
						
	WITH instruction SELECT
		ALUSrc <=	'1' WHEN "100000",
						'1' WHEN "100001",
						'0' WHEN OTHERS;
						
	WITH instruction SELECT
		RegWrite <= '1' WHEN "010000",
						'1' WHEN "010001",
						'1' WHEN "010010",
						'1' WHEN "010110",
						'1' WHEN "010111",
						'1' WHEN "011100",
						'0' WHEN OTHERS;
		
	WITH instruction SELECT
		RegDst <= 	'1' WHEN "010000",
						'1' WHEN "010001",
						'1' WHEN "010010",
						'1' WHEN "010110",
						'1' WHEN "010111",
						'1' WHEN "011100",
						'0' WHEN OTHERS;
	
END behavior;