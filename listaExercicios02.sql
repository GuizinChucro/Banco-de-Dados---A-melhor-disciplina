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

