library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity button_debouncer is
	generic(
		debounce_clk_cnt : integer
	);
	
	port (
		clk : in std_logic;
		btn_in : in std_logic;
		btn_debounced : out std_logic := '0'
	);
end entity;

architecture beh of button_debouncer is
	signal cnt : integer range 0 to debounce_clk_cnt := 0;
begin

	process(clk)
	begin
	
		if rising_edge(clk) then
			if btn_in = '0' then
				cnt <= 0;
			elsif btn_in = '1' and cnt /= debounce_clk_cnt then
				cnt <= cnt + 1;
			end if;
		end if;
	
	end process;

	btn_debounced <= '1' when cnt = debounce_clk_cnt else '0';
	
end architecture;