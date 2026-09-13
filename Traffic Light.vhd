library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sample is
    port(
        TR: in std_logic;
        TS: in std_logic;
        TL: in std_logic;
        BWE: in std_logic;
        BLT: in std_logic;
        clk: in std_logic;
        Q: out std_logic_vector(2 downto 0)
    );
end sample;

architecture rtl of sample is

begin
    process(clk)
    begin
        if (rising_edge(clk)) then
        	case Q is
            	    when "000" => if (TL = '0') then Q <= "000";
                            else Q <= "001";
                            end if;
                     when "001" => if (TS = '1') then Q <= "001";
                            elsif (TS = '0' and BWE = '1'  and TR = '0' AND BLT=’0’) then Q <= "010";
                            elsif (TS = '0' and TR = '0' and BLT = '1') then Q <= "100";
		    ELSE Q<”000”;
		     –ELSIF (TS=’0’ AND TR=’1’) THEN Q<”000”;
		     –ELSIF (TS=’0’ AND TR=’0’ AND BWE=’0’AND BLT=’0’) THEN Q<”000”;
                            end if;
                      when "010" => if (TL = '1' and TR = '0') then Q <= "010";
                             elsif (TL = '0' or TR = '1') then Q <= "011";
                             end if;
                      when "011" => if (TS = '1') then Q <= "011";
                             elsif (TS = '0' and TR = '0' and BLT = '1') then Q <= "100";
                             elsif (TS = '0' and (BLT = '0' or TR = '1')) then Q <= "000";
                             end if;
                      when "100" => if (TL = '1' and TR = '0') then Q <= "100";
                             elsif (TL = '0' and TR = '1') then Q <= "101";
                             end if;
                      when "101" => if (TS = '1') then Q <= "101";
                             elsif (TS = '0') then Q <= "000";
                             end if;
			when others => Q <="000";  
			end case;
                    end if;
		end process;
	end rtl;
