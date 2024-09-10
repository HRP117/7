library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DFF_tb is
end entity DFF_tb;

architecture Structural of DFF_tb is
    component DFF
        port(
            D:      in std_logic;       -- Data input
            E:      in std_logic;       -- Enable
            R:      in std_logic;       -- Reset
            P:      in std_logic;       -- Preset
            CLK:    in std_logic;       -- Clock
            Q:      out std_logic       -- State
        );
    end component;

    signal D  : std_logic;
    signal E  : std_logic;
    signal R  : std_logic;
    signal P  : std_logic;
    signal CLK  : std_logic :=  '0';
    signal Q  : std_logic;
    -- Clk
    signal finish_flag  :   boolean :=   false;     -- Stop process
    --signal clk_counter : integer := 0;              
    --signal cycle_limit : integer := 10;             
    --signal counter : integer := 0;
    --constant CLOCK_PERIOD : integer := 1000; 

begin
    DFF_GEN: DFF
        port map(
            D => D,
            E => E,
            R => R,
            P => P,
            CLK => CLK,
            Q => Q
        );

    -- Each milisecond the clock signal is complemented
    -- This process runs indefinitely
    -- Trial #1
    CLK_GEN: process begin
        wait for 1 ns;
        CLK <= not CLK;
        if finish_flag = true then
            wait;
        end if ;
    end process CLK_GEN;

    -- Trial #2
    --CLK_GEN: process begin
    --    while (finish_flag = false) loop
    --        CLK <= '0';
    --        wait for 1 ns;
    --        CLK <= '1';
    --        wait for 1 ns;
    --    end loop;
    --    wait;
    --end process CLK_GEN;

    -- Trial #3
    --CLK_GEN: process begin
    --    if clk_counter < cycle_limit then
    --        if counter = CLOCK_PERIOD/2 then
    --            CLK <= not CLK;  
    --            counter <= 0;    
    --            if CLK = '1' then
    --                clk_counter <= clk_counter + 1;
    --            end if;
    --        else
    --            counter <= counter + 1; 
    --        end if;
    --    else
    --        wait;
    --    end if;
    --    wait for 1 ns; 
    --end process CLK_GEN;

    -- This process runs at the same time as CLK_GEN
    stimuli: process begin
        -- Asynchronous evaluation
        R <= '0'; P <= '0';     wait for 0.7 ns;        -- Q = X
        R <= '1';               wait for 1.5 ns;        -- Q = '0'
        P <= '1';               wait for 2.3 ns;        -- Q = '1'
        R <= '0'; P <= '0';     wait for 0.7 ns;        -- Q = '1'
        R <= '1'; P <= '1';     wait for 0.7 ns;        -- Q = '0'

        -- Synchronous evaluation
        R <= '0'; P <= '0';                             -- Asynchronous disabled
        E <= '1'; D <= '1'; wait for 2 ns;              -- Enable and pass a '1'
        E <= '1'; D <= '0'; wait for 2 ns;              -- Enable and pass a '0'
        E <= '0'; D <= '1'; wait for 2 ns;              -- Disable and pass a '1'

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