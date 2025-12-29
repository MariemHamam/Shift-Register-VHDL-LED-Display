library ieee;
use ieee.std_logic_1164.all;

entity hc595 is
    port (
        srclk : in  std_logic;  -- SH_CP (Shift Clock)
        rclk  : in  std_logic;  -- ST_CP (Latch Clock)
        ser   : in  std_logic;  -- DS (Serial Data Input)
        q7s   : out std_logic;  -- Q7' (Serial Output)
        q     : out std_logic_vector(7 downto 0)  -- Q0-Q7
    );
end entity;

architecture rtl of hc595 is
    signal shift_reg : std_logic_vector(7 downto 0) := (others => '0');
begin

    -- Shift Register Process
    process(srclk)
    begin
        if rising_edge(srclk) then
            shift_reg <= shift_reg(6 downto 0) & ser;
        end if;
    end process;

    q7s <= shift_reg(7);

    -- Output Latch Process
    process(rclk)
    begin
        if rising_edge(rclk) then
            q <= shift_reg;
        end if;
    end process;

end architecture;
