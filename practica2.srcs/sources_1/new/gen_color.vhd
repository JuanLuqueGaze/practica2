----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.10.2023 17:33:51
-- Design Name: 
-- Module Name: gen_color - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
ENTITY gen_color IS
    PORT (
        blank_h : IN STD_LOGIC;
        blank_v : IN STD_LOGIC;
        RED_in : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        GRN_in : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        BLU_in : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        RED : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        GRN : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        BLU : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END gen_color;

ARCHITECTURE Behavioral OF gen_color IS

BEGIN
    comb : PROCESS (blank_h, blank_v, RED_in, GRN_in, BLU_in)
    BEGIN
        IF blank_h = '1' OR blank_v = '1' THEN
            RED <= (OTHERS => '0');
            BLU <= (OTHERS => '0');
            GRN <= (OTHERS => '0');
        ELSE
            RED <= RED_in;
            GRN <= GRN_in;
            BLU <= BLU_in;
        END IF;
    END PROCESS;
END Behavioral;