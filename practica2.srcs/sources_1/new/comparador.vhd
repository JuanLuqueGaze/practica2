
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY comparador IS
    GENERIC (
        Nbit : INTEGER := 8;
        End_Of_Screen : INTEGER := 10;
        Start_Of_Pulse : INTEGER := 20;
        End_Of_Pulse : INTEGER := 30;
        End_Of_Line : INTEGER := 40);
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        data : IN STD_LOGIC_VECTOR (Nbit - 1 DOWNTO 0);
        O1 : OUT STD_LOGIC;
        O2 : OUT STD_LOGIC;
        O3 : OUT STD_LOGIC);

END comparador;

ARCHITECTURE Behavioral OF comparador IS
    SIGNAL datau : Unsigned(Nbit - 1 DOWNTO 0);
BEGIN
    datau <= Unsigned(data);

    sinc : PROCESS (clk, reset, data)
    BEGIN
        IF (reset = '1') THEN
            O1 <= '0';
            O2 <= '0';
            O3 <= '0';
        ELSIF (rising_edge(clk)) THEN
            IF (datau > End_Of_Screen) THEN
                O1 <= '1';
            ELSE
                O1 <= '0';
            END IF;

            IF (datau > Start_Of_Pulse AND datau < End_Of_Pulse) THEN
                O2 <= '0';
            ELSE
                O2 <= '1';
            END IF;

            IF (datau = End_Of_Line) THEN
                O3 <= '1';
            ELSE
                O3 <= '0';
            END IF;

        END IF;
    END PROCESS;
END Behavioral;