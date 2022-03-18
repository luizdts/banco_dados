CREATE TABLE tipos_produto(
	codigo INTEGER PRIMARY KEY AUTOINCREMENT,
	descricao TEXT NOT NULL
);

CREATE TABLE produtos(
	codigo INTEGER PRIMARY KEY AUTOINCREMENT,
	descricao TEXT NOT NULL,
	preco REAL NOT NULL,
	codigo_tipo INTEGER REFERENCES tipos_produto(codigo) NOT NULL
);	

INSERT INTO tipos_produto (descricao) VALUES ('Computadores');
INSERT INTO tipos_produto (descricao) VALUES ('Impressora');

INSERT INTO produtos (descricao, preco, codigo_tipo)
	VALUES ('Desktop', 1500, 1);
INSERT INTO produtos (descricao, preco, codigo_tipo)
	VALUES ('Laptop', 2500, 1);
INSERT INTO produtos (descricao, preco, codigo_tipo)
	VALUES ('Impr. Jato de Tinta', 400, 2);
INSERT INTO produtos (descricao, preco, codigo_tipo)
	VALUES ('Impr. Laser', 800, 2);
-- DQL
SELECT * FROM produtos;
SELECT * FROM tipos_produto;
SELECT p.codigo as cod, p.descricao as descr, p.preco as pre, p.codigo_tipo as ctp
	FROM produtos as p;

-- DML

INSERT INTO tipos_produto (descricao) VALUES ('Notebook');

INSERT INTO produtos (descricao, preco, codigo_tipo)
	VALUES ('Notebook', 1500, 1);
INSERT INTO produtos (descricao, preco, codigo_tipo)
	VALUES ('IPad', 4500, 1);
INSERT INTO produtos (descricao, preco, codigo_tipo)
	VALUES ('iPhone', '2200', 1);

SELECT * FROM tipos_produto;

UPDATE tipos_produto SET descricao = 'Nobreak' WHERE codigo = 3;

UPDATE produtos SET descricao = 'Notebook', preco = 2500 WHERE codigo = 2;

DELETE FROM tipos_produto WHERE codigo = 3;

-- DDL

ALTER TABLE tipos_produto ADD peso REAL;

SELECT * FROM tipos_produto;

DROP TABLE tipos_produto; -- Precisamos deletar as relações com as outras tabelas


-- DCL

-- NO SQLITE NÃO HÁ GRANT/REVOKE IMPLEMENTADOS

-- DTL

BEGIN TRANSACTION;

	INSERT INTO tipos_produto (descricao) VALUES ('Notebook');
	
COMMIT;

SELECT * FROM tipos_produto;



BEGIN TRANSACTION;

	INSERT INTO tipos_produto (descricao) VALUES ('Notebook');
	
ROLLBACK;

SELECT * FROM tipos_produto;


