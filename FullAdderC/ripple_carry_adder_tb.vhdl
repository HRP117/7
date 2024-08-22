library ieee
use ieee.std_logic_1164.all

entity RippleCarryAdderTestbench is
end entity;

architecture Structural of RippleCarryAdderTestbench is
    component RippleCarryAdder
        port{
            cin: in std_logic;
            x: in std_logic_vector(3 downto 0); 
            y: in std_logic_vector(3 downto 0);
            sigma: out std_logic_vector(3 downto 0);
            cout: out std_logic
        };  
    end component;
    signal A: std_logic_vector(3 downto 0);
    signal B: std_logic_vector(3 downto 0);
    signal S: std_logic_vector(3 downto 0);
    signal COUT: std_logic;
    begin
        RCA: RippleCarryAdder port map(
            cin => '0',
            x => A,
            y => B,
            sigma => S,
            cout => COUT
        );
        stimuli: process
        begin
            A<="0000"; B<="1111"; wait 1 ns;
            A<="1000"; B<="0001"; wait 1 ns;
            A<="0000"; B<="0000"; wait 1 ns;
            A<="1111"; B<="1111"; wait 1 ns;
        end process stimuli
    end Structural
            
