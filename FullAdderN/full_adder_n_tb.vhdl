library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FullAdderNBitsTestbench is
end entity;

architecture Behavioral of FullAdderNBitsTestbench is
    constant N : integer := 4;  -- Número de bits para el testbench
    component FullAdderNBits
        generic (
            N : integer
        );
        port (
            cin: in std_logic;
            x: in std_logic_vector(N-1 downto 0); 
            y: in std_logic_vector(N-1 downto 0);
            sigma: out std_logic_vector(N-1 downto 0);
            cout: out std_logic
        );
    end component;
    
    signal A: std_logic_vector(N-1 downto 0);
    signal B: std_logic_vector(N-1 downto 0);
    signal S: std_logic_vector(N-1 downto 0);
    signal COUT: std_logic;
    signal CIN: std_logic;
    
begin
    RCA: FullAdderNBits
        generic map (
            N => N
        )
        port map (
            cin => CIN,
            x => A,
            y => B,
            sigma => S,
            cout => COUT
        );
    
    stimuli: process
    begin
        CIN <= '0'; A <= "0000"; B <= "1111"; wait for 1 ns;
        CIN <= '0'; A <= "1000"; B <= "0001"; wait for 1 ns;
        CIN <= '0'; A <= "0000"; B <= "0000"; wait for 1 ns;
        CIN <= '0'; A <= "1111"; B <= "1111"; wait for 1 ns;
        CIN <= '1'; A <= "1111"; B <= "1111"; wait for 1 ns;
        wait;
    end process stimuli;
    
end Behavioral;
