----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.10.2023 18:16:56
-- Design Name: 
-- Module Name: VGA_driver - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY VGA_driver IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        VS : OUT STD_LOGIC;
        HS : OUT STD_LOGIC;
        RED : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        GRN : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        modi : IN STD_LOGIC;
        BLU : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END VGA_driver;

ARCHITECTURE Behavioral OF VGA_driver IS
    COMPONENT frec_pixel
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            clk_pixel : OUT STD_LOGIC);
    END COMPONENT;
    COMPONENT comparador
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
    END COMPONENT;
    COMPONENT contador
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
    END COMPONENT;
    COMPONENT dibuja
        PORT (
            eje_x : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
            eje_y : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
            MODI : IN STD_LOGIC;
            RED : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            GRN : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            BLU : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;
    COMPONENT gen_color
        PORT (
            blank_h : IN STD_LOGIC;
            blank_v : IN STD_LOGIC;
            RED_in : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            GRN_in : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            BLU_in : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            RED : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            GRN : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            BLU : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
    END COMPONENT;
    SIGNAL cp : STD_LOGIC; --Salida del clk_pixel
    SIGNAL ca : STD_LOGIC; --Salida del and
    SIGNAL eje_x : STD_LOGIC_VECTOR(9 DOWNTO 0);
    SIGNAL eje_y : STD_LOGIC_VECTOR(9 DOWNTO 0);
    SIGNAL HSI : STD_LOGIC;
    SIGNAL VSI : STD_LOGIC;
    SIGNAL blhi : STD_LOGIC;
    SIGNAL blvi : STD_LOGIC;
    SIGNAL andi : STD_LOGIC;
    SIGNAL resi : STD_LOGIC;
    SIGNAL REDI : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL GRNI : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL BLUI : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL acp : STD_LOGIC;
BEGIN
    divfrec : frec_pixel
    PORT MAP(
        clk => clk,
        reset => reset,
        clk_pixel => cp
    );

    acp <= cp AND andi;
    --Contador de eje horizontal 
    Conth : contador
    GENERIC MAP(
        Nbit => 10
    )
    PORT MAP(
        clk => clk,
        reset => reset,
        enable => cp,
        resets => acp,
        Q => eje_x
    );

    Contv : contador
    GENERIC MAP(
        Nbit => 10
    )
    PORT MAP(
        clk => clk,
        reset => reset,
        enable => acp,
        resets => resi,
        Q => eje_y
    );
    Comph : comparador
    GENERIC MAP(
        Nbit => 10,
        End_Of_Screen => 639,
        Start_Of_Pulse => 655,
        End_Of_Pulse => 751,
        End_Of_Line => 799
    )
    PORT MAP(
        clk => clk,
        reset => reset,
        data => eje_x,
        O1 => blhi,
        O2 => HSI,
        O3 => andi
    );

    Compv : comparador
    GENERIC MAP(
        Nbit => 10,
        End_Of_Screen => 479,
        Start_Of_Pulse => 489,
        End_Of_Pulse => 491,
        End_Of_Line => 520
    )
    PORT MAP(
        clk => clk,
        reset => reset,
        data => eje_y,
        O1 => blvi,
        O2 => VSI,
        O3 => resi
    );

    dibu : dibuja
    PORT MAP(
        eje_x => eje_x,
        eje_y => eje_y,
        MODI => modi,
        RED => REDI,
        GRN => GRNI,
        BLU => BLUI
    );

    genera : gen_color
    PORT MAP(
        blank_h => blhi,
        blank_v => blvi,
        RED_in => REDI,
        GRN_in => GRNI,
        BLU_in => BLUI,
        RED => RED,
        GRN => GRN,
        BLU => BLU
    );

    HS <= HSI;
    VS <= VSI;
END Behavioral;