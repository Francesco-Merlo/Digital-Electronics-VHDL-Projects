library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_4bit is
    Port ( A, B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (3 downto 0);
           Cout : out STD_LOGIC);
end adder_4bit;

architecture Behavioral of adder_4bit is
    -- Segnale che serve per i carry interni ad esempio: carry(0) = Cin invece carry(4) = Cout
    signal carry: std_logic_vector(4 downto 0);
    
    component full_adder is
        Port( a, b, cin : in std_logic;
              s, cout : out std_logic);
    end component;
begin
    carry(0) <= Cin;

    -- Full-Adder per il 0 bit(LSB)
    FA0: full_adder port map(
        a => A(0),
        b => B(0),
        cin => carry(0),
        s => Sum(0),
        cout => carry(1)
    );

    -- Full-Adder per il 1 bit
    FA1: full_adder port map(
        a => A(1),
        b => B(1),
        cin => carry(1),
        s => Sum(1),
        cout => carry(2)
    );

    -- Full-Adder per il 2 bit
    FA2: full_adder port map(
        a => A(2),
        b => B(2),
        cin => carry(2),
        s => Sum(2),
        cout => carry(3)
    );

    -- Full-Adder per il 3 bit(MSB del nibble)
    FA3: full_adder port map(
        a => A(3),
        b => B(3),
        cin => carry(3),
        s => Sum(3),
        cout => carry(4)
    );

    Cout <= carry(4);
end Behavioral;