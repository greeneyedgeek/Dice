-- File Name: RandomGenerator.vhd
-- Project Name: GenERIC LFSR VHDL IMPLEMenTATION
--
-- A simple LFSR used to generate a random number from 1 to 6.
--
-- Author: Gabriel Fontaine-Escobar	
-- Date Created: Oct. 12, 2020
-- Date Modified: Oct. 12, 2020
--																										
-- References 
-- Alfke, P. Efficient Shift Registers, LFSR Counters, and Long PseudoRandom Sequence Generators. Xilinx Application Note. 1996

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LFSR is
	generic (
		N : integer := 3; -- For a 6-face dice: N=3. 
		TAP1 : integer := 2; -- TAPS FOR N=3: TAP1 = 3, TAP2 = 3	-- ** CHECK IF OK
		TAP2 : integer := 1  -- FROM XILINX APP NOTE (1996)
	);
	port (
		i_clk : in std_logic; --clock
		i_en : in std_logic; --enable process
		o_res : out std_logic_vector ((N-1) downto 0) --output result
	);
end LFSR;

architecture RTL of LFSR is
--signal RAND, RAND_NXT, RAND_DONE : std_logic_vector ((N-1) downto 0);
--signal CNT, CNT_NXT : natural (6 downto 0); --256 values

signal q : std_logic_vector ((N-1) downto 0);
signal continue : std_logic := '0';

--TBI
--signal rst : std_logic; --reset
--signal load : std_logic; --when we want to load external data
--signal data : std_logic; --data to load

begin
	result_proc : process(q)
	begin
		if (q > "000" and q < "111") then o_res <= q; continue <= '0';
		else continue <= '1';
		end if;
	end process; --result_proc

	LFSR_proc : process(i_clk)
	begin
		--if (rst = '1') then 
		--	q <= (others => '1'); --CNT <= '0' elsif
		if (rising_edge(i_clk)) then
			if (i_en = '1' or continue = '1') then
				q(N-1) <= ((q(TAP1) xnor q(TAP2)));--remove ); ADD-> and (not load)) or (load and data);
				q((N-2) downto 0) <= q((N-1) downto 1);
			end if;
		end if;
	end process; --LFSR_proc
end architecture RTL; --of LFSR