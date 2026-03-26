library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity AdderTree_Pipeline is
    Generic (
        N: integer := 8 -- Larghezza bit degli ingressi
    );
    Port (
        clk: in std_logic;
        rst: in std_logic; -- Reset asincrono attivo alto
        -- 6 Operandi di ingresso (vettori std_logic)
        Op1, Op2, Op3, Op4, Op5, Op6: in std_logic_vector(N-1 downto 0);
        -- Uscita estesa: 8 bit + ceil(log2(6)) = 11 bit per evitare overflow matematico
        Sum_Out: out std_logic_vector(N+2 downto 0)
    );
end AdderTree_Pipeline;

architecture Behavioral of AdderTree_Pipeline is
    -- STADIO 0: Registri di Ingresso (Larghezza N)
    signal r0_op1, r0_op2, r0_op3, r0_op4, r0_op5, r0_op6: signed(N-1 downto 0);
    
    -- STADIO 1: Risultati parziali (Larghezza N+1)
    signal r1_sum12: signed (N downto 0); -- Op1 + Op2
    signal r1_sum34: signed (N downto 0); -- Op3 + Op4
    signal r1_sum56: signed (N downto 0); -- Op5 + Op6
    
    -- STADIO 2: Somma intermedia e Delay (Larghezza N+2)
    signal r2_sum1234: signed (N + 1 downto 0); -- (Op1+Op2) + (Op3+Op4)
    signal r2_delay56: signed (N downto 0);     -- Registro di bilanciamento per (Op5+Op6)
    
    -- STADIO 3: Risultato Finale (Larghezza N+3)
    signal r3_total: signed (N+2 downto 0);
begin
    process(clk, rst)
    begin
        if rst = '1' then
            -- Reset asincrono di tutti i registri
            r0_op1 <= (others => '0'); r0_op2 <= (others => '0');
            r0_op3 <= (others => '0'); r0_op4 <= (others => '0');
            r0_op5 <= (others => '0'); r0_op6 <= (others => '0');
            
            r1_sum12 <= (others => '0');
            r1_sum34 <= (others => '0');
            r1_sum56 <= (others => '0');
            
            r2_sum1234 <= (others => '0');
            r2_delay56 <= (others => '0'); -- Reset del registro delay
            
            r3_total <= (others => '0');
        elsif rising_edge(clk) then
            r0_op1 <= signed(Op1); r0_op2 <= signed(Op2);
            r0_op3 <= signed(Op3); r0_op4 <= signed(Op4);
            r0_op5 <= signed(Op5); r0_op6 <= signed(Op6);
            
            -- La funzione resize estende il bit di segno (Sign Extension)
            r1_sum12 <= resize(r0_op1, N+1) + resize(r0_op2, N+1);
            r1_sum34 <= resize(r0_op3, N+1) + resize(r0_op4, N+1);
            r1_sum56 <= resize(r0_op5, N+1) + resize(r0_op6, N+1);
            
            r2_sum1234 <= resize(r1_sum12, N+2) + resize(r1_sum34, N+2);
            r2_delay56 <= r1_sum56;
            
            r3_total <= resize(r2_sum1234, N+3) + resize(r2_delay56, N+3);
        end if;
    end process;
    
    Sum_Out <= std_logic_vector(r3_total);
end Behavioral;