-- File Name: Controller.vhd
-- Project Name: Dice
--
-- A controller module requesting a random number from the number and sending the response the the view
--
-- Author: Gabriel Fontaine-Escobar	
-- Date Created: Nov. 14, 2020
-- Date Modified: Nov. 14, 2020

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Controller is
	port (
		i_clk : in std_logic; --clock
		i_en : in std_logic;
		--rst : in std_logic;
		--load : in std_logic;
		--i_data : in std_logic;
		o_data : out std_logic_vector(6 downto 0)
	);
end Controller;

architecture RTL of Controller is
--	signal i_data;
	signal lfsr_en : std_logic;
	signal lfsr_clk : std_logic;
	signal lfsr_res : std_logic_vector(2 downto 0);
	signal view_clk : std_logic;
	signal view_en : std_logic;
	signal view_data : std_logic_vector(2 downto 0);
	signal view_o_data : std_logic_vector(6 downto 0);
	--LFSR component for generating random numbers
	component LFSR is
		generic (
			N : integer := 3 --result [0..7]
		);
		port (
			i_clk : in std_logic; --clock
			i_en : in std_logic; --enable process
			o_res : out std_logic_vector ((N-1) downto 0) --output result
		);
	end component;

	component View is
		port (
			i_clk : in std_logic; --clock
			i_en : in std_logic;
			i_data : in std_logic_vector(2 downto 0);
			o_data : out std_logic_vector (6 downto 0)
		);
	end component;

begin
	
	lfsr_en <= i_en;
	view_en <=i_en;
	lfsr_clk <= i_clk;
	view_clk <= i_clk;
	view_data <= lfsr_res;
	o_data <= view_o_data;

	u1 : LFSR port map (
		i_clk => lfsr_clk,
		i_en => lfsr_en,
		o_res => lfsr_res
	);
	u2 : View port map (
		i_clk => view_clk,
		i_en => view_en,
		i_data => view_data,
		o_data => view_o_data
	);
end architecture RTL; --of Controller
