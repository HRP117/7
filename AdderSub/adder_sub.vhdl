library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AdderSubtractorNBits is
    generic (
        N : integer := 4  -- Número de bits
    );
    port (
        x: in std_logic_vector(N-1 downto 0); 
        y: in std_logic_vector(N-1 downto 0);
        add_sub: in std_logic;  -- Bit de control (0 para suma, 1 para resta)
        result: out std_logic_vector(N-1 downto 0);
        cout: out std_logic
    );
end entity AdderSubtractorNBits;

architecture Structural of AdderSubtractorNBits is
    component FullAdder
        port (
            cin: in std_logic;
            x: in std_logic;
            y: in std_logic;
            sigma: out std_logic;
            cout: out std_logic
        );
    end component;
    
    signal c: std_logic_vector(N downto 0); 
    signal y_invert: std_logic_vector(N-1 downto 0);
    
begin
    gen_y_compl: for i in 0 to N-1 generate
        y_invert(i) <= y(i) xor add_sub;
    end generate gen_y_compl;
    
    c(0) <= add_sub; 
    
    generador: for i in 0 to N-1 generate
        FA: FullAdder port map (
            cin => c(i),
            x => x(i),
            y => y_invert(i),
            sigma => result(i),
            cout => c(i+1)
        );
    end generate generador;
    
    cout <= c(N);

end Structural;
