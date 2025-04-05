library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tt_um_example is
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
end tt_um_example;

architecture Behavioral of tt_um_example is
signal numb_a : unsigned(3 downto 0);
signal numb_b : unsigned(3 downto 0);
signal c : unsigned(7 downto 0);
signal op :  unsigned(1 downto 0);
-- en till signal för opp
begin
    numb_a <= unsigned(ui_in(3 downto 0));
    numb_b <= unsigned(ui_in(7 downto 4));
    op <= unsigned(uio_in(1 downto 0));

    process(op, numb_a, numb_b)
    begin
        case op is 
            when "00" => c <= "00000000" & (numb_a + numb_b);
            when "01" => c <= "00000000" & (numb_a - numb_b);
            when "10" => c <= "00000000" & (numb_a * numb_b);
            when others => c <= "00000000" & (numb_a mod numb_b);
        end case;
    end process;
    
    uo_out <= std_logic_vector(c);
    --uo_out <= std_logic_vector(unsigned(ui_in) + unsigned(uio_in));
    --uo_out <= not (ui_in and uio_in);
    uio_out <= "00000000";
    uio_oe <= "00000011";

end Behavioral; 