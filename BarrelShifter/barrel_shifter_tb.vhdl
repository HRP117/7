library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BarrelShifterTestbench is
    generic (
        a : integer := 3; -- shift amount
        n : integer := 2 ** a; -- data input size in bits
        k : integer := n -- data input size in bits rev
    );
end entity;

architecture Structural of BarrelShifterTestbench is

    signal y : std_logic_vector(k-1 downto 0);
    signal left : std_logic;
    signal ry : std_logic_vector(k-1 downto 0);
    signal shamnt : std_logic_vector(a-1 downto 0);
    signal serialIn : std_logic;
    signal o : std_logic_vector(n-1 downto 0);

    component BarrelShifter
        generic(
            a : integer; -- shift amount
            n : integer := 2 ** a; -- data input size in bits
            k : integer := n
        );
        port(
            y : in std_logic_vector(k-1 downto 0); -- data input for reversal
            left : in std_logic; -- reverse data
            ry : out std_logic_vector(k-1 downto 0); -- data reversed
            shamnt : in std_logic_vector(a-1 downto 0); -- shift amount port
            serialIn : in std_logic; -- Serial input
            o : out std_logic_vector(n-1 downto 0) -- data output
        );
    end component;

begin

    SHIFT: BarrelShifter
        generic map (
            a => a,
            n => n,
            k => k
        )
        port map (
            y => y,
            left => left,
            ry => ry,
            shamnt => shamnt,
            serialIn => serialIn,
            o => o
        );

    stimuli: process
    begin
        serialIn <= '0';
        y <= (7 => '0', 0=> '0', others=>'1');

        left <= '0'; 
        SHAMNTLOOP0: for i in 0 to n-1 loop
            shamnt <= std_logic_vector(to_unsigned(i, shamnt'length));
            wait for 10 ns;
        end loop SHAMNTLOOP0;

        left <= '1'; 
        SHAMNTLOOP1: for i in 0 to n-1 loop
            shamnt <= std_logic_vector(to_unsigned(i, shamnt'length));
            wait for 10 ns;
        end loop SHAMNTLOOP1;

        wait;
    end process stimuli;

end architecture Structural;

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