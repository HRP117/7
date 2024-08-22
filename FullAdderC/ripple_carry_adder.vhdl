library ieee;
use ieee.std_logic_1164.all;

entity RippleCarryAdder is
    port (
        cin: in std_logic;
        x: in std_logic_vector(3 downto 0); 
        y: in std_logic_vector(3 downto 0);
        sigma: out std_logic_vector(3 downto 0);
        cout: out std_logic
    );
end entity RippleCarryAdder;

architecture Structural of RippleCarryAdder is
    component FullAdder
        port (
            cin: in std_logic;
            x: in std_logic;
            y: in std_logic;
            sigma: out std_logic;
            cout: out std_logic
        );
    end component;
    
    signal c: std_logic_vector(3 downto 0);
    
begin
    FA0: FullAdder port map (
        cin => cin,
        x => x(0),
        y => y(0),
        sigma => sigma(0),
        cout => c(0)
    );

    FA1: FullAdder port map (
        cin => c(0),
        x => x(1),
        y => y(1),
        sigma => sigma(1),
        cout => c(1)
    );

    FA2: FullAdder port map (
        cin => c(1),
        x => x(2),
        y => y(2),
        sigma => sigma(2),
        cout => c(2)
    );

    FA3: FullAdder port map (
        cin => c(2),
        x => x(3),
        y => y(3),
        sigma => sigma(3),
        cout => cout
    );

end Structural;
