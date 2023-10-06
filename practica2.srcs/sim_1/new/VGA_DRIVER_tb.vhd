-- Testbench automatically generated

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.NUMERIC_STD.ALL;

ENTITY VGA_driver_tb IS
END VGA_driver_tb;

ARCHITECTURE test_bench OF VGA_driver_tb IS
    -- Signals for connection to the DUT
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC;
    SIGNAL VS : STD_LOGIC;
    SIGNAL HS : STD_LOGIC;
    SIGNAL RED : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL GRN : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL BLU : STD_LOGIC_VECTOR (3 DOWNTO 0);

    -- Component declaration
    COMPONENT VGA_driver
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            VS : OUT STD_LOGIC;
            HS : OUT STD_LOGIC;
            RED : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            GRN : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            BLU : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
    END COMPONENT;

    COMPONENT vga_monitor
        GENERIC (
            NR : INTEGER := 3; -- Number of bits of red bus
            NG : INTEGER := 3; -- Number of bits of green bus
            NB : INTEGER := 2); -- Number of bits of blue bus
        PORT (
            clk : IN STD_LOGIC; -- Clock
            hs : IN STD_LOGIC; -- Horizontal Sync. Active low. 
            vs : IN STD_LOGIC; -- Vertical Sync. Active low.
            R : IN STD_LOGIC_VECTOR (NR - 1 DOWNTO 0); -- red
            G : IN STD_LOGIC_VECTOR (NG - 1 DOWNTO 0); -- green
            B : IN STD_LOGIC_VECTOR (NB - 1 DOWNTO 0)); -- blue
    END COMPONENT;
    CONSTANT clockPeriod : TIME := 10 ns; -- EDIT Clock period

BEGIN
    DUT : VGA_driver
    PORT MAP(
        clk => clk,
        reset => reset,
        VS => VS,
        HS => HS,
        RED => RED,
        GRN => GRN,
        BLU => BLU);

    monitor : vga_monitor
    GENERIC MAP(
        NR => 4,
        NG => 4,
        NB => 4
    )
    PORT MAP(
        clk => clk,
        hs => HS,
        vs => vs,
        r => RED,
        G => GRN,
        B => BLU
    );

    clk <= NOT clk AFTER clockPeriod/2;

    stimuli : PROCESS
    BEGIN
        reset <= '1'; -- EDIT Initial value

        -- Wait one clock period
        WAIT FOR 1 * clockPeriod;
        reset <= '0';
        -- EDIT Genererate stimuli here

        WAIT;
    END PROCESS;

END test_bench;