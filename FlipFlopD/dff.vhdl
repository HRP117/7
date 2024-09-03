library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DFF is
    port(
        D:      in std_logic;       --Data input
        E:      in std_logic;       --Enable
        R:      in std_logic;       --Reset
        P:      in std_logic;       --Preset
        clk:    in std_logic;       --Clock
        Q:      out std_logic       --State
    );
    
end entity DFF;