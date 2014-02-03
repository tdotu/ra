LIBRARY ieee ;
USE ieee.std_logic_1164.all;

ENTITY counter IS
	GENERIC(n: integer);
	PORT (	clock: IN STD_LOGIC;
		q: OUT STD_LOGIC_VECTOR(n-1 downto 0));
END counter;

ARCHITECTURE behavior OF counter IS
	component jk_ff
		PORT (	clock: IN STD_LOGIC;
			j: IN STD_LOGIC;
			k: IN STD_LOGIC;
			reset: IN STD_LOGIC;
			q: OUT STD_LOGIC;
			q_neg: OUT STD_LOGIC);
	end component;

	SIGNAL count: STD_LOGIC_VECTOR(n-1 downto 0);
	SIGNAL count_neg: STD_LOGIC_VECTOR( n-1 downto 0);
	
	BEGIN	
		count0:	jk_ff port map (clock, '1', '1', '0', count(0), count_neg(0));
		
		basis:	for K in 1 to n-1 generate
				countX:	jk_ff port map (clock, count(K-1), count(K-1), '0', count(K), count_neg(K));
		end generate basis;

		q <= count(n-1 downto 0);
	END behavior;