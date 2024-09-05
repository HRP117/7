library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DFF_tb is
end entity DFF_tb;

architecture Structural of DFF_tb is
    component DFF
        port(
            D:      in std_logic;       --Data input
            E:      in std_logic;       --Enable
            R:      in std_logic;       --Reset
            P:      in std_logic;       --Preset
            clk:    in std_logic;       --Clock
            Q:      out std_logic       --State
        );
    end component;

    signal D  : std_logic;
    signal E  : std_logic;
    signal R  : std_logic;
    signal P  : std_logic;
    signal CLK  : std_logic;
    signal Q  : std_logic;
    signal finish_flag  :   boolean :=   false;  --Stop process

begin
    DFF_GEN: DFF
        port map(
            D => D,
            E => E,
            R => R,
            P => P,
            clk => CLK,
            Q => Q
        );

    --Each milisecond the clock signal is complemented
    --This process runs indefinitely
    CLK_GEN: process begin
        wait for 1 ms;
        CLK <= not CLK;
        if (finish_flag = true) then
            wait;
        end if ;
    end process CLK_GEN;

    --This process runs at the same time as CLK_GEN
    stimuli: process begin
        --Asynchronous evaluation
        R <= '0'; P <= '0';     wait for 0.7 ms;        -- Q = X
        R <= '1';               wait for 1.5 ms;        -- Q = '0'
        P <= '1';               wait for 2.3 ms;        -- Q = '1'
        R <= '0'; P <= '0';     wait for 0.7 ms;        -- Q = '1'
        R <= '1'; P <= '1';     wait for 0.7 ms;        -- Q = '0'
        finish_flag <= true;
    end process stimuli;

end Structural;

--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
--▓▓▓▓▓-....:▓▓▓▓▓▓▓+................-▓▓▓▓▓▓▓
--▓▓▓▓▓-....:▓▓▓▓▓▓▓+.................#▓▓▓▓▓▓
--▓▓▓▓▓-....:▓▓▓▓▓▓▓#===========+.....#▓▓▓▓▓▓
--▓▓▓▓▓-....:▓▓▓▓▓▓▓+.....▓▓▓▓▓▓=.....#▓▓▓▓▓▓
--▓▓▓▓▓-....:@...........######*......#▓▓▓▓▓▓
--▓▓▓▓▓-....:@........................#▓▓▓▓▓▓
--▓▓▓▓▓-....:@+++++-.................@▓▓▓▓▓▓▓
--▓▓▓▓▓-....:▓▓▓▓▓▓▓+.....###-.....:@▓▓▓▓▓▓▓▓
--▓▓▓▓▓-....:▓▓▓▓▓▓▓+.....▓▓▓▓+.....-░▓▓▓▓▓▓▓
--▓▓▓▓▓-....:▓▓▓▓▓▓▓+.....▓▓▓▓▓=......#▓▓▓▓▓▓
--▓▓▓▓▓:----+▓▓▓▓▓▓▓*-----▓▓▓▓▓▓@------*▓▓▓▓▓
--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
--▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓