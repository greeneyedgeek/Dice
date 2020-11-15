-- File Name: View.vhd
-- Project Name: Dice
--
-- A view module taking a value as an input and outputting to a display
--
-- Author: Gabriel Fontaine-Escobar	
-- Date Created: Nov. 14, 2020
-- Date Modified: Nov. 14, 2020

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity View is
	port (
		i_clk : in std_logic; --clock
		i_en : in std_logic;
		i_data : in std_logic_vector(2 downto 0);
		o_data : out std_logic_vector (6 downto 0)
	);
end View;

architecture rtl of View is

	signal i_temp : std_logic_vector(3 downto 0);
	signal o_temp : std_logic_vector(6 downto 0);
	signal en : std_logic;

	component SevenSegment is
		port (
			i_en : in std_logic;
			i_data : in std_logic_vector (3 downto 0);
			o_data : out std_logic_vector (6 downto 0)
		  );
	end component; --SevenSegment

begin
	ss_proc : process (i_clk,o_temp,i_data, i_en)
	begin
		if(rising_edge(i_clk)) then
			i_temp <= '0'&i_data;
			o_data <= o_temp;
			en <= i_en;
		end if;
	end process; --ss_proc

	u3 : SevenSegment port map (
		i_en => en,
		i_data => i_temp,
		o_data => o_temp
	);
end architecture rtl; --of View