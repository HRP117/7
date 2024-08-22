library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;

entity LeftShifterTestbench is
    generic (
        a : integer := 5;  
        n : integer := 2**a    
    );
end entity;

architecture Structural of LeftShifterTestbench is

    component LeftShifter
        generic(
            a: integer;  -- shift amount
            n: integer  -- data input size in bits
        );
        port(
            x: in std_logic_vector(n-1 downto 0);  -- data input
            shamnt: in std_logic_vector(a-1 downto 0);  -- shift amount port
            serialIn: in std_logic;
            o: out std_logic_vector(n-1 downto 0)  -- data output
        );
    end component;

    signal x: std_logic_vector(n-1 downto 0);
    signal shamnt: std_logic_vector(a-1 downto 0);
    signal serialIn: std_logic;
    signal o: std_logic_vector(n-1 downto 0);

begin
    SHIFT: LeftShifter
        generic map (
            a => a,
            n => n
        )
        port map (
            x => x,
            shamnt => shamnt,
            serialIn=> serialIn,
            o => o
        );

    stimuli: process
    begin
        serialIn<='0';
        x<=(others=>'1');
        SHAMNTLOOP: for i in 0 to n-1 loop
            shamnt<=std_logic_vector(to_unsigned(i, shamnt'length));
            wait for 10 ns;
        end loop SHAMNTLOOP;

        wait;
    end process stimuli;

end architecture Structural;
