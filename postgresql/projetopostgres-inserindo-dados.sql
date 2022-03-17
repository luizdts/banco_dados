-- Atores

INSERT INTO atores (nome) VALUES ('Brad Pitt');
INSERT INTO atores (nome) VALUES ('Tobey Maguire');
INSERT INTO atores (nome) VALUES ('Tom Holland');

-- Generos

INSERT INTO generos (genero) VALUES ('Comédia');
INSERT INTO generos (genero) VALUES ('Ação');
INSERT INTO generos (genero) VALUES ('Terror');

-- Filmes

INSERT INTO filmes (titulo, id_genero, valor) VALUES ('Homem-Aranha', 2, 8.99);
INSERT INTO filmes (titulo, id_genero, valor) VALUES ('Homem-Aranha 2022', 2, 15.99);
INSERT INTO filmes (titulo, id_genero, valor) VALUES ('Sr. e Sra. Smith', 2, 4.99);

-- Clientes

INSERT INTO clientes (nome, sobrenome, telefone, endereco)
	VALUES ('Julio', 'Cesar', '1123-4498', 'Rua de cima, 49');
INSERT INTO clientes (nome, sobrenome, telefone, endereco)
	VALUES ('Ramon', 'Jemon', '8966-7755', 'Rua do centro, 4129');
INSERT INTO clientes (nome, sobrenome, telefone, endereco)
	VALUES ('Carla', 'Lopes', '4421-3448', 'Rua superior, 449');
	
-- Atores_filme

INSERT INTO atores_filme (id_filme, id_ator, personagem)
	VALUES (3, 1, 'Sr. Smith');
INSERT INTO atores_filme (id_filme, id_ator, personagem)
	VALUES (1, 2, 'Peter Parker/Homem Aranha');
INSERT INTO atores_filme (id_filme, id_ator, personagem)
	VALUES (2, 3, 'Peter Parker/Homem Aranha');
	
-- Dvds

INSERT INTO dvds (id_filme, quantidade) VALUES (1, 5);
INSERT INTO dvds (id_filme, quantidade) VALUES (2, 15);
INSERT INTO dvds (id_filme, quantidade) VALUES (3, 5);

-- Emprestimo

INSERT INTO emprestimos (data, id_cliente) VALUES ('2022-03-15', 1);
INSERT INTO emprestimos (data, id_cliente) VALUES ('2022-03-16', 2);
INSERT INTO emprestimos (data, id_cliente) VALUES ('2022-03-16', 3);

-- Filmes_emprestimo

INSERT INTO filmes_emprestimo (id_emprestimo, id_dvd) VALUES (1, 1);
INSERT INTO filmes_emprestimo (id_emprestimo, id_dvd) VALUES (1, 2);
INSERT INTO filmes_emprestimo (id_emprestimo, id_dvd) VALUES (2, 2);
INSERT INTO filmes_emprestimo (id_emprestimo, id_dvd) VALUES (3, 1);
INSERT INTO filmes_emprestimo (id_emprestimo, id_dvd) VALUES (3, 2);
INSERT INTO filmes_emprestimo (id_emprestimo, id_dvd) VALUES (3, 3);

-- Devolucoes

INSERT INTO devolucoes (id_emprestimo, data) VALUES (1, '2022-03-16');
INSERT INTO devolucoes (id_emprestimo, data) VALUES (2, '2022-03-19');
INSERT INTO devolucoes (id_emprestimo, data) VALUES (3, '2022-03-19');

-- Filmes_devolucao

INSERT INTO filmes_devolucao (id_devolucao, id_filme_emprestimo) VALUES (1, 1);
INSERT INTO filmes_devolucao (id_devolucao, id_filme_emprestimo) VALUES (1, 2);
INSERT INTO filmes_devolucao (id_devolucao, id_filme_emprestimo) VALUES (2, 3);
INSERT INTO filmes_devolucao (id_devolucao, id_filme_emprestimo) VALUES (3, 4);
INSERT INTO filmes_devolucao (id_devolucao, id_filme_emprestimo) VALUES (3, 5);
INSERT INTO filmes_devolucao (id_devolucao, id_filme_emprestimo) VALUES (3, 6);

-- Consultas simples

SELECT * FROM atores;

SELECT * FROM clientes;

SELECT * FROM generos;

SELECT * FROM filmes;

SELECT f.id, f.titulo, g.genero, f.valor FROM filmes AS f, generos AS g WHERE f.id_genero = g.id; -- Filmes e generos

SELECT af.id, f.titulo, a.nome, af.personagem FROM filmes as f, atores_filme as af, atores as a WHERE af.id_filme =
	f.id AND af.id_ator = a.id;
	
-- Filtros

SELECT * FROM generos WHERE id = 2;

-- Funcoes agregadas

SELECT SUM(valor) FROM filmes;
SELECT MAX(valor) FROM filmes;

-- Consultas complexas

SELECT f.titulo, g.genero, af.personagem FROM filmes AS f, generos AS g, atores_filme AS af, atores AS a
	WHERE f.id = af.id_filme AND g.id = f.id_genero AND a.id = af.id_ator AND a.nome = 'Brad Pitt';
	
SELECT f.titulo, a.nome, af.personagem FROM filmes AS f, generos AS g, atores_filme AS af, atores AS a
	WHERE f.id = af.id_filme AND g.id = f.id_genero AND a.id = af.id_ator AND g.genero = 'Ação'
	AND a.nome = 'Brad Pitt';
	
-- Verificando empréstimos

SELECT e.id, c.nome, c.sobrenome, e.data, f.titulo, g.genero 
	FROM emprestimos as e, clientes as c, filmes as f, generos as g, dvds as d, filmes_emprestimo as fe
	WHERE fe.id_emprestimo = e.id AND e.id_cliente = c.id AND f.id = d.id_filme AND fe.id_dvd = d.id
		AND g.id = f.id_genero;
		
-- Devolucoes dos clientes

SELECT de.id, c.nome, c.sobrenome, de.data, f.titulo FROM devolucoes as de, clientes as c, filmes as f,
	filmes_devolucao as fd, dvds as d, emprestimos as e, filmes_emprestimo as fe 
	WHERE fd.id_devolucao = de.id
		AND fd.id_filme_emprestimo = fe.id
		AND d.id_filme = f.id
		AND e.id_cliente = c.id
		AND fe.id_dvd = d.id
		AND de.id_emprestimo = e.id 
		AND fe.id_emprestimo = e.id;
		
-- Verificando o valor pago por cliente

SELECT c.nome, c.sobrenome, e.id, SUM(f.valor) FROM filmes_devolucao as fd,
	clientes as c, dvds as d, filmes as f, devolucoes as de, emprestimos as e, filmes_emprestimo as fe
	WHERE fd.id_filme_emprestimo = fe.id
		AND fd.id_devolucao = de.id
		AND f.id = d.id_filme
		AND fe.id_emprestimo = e.id
		AND fe.id_dvd = d.id
		AND e.id_cliente = c.id
		AND de.id_emprestimo = e.id GROUP BY e.id, c.nome, c.sobrenome;
		
-- Atualizando campos

SELECT id, nome FROM atores ORDER BY id ASC;

UPDATE atores SET nome = 'Bread Pitú' WHERE id = 1;

SELECT id, data, id_cliente FROM emprestimos ORDER BY id ASC;

UPDATE emprestimos SET data = '2022-03-17' WHERE id = 2;

-- Excluindo dados

SELECT * FROM generos;

DELETE FROM generos WHERE id = 3; -- Removido gênero terror

-- Lembrando que, se desejar remover um dado que esteja se relacionando a outra tabela, devemos deletar
-- o vínculo na outra tabela e em seguida remover o campo na tabela desejada.
SELECT * FROM filmes;
DELETE FROM filmes WHERE id = 3;

SELECT * FROM dvds;

DELETE FROM dvds WHERE id_filme = 3;

SELECT * FROM filmes_emprestimo;

DELETE FROM filmes_emprestimo WHERE id_dvd = 3;

SELECT * FROM filmes_devolucao;

DELETE FROM filmes_devolucao WHERE id_filme_emprestimo = 6;

SELECT * FROM atores_filme;

DELETE FROM atores_filme WHERE id_filme = 3;
