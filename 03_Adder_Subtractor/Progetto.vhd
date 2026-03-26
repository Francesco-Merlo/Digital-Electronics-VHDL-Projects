library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Progetto is
    generic(N: integer := 8);
    Port (
        A: in std_logic_vector(N-1 downto 0);
        B: in std_logic_vector(N-1 downto 0);
        C: in std_logic;
        Y: out std_logic_vector(N-1 downto 0)
    );
end Progetto;

architecture Progetto_Behavioral of Progetto is
    signal A_reg, B_reg: std_logic_vector(N downto 0);
    signal result_temp: std_logic_vector(N downto 0);
begin
    -- Estensione del segno per A e B (da N a N+1 bit)
    A_reg <= A(N-1) & A;
    B_reg <= B(N-1) & B;
    
    process(A_reg, B_reg, C)
    begin
        if C = '0' then
            result_temp <= std_logic_vector(signed(A_reg) + signed(B_reg));
        else
            result_temp <= std_logic_vector(signed(A_reg) - signed(B_reg));
        end if;
    end process;
    
    Y <= result_temp(N-1 downto 0);
end Progetto_Behavioral;