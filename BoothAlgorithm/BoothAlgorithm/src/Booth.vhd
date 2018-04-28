-------------------------------------------------------------------------------
--
-- Title       : Booth_ent
-- Design      : BoothAlgorithm
-- Author      : khater
-- Company     : TFE
--
-------------------------------------------------------------------------------
--
-- File        : Booth.vhd
-- Generated   : Fri Apr 27 01:04:49 2018
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {Booth_ent} architecture {Booth_arch}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Booth_ent is
	 port(
		 q : in STD_LOGIC_VECTOR(7 downto 0);
		 m : in STD_LOGIC_VECTOR(7 downto 0); 
		 prod : out STD_LOGIC_VECTOR(15 downto 0)
	     );
end Booth_ent;

--}} End of automatically maintained section

architecture Booth_arch of Booth_ent is	

begin
	
	process(q, m) 
	variable prod_tmp:std_logic_vector(15 downto 0):= "0000000000000000";  
	variable q_tmp:std_logic_vector(8 downto 0);
	variable m_comp:std_logic_vector(15 downto 0);	 
	variable flag:std_logic:= '0';  
	variable op:std_logic_vector(1 downto 0):= "00";
	variable addition:std_logic_vector(15 downto 0);	 
	variable m_tmp:std_logic_vector(15 downto 0);	
	variable c_tmp:std_logic_vector(16 downto 0):= "00000000000000000";
	begin		
	flag := '0';
	prod_tmp:= "0000000000000000";
	q_tmp(8 downto 0) := q(7 downto 0) & '0';
	m_tmp(7 downto 0) := m(7 downto 0);
	for i in 0 to 7 loop
		if flag = '1' then
			if m(i) = '0' then
				m_comp(i) := '1';
			elsif m(i) = '1' then
				m_comp(i) := '0';
			end if;
		elsif flag = '0' then
			m_comp(i) := m(i);
			if m(i) = '1' then
				flag := '1';
			end if;
		end if;	
	end loop; 
	for i in 8 to 15 loop
		m_comp(i) := m_comp(i - 1);
		m_tmp(i) := m_tmp(i - 1);
	end loop; 
	for i in 0 to 7 loop	 
		c_tmp := "00000000000000000";
		addition := "0000000000000000";
		op := "00";
		if q_tmp(i) = '0' and q_tmp(i + 1) = '1' then 
			op := "01";
		elsif q_tmp(i) = '1' and q_tmp(i + 1) = '0' then
			op := "10";
		end if;
		if op = "01" then
			addition(15 downto 0) := m_comp(15 downto 0);
		elsif op = "10" then
			addition(15 downto 0) := m_tmp(15 downto 0);  
		end if;					
		for j in 0 to i - 1 loop
				addition(15 downto 0) := addition(14 downto 0) & '0';
				end loop;
		if op = "01" or op = "10" then
			N2:for j in 0 to 15 loop
				c_tmp(j + 1) := (addition(j) and prod_tmp(j)) or (prod_tmp(j) and c_tmp(j)) or (addition(j) and c_tmp(j));
				prod_tmp(j) := prod_tmp(j) xor addition(j) xor c_tmp(j);
			end loop;				  
		end if;
	end loop;  
	prod(15 downto 0) <= prod_tmp(15 downto 0);
	end process;
end Booth_arch;
