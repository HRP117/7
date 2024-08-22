library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity OneBitComparator is
    port(
        x: in std_logic;
        y: in std_logic;
        gin: in std_logic;
        ein: in std_logic;
        gout: out std_logic;
        eout: out std_logic
    );
end entity OneBitComparator;

architecture Dataflow of OneBitComparator is

begin
    gout<= gin or ((x and ein) and (not y));
    eout<= (gin and ein) or (ein and (not x) and (not y)) or (ein and x and y);
end Dataflow;