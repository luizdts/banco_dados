CREATE TABLE categorias(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL
);

CREATE TABLE produtos(
	id SERIAL PRIMARY KEY,
	descricao VARCHAR(50) NOT NULL,
	preco_venda DECIMAL(8,2) NOT NULL,
	preco_custo MONEY NOT NULL,
	id_categoria INT REFERENCES categorias(id) NOT NULL
);

INSERT INTO categorias(nome) VALUES ('Material Escolar');
INSERT INTO categorias(nome) VALUES ('Acessório Info.');
INSERT INTO categorias(nome) VALUES ('Material Escritório');
INSERT INTO categorias(nome) VALUES ('Games');

INSERT INTO produtos(descricao, preco_venda, preco_custo, id_categoria)
	VALUES ('Caderno', 5.50, 2.50, 1);
INSERT INTO produtos(descricao, preco_venda, preco_custo, id_categoria)
	VALUES ('Caneta', 2.50, 0.50, 1);
INSERT INTO produtos(descricao, preco_venda, preco_custo, id_categoria)
	VALUES ('Pendrive 64GB', 45.0, 22.50, 2);
INSERT INTO produtos(descricao, preco_venda, preco_custo, id_categoria)
	VALUES ('Mouse', 55.0, 20.50, 2);
	
SELECT MAX(preco_venda) FROM produtos;

SELECT MIN(preco_venda) FROM produtos;

SELECT AVG(preco_custo) FROM produtos; -- não funciona no PostgreSQL

SELECT AVG(preco_venda) FROM produtos;
SELECT TO_CHAR(AVG(preco_venda),'99999999D99') AS Media FROM produtos;

SELECT ROUND(AVG(preco_venda::numeric),2) FROM produtos;
SELECT ROUND(AVG(preco_custo::numeric),2) FROM produtos;

SELECT ROUND(AVG(preco_venda),5) FROM produtos;

SELECT COUNT(preco_venda) FROM produtos WHERE id_categoria = 1;

SELECT id_categoria, MAX(preco_venda) FROM produtos GROUP BY id_categoria;

SELECT id_categoria, MAX(preco_venda) FROM produtos GROUP BY id_categoria HAVING MAX(preco_venda) > 10;