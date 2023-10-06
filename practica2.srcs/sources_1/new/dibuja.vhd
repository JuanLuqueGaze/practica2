LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY dibuja IS
    PORT (
        eje_x : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
        eje_y : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
        MODI : IN STD_LOGIC;
        RED : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        GRN : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        BLU : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END dibuja;

ARCHITECTURE Behavioral OF dibuja IS
    SIGNAL RED_in, GRN_in, BLU_in : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
    RED <= RED_in;
    GRN <= GRN_in;
    BLU <= BLU_in;
    dibuja : PROCESS (eje_x, eje_y)
    BEGIN
        RED_in <= "1111";
        GRN_in <= "1111";
        BLU_in <= "1111";
        IF ((unsigned(eje_x) > 278 AND unsigned(eje_x) < 358) OR
            (unsigned(eje_y) > 209 AND unsigned(eje_y) < 269)) THEN
            IF MODI = '0' THEN
                RED_in <= "1111";
                GRN_in <= "0000";
                BLU_in <= "0000";
            ELSE
                RED_in <= "0000";
                GRN_in <= "0000";
                BLU_in <= "1111";
            END IF;
        END IF;
    END PROCESS;

END Behavioral;