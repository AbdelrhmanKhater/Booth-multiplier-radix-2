library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity booth_ent_tb is
end booth_ent_tb;

architecture TB_ARCHITECTURE of booth_ent_tb is
	-- Component declaration of the tested unit
	component booth_ent
	port(
		q : in STD_LOGIC_VECTOR(7 downto 0);
		m : in STD_LOGIC_VECTOR(7 downto 0);
		prod : out STD_LOGIC_VECTOR(15 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal q : STD_LOGIC_VECTOR(7 downto 0);
	signal m : STD_LOGIC_VECTOR(7 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal prod : STD_LOGIC_VECTOR(15 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : booth_ent
		port map (
			q => q,
			m => m,
			prod => prod
		);

	-- Add your stimulus here ...
	process
	begin 
		q <= "00000100";
		m <= "00000010";
		wait for 100 ns;  
		q <= "00000100";
		m <= "00000100";
		wait for 100 ns;
		q <= "00000100";
		m <= "00000100";
		wait for 100 ns;
		q <= "00000100";
		m <= "00000010";
		wait for 100 ns;
		end process;
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_booth_ent of booth_ent_tb is
	for TB_ARCHITECTURE
		for UUT : booth_ent
			use entity work.booth_ent(booth_arch);
		end for;
	end for;
end TESTBENCH_FOR_booth_ent;

