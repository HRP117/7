library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_tb is
    generic (
        N : integer := 4
    );

end entity ALU_tb;

architecture Structural of ALU_tb is

    signal S    : std_logic_vector(2 downto 0);
    signal A    : std_logic_vector(N-1 downto 0);
    signal B    : std_logic_vector(N-1 downto 0);
    signal F    : std_logic_vector(N-1 downto 0);
    signal UOF  : std_logic;
    signal SOF  : std_logic;

    component ALU
        generic (
            N : integer
        );
        port (
            S: in std_logic_vector(2 downto 0); 
            A: in std_logic_vector(N-1 downto 0); 
            B: in std_logic_vector(N-1 downto 0);
            F: out std_logic_vector(N-1 downto 0);
            UOF: out std_logic;
            SOF: out std_logic
        );
    end component;
    
begin

    ALUG: ALU
        generic map (
            N => N
        )
        port map (
            S => S,
            A => A,
            B => B,
            F => F,
            UOF => UOF,
            SOF => SOF
        );

    stimuli: process
    begin
        --A <= (others=>'1');
        --B <= (others=>'0'); 
        A <= "0101";
        B <= "0011"; 

        -- Caso 000: Pasar A a F
        S <= "000";
        wait for 10 ns;

        -- Caso 001: AND entre A y B
        S <= "001";
        wait for 10 ns;

        -- Caso 002: OR entre A y B
        S <= "010";
        wait for 10 ns;

        -- Caso 011: NOT A
        S <= "011";
        wait for 10 ns;

        -- Caso 100: A + B
        S <= "100";
        wait for 10 ns;

        -- Caso 101: A - B
        S <= "101";
        wait for 10 ns;

        -- Caso 110: A + 1 
        S <= "110";
        wait for 10 ns;

        -- Caso 111: A - 1 
        S <= "111";
        wait for 10 ns;

        wait;
    end process;

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