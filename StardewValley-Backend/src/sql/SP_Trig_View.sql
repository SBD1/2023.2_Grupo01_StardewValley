BEGIN TRANSACTION;

\c stardew_valley

-- =======================================================================================
-- 01 - Eu como Banco de Dados gostaria de Atualizar os dados do novo jogador na tabela 
-- "Jogador" para Para iniciar o jogo 
-- =======================================================================================
-- atualizar dados do novo jogador, verificando se o jogador já existe
CREATE OR REPLACE FUNCTION iniciar_jogo(novo_nome_jogador CHAR(50), OUT jogo_iniciado BOOLEAN)
RETURNS BOOLEAN AS $$
DECLARE
    id_novo INT;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Jogador WHERE nome = novo_nome_jogador) THEN
        id_novo = (SELECT MAX(id_jogador) FROM Jogador) + 1;
        INSERT INTO Jogador (id_jogador, nome, id_regiao)
        VALUES (id_novo, novo_nome_jogador, 1);
        jogo_iniciado := TRUE;
    ELSE
        jogo_iniciado := FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;
-- =======================================================================================


COMMIT;