library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Progetto is
end tb_Progetto;

architecture Behavioral of tb_Progetto is
    constant N: integer := 8;
    signal A, B, Y: std_logic_vector(N-1 downto 0);
    signal C: std_logic;
    
    component Progetto is
        generic(N: integer := 8);
        Port(
            A: In std_logic_vector(N-1 downto 0);
            B: In std_logic_vector(N-1 downto 0);
            C: In std_logic;
            Y: Out std_logic_vector(N-1 downto 0)
        );
    end component;
begin
    -- Istanza del componente
    UUT: Progetto
        generic map (N => N)
        port map(
            A => A,
            B => B,
            C => C,
            Y => Y
        );
        
    stimulus: process
    begin
        report "Test 1: 50+30=80";
        A <= std_logic_vector(to_signed(50, N));
        B <= std_logic_vector(to_signed(30, N));
        C <= '0'; -- Somma
        wait for 10 ns;
        
        report "Test 2: 50 - 30 = 20";
        A <= std_logic_vector(to_signed(50, N));
        B <= std_logic_vector(to_signed(30, N));
        C <= '1'; -- Sottrazione
        wait for 10 ns;
        
        report "Test 3: -10 + 5 = -5";
        A <= std_logic_vector(to_signed(-10, N));
        B <= std_logic_vector(to_signed(5, N));
        C <= '0';
        wait for 10 ns;
        
        report "Test 4: -10 - 5 = -15";
        A <= std_logic_vector(to_signed(-10, N));
        B <= std_logic_vector(to_signed(5, N));
        C <= '1';
        wait for 10 ns;
        
        report "Test 5: 127 + 1 = -128 (overflow)";
        A <= std_logic_vector(to_signed(127, N));
        B <= std_logic_vector(to_signed(1, N));
        C <= '0';
        wait for 10 ns;
        
        report "Test 6: -128 - 1 = 127 (overflow)";
        A <= std_logic_vector(to_signed(-128, N));
        B <= std_logic_vector(to_signed(1, N));
        C <= '1';
        wait for 10 ns;
        
        report "Test 7: 0 + 0 = 0";
        A <= (others => '0');
        B <= (others => '0');
        C <= '0';
        wait for 10 ns;
        
        report "Fine test";
        wait;
    end process;
end Behavioral;