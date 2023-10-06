LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY contador IS
    GENERIC (
        Nbit : INTEGER := 8
    );
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        enable : IN STD_LOGIC;
        resets : IN STD_LOGIC;
        Q : OUT STD_LOGIC_VECTOR(Nbit - 1 DOWNTO 0)
    );
END contador;

ARCHITECTURE Behavioral OF contador IS
    SIGNAL cuenta, prevcuenta : Unsigned(Nbit - 1 DOWNTO 0);

BEGIN
    sinc : PROCESS (clk, reset, prevcuenta)
    BEGIN
        IF (reset = '1') THEN
            cuenta <= (OTHERS => '0');
        ELSIF (rising_edge(clk)) THEN
            IF (resets = '0'AND enable = '1') THEN
                cuenta <= prevcuenta;
            ELSIF (resets = '1') THEN
                cuenta <= (OTHERS => '0');
            END IF;
        END IF;
    END PROCESS;

    comb : PROCESS (cuenta)

    BEGIN

        prevcuenta <= cuenta + 1;

    END PROCESS;

    Q <= STD_LOGIC_VECTOR(cuenta);
END Behavioral;