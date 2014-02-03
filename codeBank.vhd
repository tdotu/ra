LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.numeric_std.all;

ENTITY codeBank IS
	PORT
	(
		adress : IN std_logic_vector(31 downto 0);
		output : OUT std_logic_vector(31 downto 0)
	);
END codeBank;

ARCHITECTURE behaviour OF codeBank IS
BEGIN
	WITH adress SELECT
		output <=	"10000000000000000000000000000000" WHEN std_logic_vector(to_unsigned(0, 32)),
						"10000000001000010000000000000000" WHEN std_logic_vector(to_unsigned(1, 32)),
						"01001000000000000001100000000000" WHEN std_logic_vector(to_unsigned(2, 32)),
						"10000000011000110000000000000000" WHEN std_logic_vector(to_unsigned(3, 32)),
						(OTHERS => '0') WHEN OTHERS;
END behaviour;