CREATE TABLE tipos_produto(
	codigo SERIAL PRIMARY KEY,
	descricao VARCHAR(50) NOT NULL
);

CREATE TABLE produtos(
	codigo SERIAL PRIMARY KEY,
	descricao VARCHAR(50) NOT NULL,
	preco MONEY NOT NULL,
	codigo_tipo INT REFERENCES tipos_produto(codigo) NOT NULL
);


INSERT INTO tipos_produto(descricao) VALUES ('Computador');
INSERT INTO tipos_produto(descricao) VALUES ('Impressora');
INSERT INTO tipos_produto(descricao) VALUES ('Outros');

INSERT INTO produtos(descricao, preco, codigo_tipo) VALUES ('Desktop', 2000, 1);
INSERT INTO produtos(descricao, preco, codigo_tipo) VALUES ('Laptop', 2500, 1);
INSERT INTO produtos(descricao, preco, codigo_tipo) VALUES ('Impr. Laser', 500, 2);
INSERT INTO produtos(descricao, preco, codigo_tipo) VALUES ('Impr. Jato de Tinta', 300, 2);

SELECT * FROM produtos WHERE produtos.preco < '500';

SELECT p.codigo, p.descricao, p.preco, tp.descricao FROM produtos AS p, tipos_produto AS tp
	WHERE p.codigo_tipo = tp.codigo;
	
-- Junção

CREATE DATABASE juncao;

