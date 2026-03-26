library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_16bit is
    Port ( A, B : in STD_LOGIC_VECTOR (15 downto 0);
           Cin : in STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (15 downto 0);
           Cout : out STD_LOGIC);
end adder_16bit;

architecture Structural of adder_16bit is
    -- Segnale per i carry tra i sommatori a 4-bit Carry(0) = Cin, carry(4) = Cout
    signal carry : STD_LOGIC_VECTOR(4 downto 0);

    component adder_4bit is
        Port ( A, B : in STD_LOGIC_VECTOR(3 downto 0);
               Cin  : in STD_LOGIC;
               Sum  : out STD_LOGIC_VECTOR(3 downto 0);
               Cout : out STD_LOGIC);
    end component;
begin
    carry(0) <= Cin;

    -- Primo sommatore 4-bit (bit 3-0)
    CLA4B_0: adder_4bit port map(
        A => A(3 downto 0),
        B => B(3 downto 0),
        Cin => carry(0),
        Sum => Sum(3 downto 0),
        Cout => carry(1)
    );

    -- Secondo sommatore 4-bit (bit 7-4)
    CLA4B_1: adder_4bit port map(
        A => A(7 downto 4),
        B => B(7 downto 4),
        Cin => carry(1),
        Sum => Sum(7 downto 4),
        Cout => carry(2)
    );

    -- Terzo sommatore 4-bit (bit 11-8)
    CLA4B_2: adder_4bit port map(
        A => A(11 downto 8),
        B => B(11 downto 8),
        Cin => carry(2),
        Sum => Sum(11 downto 8),
        Cout => carry(3)
    );

    -- Quarto sommatore 4-bit (bit 15-12)
    CLA4B_3: adder_4bit port map(
        A => A(15 downto 12),
        B => B(15 downto 12),
        Cin => carry(3),
        Sum => Sum(15 downto 12),
        Cout => carry(4)
    );

    Cout <= carry(4);
end Structural;