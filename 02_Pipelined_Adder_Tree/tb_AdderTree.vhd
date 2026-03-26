library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_AdderTree is
end tb_AdderTree;

architecture test of tb_AdderTree is
    component AdderTree_Pipeline
        Generic (N: integer := 8);
        Port (
            clk: in std_logic;
            rst: in std_logic;
            Op1, Op2, Op3, Op4, Op5, Op6: in std_logic_vector(N-1 downto 0);
            Sum_Out: out std_logic_vector(N+2 downto 0)
        );
    end component;
    
    constant N_BITS: integer := 8;
    signal clk: std_logic := '0';
    signal rst: std_logic := '1';
    signal Op1, Op2, Op3, Op4, Op5, Op6: std_logic_vector(N_BITS-1 downto 0) := (others => '0');
    signal Sum_Out: std_logic_vector(N_BITS + 2 downto 0);
    
    constant CLK_PERIOD: time := 10 ns;
begin
    UUT: AdderTree_Pipeline
        Generic map (N => N_BITS)
        Port map (
            clk => clk,
            rst => rst,
            Op1 => Op1, Op2 => Op2, Op3 => Op3,
            Op4 => Op4, Op5 => Op5, Op6 => Op6,
            Sum_Out => Sum_Out
        );
        
    clk_process: process
    begin
        clk <= '0';
        wait for CLK_PERIOD/2;
        clk <= '1';
        wait for CLK_PERIOD/2;
    end process;
    
    stim_proc: process
    begin
        rst <= '1';
        wait for 50 ns; 
        rst <= '0';
        wait for CLK_PERIOD; 
        
        -- Tutti gli ingressi a 0.
        Op1 <= x"00"; Op2 <= x"00"; Op3 <= x"00"; Op4 <= x"00"; Op5 <= x"00"; Op6 <= x"00";
        wait for CLK_PERIOD;
        
        -- 1+1+1+1+1+1=6
        Op1 <= x"01"; Op2 <= x"01"; Op3 <= x"01"; Op4 <= x"01"; Op5 <= x"01"; Op6 <= x"01";
        wait for CLK_PERIOD;
        
        -- Calcolo atteso: 127*6 = 762
        Op1 <= x"7F"; Op2 <= x"7F"; Op3 <= x"7F"; Op4 <= x"7F"; Op5 <= x"7F"; Op6 <= x"7F";
        wait for CLK_PERIOD;
        
        -- Calcolo atteso: -128*6 = -768
        Op1 <= x"80"; Op2 <= x"80"; Op3 <= x"80"; Op4 <= x"80"; Op5 <= x"80"; Op6 <= x"80";
        wait for CLK_PERIOD;
        
        -- Valori: -10, +20, -5, +5, -128, +127
        Op1 <= std_logic_vector(to_signed(-10, 8));
        Op2 <= std_logic_vector(to_signed(20, 8));
        Op3 <= std_logic_vector(to_signed(-5, 8));
        Op4 <= std_logic_vector(to_signed(5, 8));
        Op5 <= std_logic_vector(to_signed(-128, 8));
        Op6 <= std_logic_vector(to_signed(127, 8)); 
        wait for CLK_PERIOD;
        
        -- Svuotamento della pipeline
        Op1 <= x"00"; Op2 <= x"00"; Op3 <= x"00"; Op4 <= x"00"; Op5 <= x"00"; Op6 <= x"00";
        wait for CLK_PERIOD * 10;
        
        wait;
    end process;
end test;