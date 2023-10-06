
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY frec_pixel IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        clk_pixel : OUT STD_LOGIC);
END frec_pixel;
ARCHITECTURE Behavioral OF frec_pixel IS
    SIGNAL cuenta : unsigned(1 DOWNTO 0);
BEGIN
    sinc : PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            cuenta <= "00";
        ELSIF rising_edge(clk) THEN
            cuenta <= cuenta + 1;
        END IF;
    END PROCESS;

    comb : PROCESS (cuenta)
    BEGIN
        IF (cuenta = 3) THEN
            clk_pixel <= '1';
        ELSE
            clk_pixel <= '0';
        END IF;
    END PROCESS;

END Behavioral;