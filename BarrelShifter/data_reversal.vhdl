library ieee;
use ieee.std_logic_1164.all;
use IEEE.math_real.all;

entity DataReversal is
    generic(
        k : integer
    );
    port(
        y : in std_logic_vector(k-1 downto 0);
        left : in std_logic;
        ry : out std_logic_vector(k-1 downto 0)
    );
end entity DataReversal;

architecture Dataflow of DataReversal is

begin
    GENREV: for i in 0 to k-1 generate
        ry(i) <= (y(i) and (not left)) or (y(k-1-i) and (left));
    end generate GENREV;

end Dataflow; 