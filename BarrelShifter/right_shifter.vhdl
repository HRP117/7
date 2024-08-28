library ieee;
use ieee.std_logic_1164.all;
use IEEE.math_real.all;

entity RightShifter is
    generic(
        a: integer; -- shift amount
        n: integer := 2 ** a -- data input size in bits
    );
    port(
        x: in std_logic_vector(n-1 downto 0); -- data input
        shamnt: in std_logic_vector(a-1 downto 0); --shift amount port
        serialIn: in std_logic; -- Serial input
        o: out std_logic_vector(n-1 downto 0) -- data output
    );
end entity RightShifter;

architecture Dataflow of RightShifter is
    signal port0: std_logic_vector(n*(a+1)-1 downto 0);

begin
    GENROW: for i in 0 to a-1 generate
        GENCOL: for j in 0 to n-1 generate
            ROWCOND: if j >= n - 2**i generate
                port0(n*i+j) <= (port0(n*(i+1)+j) and (not shamnt(i))) or (serialIn and shamnt(i));
                else generate
                port0(n*i+j) <= (port0(n*(i+1)+j) and (not shamnt(i))) or (port0(n*(i+1)+j+2**i) and shamnt(i));
            end generate ROWCOND;
        end generate GENCOL;
    end generate GENROW;

    port0((a+1)*n-1 downto n*a) <= x;
    o <= port0(n-1 downto 0);

end Dataflow;

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