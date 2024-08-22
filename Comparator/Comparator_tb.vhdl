library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity NBitComparatorTestbench is
    generic (
        N : integer := 32  
    );
end entity;

architecture Structural of NBitComparatorTestbench is
    --constant N : integer := 4;  

    component NBitComparator
        generic (
            N : integer
        );
        port (
            x: in std_logic_vector(N-1 downto 0); 
            y: in std_logic_vector(N-1 downto 0); 
            gin: in std_logic;
            ein: in std_logic;
            gout: out std_logic;
            eout: out std_logic
        );
    end component;

    signal X: std_logic_vector(N-1 downto 0);
    signal Y: std_logic_vector(N-1 downto 0);
    signal GIN: std_logic;
    signal EIN: std_logic;
    signal GOUT: std_logic;
    signal EOUT: std_logic;

begin
    COMP: NBitComparator
        generic map (
            N => N
        )
        port map (
            x => X,
            y => Y,
            gin => GIN,
            ein => EIN,
            gout => GOUT,
            eout => EOUT
        );

    stimuli: process
    begin
        -- X = Y
        --X <= "0010"; Y <= "0010"; GIN <= '0'; EIN <= '1'; wait for 10 ns; 
        X <= (others => '0'); Y <= (others => '0'); GIN <= '0'; EIN <= '1'; wait for 10 ns; 

        -- X < Y
        --X <= "0010"; Y <= "0110"; GIN <= '0'; EIN <= '1'; wait for 10 ns; 
        Y <= (others => '1'); wait for 10 ns; 

        -- X > Y
        --X <= "0110"; Y <= "0010"; GIN <= '0'; EIN <= '1'; wait for 10 ns;
        X <= (others => '1'); Y <= (others => '0');wait for 10 ns; 

        -- Invalido
        --X <= "0110"; Y <= "0010"; GIN <= '1'; EIN <= '1'; wait for 10 ns;
        GIN <= '1'; EIN <= '1'; wait for 10 ns;

        
        wait;  
    end process stimuli;

end Structural;
