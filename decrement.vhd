LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY decrement IS
   GENERIC
   (
      length : integer
   );
   PORT
	(
      input : IN std_logic_vector(length-1 downto 0);
		output : OUT std_logic_vector(length-1 downto 0);
		sgnchange : OUT std_logic
    );
END decrement;


ARCHITECTURE behavior OF decrement IS
COMPONENT increment
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
	SIGNAL ic0 : std_logic_vector(length-1 downto 0);
	SIGNAL ic1 : std_logic_vector(length-1 downto 0);
BEGIN
	inv0 : invert_arithmetic GENERIC MAP(length) PORT MAP(input, ic0);
	inc : increment GENERIC MAP(length) PORT MAP(ic0, ic1, sgnchange);
	inv1 : invert_arithmetic GENERIC MAP(length) PORT MAP(ic1, output);
END behavior;