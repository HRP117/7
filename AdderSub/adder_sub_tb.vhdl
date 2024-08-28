library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AdderSubtractorNBitsTestbench is
end entity;

architecture Structural of AdderSubtractorNBitsTestbench is
    constant N : integer := 4; 

    component AdderSubtractorNBits
        generic (
            N : integer
        );
        port (
            x: in std_logic_vector(N-1 downto 0); 
            y: in std_logic_vector(N-1 downto 0);
            add_sub: in std_logic;  
            result: out std_logic_vector(N-1 downto 0);
            cout: out std_logic
        );
    end component;
    
    signal A: std_logic_vector(N-1 downto 0);
    signal B: std_logic_vector(N-1 downto 0);
    signal RESULT: std_logic_vector(N-1 downto 0);
    signal COUT: std_logic;
    signal ADD_SUB: std_logic;
    
begin
    AS: AdderSubtractorNBits
        generic map (
            N => N
        )
        port map (
            x => A,
            y => B,
            add_sub => ADD_SUB,
            result => RESULT,
            cout => COUT
        );
    
    stimuli: process
    begin
        -- Prueba de suma: Positivo más positivo
        ADD_SUB <= '0'; A <= "0101"; B <= "0011"; wait for 1 ns;  -- 5 + 3 = 8

        -- Prueba de suma: Positivo más negativo
        ADD_SUB <= '0'; A <= "0101"; B <= "1101"; wait for 1 ns;  -- 5 + -3 = 2

        -- Prueba de resta: Negativo más positivo
        ADD_SUB <= '1'; A <= "1011"; B <= "0011"; wait for 1 ns;  -- -5 + 3 = -2

        -- Prueba de resta: Negativo más negativo
        ADD_SUB <= '1'; A <= "1011"; B <= "1101"; wait for 1 ns;  -- -5 + -3 = -8
        
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