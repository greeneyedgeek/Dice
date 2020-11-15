-- File Name: Dice_top.vhd
-- Project Name: Dice
--
-- FPGA Dice based on the MVC design pattern and using a LFSR for generating a random number.
--
-- Author: Gabriel Fontaine-Escobar	
-- Date Created: Nov. 14, 2020
-- Date Modified: Nov. 14, 2020

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Dice_top is
	port (
		clk : in std_logic; --clock
		en : in std_logic; --generate a random number
		--rst : in std_logic --reset the dice
		hex : out std_logic_vector(6 downto 0);
		o_led : out std_logic := '0'
	);
end Dice_top;

architecture RTL of Dice_top is
	--The dice controller
	component Controller is
		port (
			i_clk : in std_logic; --clock
			i_en : in std_logic;
			--i_data : in std_logic;
			o_data : out std_logic_vector(6 downto 0)
		);
	end component;
begin
	u0 : Controller port map (
		i_clk => clk,
		i_en => en,
		o_data => hex 
	);
end architecture RTL; --of Dice_top
