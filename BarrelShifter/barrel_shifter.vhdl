library ieee;
use ieee.std_logic_1164.all;
use IEEE.math_real.all;

entity BarrelShifter is
    generic(
        a : integer; -- shift amount
        n : integer := 2 ** a; -- data input size in bits
        k : integer := n
    );
    port(
        y : in std_logic_vector(k-1 downto 0); -- data input for reversal
        left : in std_logic; -- reverse data
        ry : out std_logic_vector(n-1 downto 0); -- data reversed
        shamnt: in std_logic_vector(a-1 downto 0); -- shift amount port
        serialIn: in std_logic; -- Serial input
        o: out std_logic_vector(n-1 downto 0) -- data output
    );
end entity BarrelShifter;

architecture Structural of BarrelShifter is
    component DataReversal
        generic(
            k : integer
        );
        port(
            y : in std_logic_vector(k-1 downto 0);
            left : in std_logic;
            ry : out std_logic_vector(k-1 downto 0) -- corregido a salida
        );
    end component;
    component RightShifter
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
    end component;
    signal Y_REVERSED: std_logic_vector(k-1 downto 0); -- Data after reversal
    signal SHIFTED: std_logic_vector(n-1 downto 0); -- Data after shifting
begin
    REV1: DataReversal
        generic map (
            k => k
        )
        port map (
            y => y,
            left => left,
            ry => Y_REVERSED
        );

    SHIFT: RightShifter
        generic map (
            a => a,
            n => n
        )
        port map (
            x => Y_REVERSED,
            shamnt => shamnt,
            serialIn => serialIn,
            o => SHIFTED
        );

    REV2: DataReversal
        generic map (
            k => k
        )
        port map (
            y => SHIFTED,
            left => left,
            ry => o
        );

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