-- Secao 04

-- CREATE DATABASE secao04;

CREATE TABLE tipos_produto(
	codigo SERIAL PRIMARY KEY,
	descricao VARCHAR(45) NOT NULL
);

CREATE TABLE produtos(
	codigo SERIAL PRIMARY KEY,
	descricao VARCHAR(45) NOT NULL,
	preco MONEY NOT NULL,
	codigo_tipo INT REFERENCES tipos_produto(codigo) NOT NULL
);

INSERT INTO tipos_produto (descricao) VALUES ('Computador');
INSERT INTO tipos_produto (descricao) VALUES ('Impressora');

INSERT INTO produtos (descricao, preco, codigo_tipo) VALUES ('Desktop', '1200', '1');
INSERT INTO produtos (descricao, preco, codigo_tipo) VALUES ('Notebook', '1500', '1');
INSERT INTO produtos (descricao, preco, codigo_tipo) VALUES ('Impr. jato de tinta', '300', '2');
INSERT INTO produtos (descricao, preco, codigo_tipo) VALUES ('Impr. laser', '700', '2');

SELECT * FROM tipos_produto;

SELECT * FROM produtos;

SELECT codigo, descricao FROM produtos;

-- DML : UPDATE e DELETE

SELECT * FROM tipos_produto;

UPDATE tipos_produto SET descricao = 'Nobreak' WHERE codigo = 2;

SELECT * FROM tipos_produto;

UPDATE produtos set descricao = 'Notebook', preco = '3000' WHERE codigo = 2;

SELECT * FROM produtos;

DELETE FROM produtos WHERE codigo >= 3;

DELETE FROM tipos_produto WHERE codigo = 2;

DELETE FROM produtos; -- ATENÇÃO, O POSTGRES NÃO IRÁ IMPEDIR DE FAZER ESSA DELEÇÃO!

-- DDL: ALTER e DROP

ALTER TABLE tipos_produto ADD peso DECIMAL(8,2);
SELECT * FROM tipos_produto;

DROP TABLE produtos;

DROP TABLE tipos_produto;

DROP DATABASE secao03;