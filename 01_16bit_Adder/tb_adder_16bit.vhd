library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_adder_16bit is
end tb_adder_16bit;

architecture Behavioral of tb_adder_16bit is
    signal A, B : STD_LOGIC_VECTOR(15 downto 0);
    signal Sum  : STD_LOGIC_VECTOR(15 downto 0);
    signal Cout : STD_LOGIC;
begin
    UUT: entity work.adder_16bit
        port map(
            A => A,
            B => B,
            Cin => '0',
            Sum => Sum,
            Cout => Cout
        );

    stimulus: process
    begin
        -- test 1: 1000 + 2000 = 3000
        A <= std_logic_vector(to_unsigned(1000, 16));
        B <= std_logic_vector(to_unsigned(2000, 16));
        wait for 10 ns;

        -- Test 2: 65535 + 1 = 0 con Cout= 1 (overflow)
        A <= std_logic_vector(to_unsigned(65535, 16));
        B <= std_logic_vector(to_unsigned(1, 16));
        wait for 10 ns;

        -- Test 3: 12345 + 4321 = 16666
        A <= std_logic_vector(to_unsigned(12345, 16));
        B <= std_logic_vector(to_unsigned(4321, 16));
        wait for 10 ns;

        -- Test 4: 0 + 0 = 0
        A <= (others => '0');
        B <= (others => '0');
        wait for 10 ns;

        -- Test 5: 32767 + 32767 = 65534
        A <= std_logic_vector(to_unsigned(32767, 16));
        B <= std_logic_vector(to_unsigned(32767, 16));
        wait for 10 ns;

        -- Test 6: 4096 + 8192 = 12288
        A <= std_logic_vector(to_unsigned(4096, 16));
        B <= std_logic_vector(to_unsigned(8192, 16));
        wait for 10 ns;

        -- Test 7: 255 + 255 = 510
        A <= std_logic_vector(to_unsigned(255, 16));
        B <= std_logic_vector(to_unsigned(255, 16));
        wait for 10 ns;

        wait;
    end process;
end Behavioral;