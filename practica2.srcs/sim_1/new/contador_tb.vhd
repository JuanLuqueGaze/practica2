-- Testbench automatically generated

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.NUMERIC_STD.ALL;

ENTITY contador_tb IS
END contador_tb;

ARCHITECTURE test_bench OF contador_tb IS

    -- Constants for generic values
    CONSTANT Nbit : INTEGER := 8; -- EDIT Value for the generic

    -- Signals for connection to the DUT
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC;
    SIGNAL enable : STD_LOGIC;
    SIGNAL resets : STD_LOGIC;
    SIGNAL Q : STD_LOGIC_VECTOR(Nbit - 1 DOWNTO 0);

    -- Component declaration
    COMPONENT contador
        GENERIC (
            Nbit : INTEGER := 8);
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            enable : IN STD_LOGIC;
            resets : IN STD_LOGIC;
            Q : OUT STD_LOGIC_VECTOR(Nbit - 1 DOWNTO 0));
    END COMPONENT;

    CONSTANT clockPeriod : TIME := 10 ns; -- EDIT Clock period

BEGIN
    DUT : contador
    GENERIC MAP(
        Nbit => Nbit)
    PORT MAP(
        clk => clk,
        reset => reset,
        enable => enable,
        resets => resets,
        Q => Q);

    clk <= NOT clk AFTER clockPeriod/2;

    stimuli : PROCESS
    BEGIN
        reset <= '0'; -- EDIT Initial value
        enable <= '0'; -- EDIT Initial value
        resets <= '0'; -- EDIT Initial value

        -- Wait one clock period
        WAIT FOR 1 * clockPeriod;
        reset <= '1';
        WAIT FOR 5 * clockPeriod;
        reset <= '0';
        WAIT FOR 5 * clockPeriod;
        enable <= '1';
        WAIT FOR 12 * clockPeriod;
        enable <= '0';
        WAIT FOR 5 * clockPeriod;
        resets <= '1';
        WAIT FOR 5 * clockPeriod;
        enable <= '1';
        WAIT FOR 12 * clockPeriod;
        resets <= '0';

        -- EDIT Genererate stimuli here

        WAIT;
    END PROCESS;

END test_bench;