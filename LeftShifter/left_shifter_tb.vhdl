library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;

entity LeftShifterTestbench is
    generic (
        a : integer := 2;  -- Definir cantidad de desplazamiento
        n : integer := 2**a  -- Tamaño de entrada de datos    
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
            o: out std_logic_vector(n-1 downto 0)  -- data output
        );
    end component;

    -- Señales para interconectar con el DUT (Design Under Test)
    signal x: std_logic_vector(n-1 downto 0);
    signal shamnt: std_logic_vector(a-1 downto 0);
    signal o: std_logic_vector(n-1 downto 0);

begin
    -- Instancia del shifter (DUT)
    UUT: LeftShifter
        generic map (
            a => a,
            n => n
        )
        port map (
            x => x,
            shamnt => shamnt,
            o => o
        );

    -- Estímulos de prueba
    stimuli: process
    begin
        -- Caso 1: Desplazamiento a la izquierda por 0 posiciones
        x <= "1100";  -- Entrada de datos
        shamnt <= "00";  -- Desplazamiento de 0 posiciones
        wait for 10 ns;

        -- Caso 2: Desplazamiento a la izquierda por 1 posición
        x <= "1100";  -- Entrada de datos
        shamnt <= "01";  -- Desplazamiento de 1 posición
        wait for 10 ns;

        -- Caso 3: Desplazamiento a la izquierda por 2 posiciones
        x <= "1100";  -- Entrada de datos
        shamnt <= "10";  -- Desplazamiento de 2 posiciones
        wait for 10 ns;

        -- Caso 4: Desplazamiento a la izquierda por 3 posiciones
        x <= "1100";  -- Entrada de datos
        shamnt <= "11";  -- Desplazamiento de 3 posiciones
        wait for 10 ns;

        -- Fin de la simulación
        wait;
    end process stimuli;

end architecture Structural;
