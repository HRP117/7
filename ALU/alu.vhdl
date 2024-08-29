library ieee;
use ieee.std_logic_1164.all;
use IEEE.math_real.all;

entity ALU is
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
end entity ALU;

architecture Structural of ALU is
    
    component FullAdder
            port (
            cin: in std_logic;
            x: in std_logic;
            y: in std_logic;
            sigma: out std_logic;
            cout: out std_logic
        );
    end component;

    signal x, y : std_logic_vector(N-1 downto 0); -- Señales internas
    signal c: std_logic_vector(N downto 0); -- Acarreo interno

begin
    c(0) <= s(2) and (s(1) xor s(0));
    
    LEGEN: for i in 0 to N-1 generate
        x(i) <= (S(2) and A(i)) or (not(S(0)) and A(i)) or 
        (not(S(1)) and A(i) and B(i)) or 
        (not(S(2)) and S(1) and not(A(i)) 
        and (B(i) or S(0)));
    end generate LEGEN;
    
    AEGEN: for i in 0 to N-1 generate
        y(i) <= (S(2) and S(0) and (S(1) or not(B(i)))) or 
        (S(2) and not(S(1)) and not(S(0)) and B(i));
    end generate AEGEN;
    
    ADDGEN: for i in 0 to N-1 generate
        FA: entity work.FullAdder
            port map (
                x => x(i),
                y => y(i),
                cin => c(i),
                sigma => F(i),
                cout => c(i+1)
            );
    end generate ADDGEN;

    UOF <= c(N);
    SOF <= c(N) xor c(N-1);


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