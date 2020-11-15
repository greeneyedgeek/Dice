-- File Name: SevenSegment.vhd
-- Project Name: Dice
--
-- This entity takes a 4-bit number [range 1 to 6] and 
-- converts it into a 7-bit value for a seven segment display
--
-- Author: Gabriel Fontaine-Escobar	
-- Date Created: Nov. 14, 2020
-- Date Modified: Nov. 14, 2020

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SevenSegment is
  port (
    i_en : in std_logic;
    i_data : in std_logic_vector (3 downto 0);
    o_data : out std_logic_vector (6 downto 0)
  );
end SevenSegment;

architecture rtl of SevenSegment is
begin
    process (i_en)
      begin
      if (i_en = '1') then
      case i_data is
        when "0000" =>
          o_data <= "1111110";	
        when "0001" =>
          o_data <= "0000110";
        when "0010" =>
          o_data <= "1011011";
        when "0011" =>
          o_data <= "1001111";
        when "0100" =>
          o_data <= "0100111";
        when "0101" =>
          o_data <= "1101101";		
        when "0110" =>
          o_data <= "1111101";
        when "0111" =>
          o_data <= "1000110";
        when "1000" =>
          o_data <= "1111111";		
        when others =>
          o_data <= "1100111";
      end case;
    else 
      --do nothing
    end if;
	end process;
end architecture ; -- rtl of SevenSegment