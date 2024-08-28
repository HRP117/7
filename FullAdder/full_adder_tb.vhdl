library ieee;
use ieee.std_logic_1164.all;

entity FullAdderTestBench is
end FullAdderTestBench;

architecture Structural of FullAdderTestBench is
    component FullAdder
        port (
            cin: in std_logic;
            x: in std_logic;
            y: in std_logic;
            sigma: out std_logic;
            cout: out std_logic
        );
    end component;
    
    signal CIN:     std_logic;
    signal X:       std_logic;
    signal Y:       std_logic;
    signal SIGMA:   std_logic;
    signal COUT:    std_logic;
    
begin
    FA: FullAdder port map (
        cin => CIN,
        x => X,
        y => Y,
        sigma => SIGMA,
        cout => COUT
    );
    
    stimuli: process
    begin
        CIN <= '0'; X <= '0'; Y <= '0'; wait for 1 ns;
        CIN <= '0'; X <= '0'; Y <= '1'; wait for 1 ns;
        CIN <= '0'; X <= '1'; Y <= '0'; wait for 1 ns;
        CIN <= '0'; X <= '1'; Y <= '1'; wait for 1 ns;
        CIN <= '1'; X <= '0'; Y <= '0'; wait for 1 ns;
        CIN <= '1'; X <= '0'; Y <= '1'; wait for 1 ns;
        CIN <= '1'; X <= '1'; Y <= '0'; wait for 1 ns;
        CIN <= '1'; X <= '1'; Y <= '1'; wait for 1 ns;
        wait;
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