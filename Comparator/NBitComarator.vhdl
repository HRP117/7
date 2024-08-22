library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity NBitComparator is
    generic (
        N : integer 
    );
    port(
        x: in std_logic_vector(N-1 downto 0); 
        y: in std_logic_vector(N-1 downto 0); 
        gin: in std_logic;
        ein: in std_logic;
        gout: out std_logic;
        eout: out std_logic
    );
end entity NBitComparator;

architecture Structural of NBitComparator is
    component OneBitComparator
        port(
            x: in std_logic;
            y: in std_logic;
            gin: in std_logic;
            ein: in std_logic;
            gout: out std_logic;
            eout: out std_logic
        );
    end component;
    signal g: std_logic_vector(N downto 0); 
    signal e: std_logic_vector(N downto 0); 

begin
    BITCOMGEN: for i in 0 to N-1 generate
        BITCOMP: OneBitComparator port map(
            x => x(i),
            y => y(i),
            gin => g(i+1),
            ein => e(i+1),
            gout => g(i),
            eout => e(i)
        );
    end generate BITCOMGEN;
    
    g(N) <= gin;
    e(N) <= ein;

    gout <= g(0);
    eout <= e(0);

end Structural;