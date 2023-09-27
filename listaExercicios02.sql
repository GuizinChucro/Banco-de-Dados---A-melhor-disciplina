1. Lista de Autores:

sql
DELIMITER //

CREATE PROCEDURE sp_ListarAutores()
BEGIN
    SELECT * FROM Autor;
END;

2. Livros por Categoria:

sql
DELIMITER //

CREATE PROCEDURE sp_LivrosPorCategoria(IN categoria_nome VARCHAR(100))
BEGIN
    SELECT Livro.Titulo
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoria_nome;
END;

3. Contagem de Livros por Categoria:

sql
DELIMITER //

CREATE PROCEDURE sp_ContarLivrosPorCategoria(IN categoria_nome VARCHAR(100))
BEGIN
    SELECT COUNT(Livro.Livro_ID) AS total
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoria_nome;
END;


4. Verificação de livros por categoria:

sql
DELIMITER //

CREATE PROCEDURE sp_VerificarLivrosCategoria(IN categoria_nome VARCHAR(100))
BEGIN
    DECLARE total INT;
    
    CALL sp_ContarLivrosPorCategoria(categoria_nome);
    SELECT total INTO total;
    
    IF total > 0 THEN
        SELECT 'A categoria possui livros.' AS mensagem;
    ELSE
        SELECT 'A categoria não possui livros.' AS mensagem;
    END IF;
END;

5. Listagem de Livros por Ano:

sql
DELIMITER //

CREATE PROCEDURE sp_LivrosAteAno(IN ano INT)
BEGIN
    SELECT *
    FROM Livro
    WHERE Ano_Publicacao <= ano;
END;

6. Extração de títulos por categoria:
sql
DELIMITER //

CREATE PROCEDURE sp_TitulosPorCategoria(IN categoria_nome VARCHAR(100))
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE livro_titulo VARCHAR(255);
    DECLARE cur CURSOR FOR
        SELECT Livro.Titulo
        FROM Livro
        INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
        WHERE Categoria.Nome = categoria_nome;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO livro_titulo;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT livro_titulo;
    END LOOP;
    CLOSE cur;
END;

7. Adição de Livro com Tratamento de Erros:

sql
DELIMITER //

CREATE PROCEDURE sp_AdicionarLivro(IN titulo VARCHAR(255), IN editora_id INT, IN ano_publicacao INT, IN numero_paginas INT, IN categoria_id INT)
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        SELECT 'Erro: Título já existente.' AS mensagem;
    
    INSERT INTO Livro (Titulo, Editora_ID, Ano_Publicacao, Numero_Paginas, Categoria_ID)
    VALUES (titulo, editora_id, ano_publicacao, numero_paginas, categoria_id);
    
    SELECT 'Livro adicionado com sucesso.' AS mensagem;
END;

8. Autor Mais Antigo:

sql
DELIMITER //

CREATE PROCEDURE sp_AutorMaisAntigo()
BEGIN
    SELECT Nome, Sobrenome
    FROM Autor
    WHERE Data_Nascimento = (SELECT MIN(Data_Nascimento) FROM Autor);
END;
