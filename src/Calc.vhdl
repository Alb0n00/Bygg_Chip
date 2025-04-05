library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tt_um_hot_chick is
    port (
        ui_in   : in  std_logic_vector(7 downto 0);
        uo_out  : out std_logic_vector(7 downto 0);
        uio_in  : in  std_logic_vector(7 downto 0);
        uio_out : out std_logic_vector(7 downto 0);
        uio_oe  : out std_logic_vector(7 downto 0);
        ena     : in  std_logic;
        clk     : in  std_logic;
        rst_n   : in  std_logic
    );
end tt_um_hot_chick;

architecture Behavioral of tt_um_hot_chick is
signal numb_a : unsigned(7 downto 0);
signal numb_b : unsigned(7 downto 0);
signal numb_c : unsigned(7 downto 0);
signal op :  unsigned(2 downto 0);

type rom is array (0 to 15) of std_logic_vector(3 downto 0);
  constant mem : rom := ( -- Talet -> vart i topp
    "0000",
    "0010",
    "0001",
    "1101",
    "0011",
    "0100",
    "0101",
    "1001",
    "1000",
    "0111",
    "1010",
    "1111",
    "0110",
    "1100",
    "1011",
    "1110"
  );
begin
    numb_a <= "0000" & unsigned(ui_in(3 downto 0));
    numb_b <= "0000" & unsigned(ui_in(7 downto 4));
    op <= unsigned(uio_in(2 downto 0));

    process(op, numb_a, numb_b)
    begin
        case op is 
            when "000" => numb_c <= (numb_a + numb_b);
            when "001" => numb_c <= not ((not numb_a) + numb_b);
            when "010" => numb_c <= resize(numb_a * numb_b, 8);
            when "011" => numb_c <= (numb_a mod numb_b);
            when "100" =>
                if mem(to_integer(numb_a)) < mem(to_integer(numb_b)) then 
                    numb_c <= numb_a;
                else 
                    numb_c <= numb_b;
                end if;
            when "101" => numb_c <= unsigned(ui_in(7 downto 0)) + 13;
            when "110" => numb_c <= unsigned(ui_in(7 downto 0)) - 13;
            when others => numb_c <= "00000000";
        end case;
    end process;
    
    uo_out <= std_logic_vector(numb_c);
    uio_out <= "00000000";
    uio_oe <= "00000011";

end Behavioral; 