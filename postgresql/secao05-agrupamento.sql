CREATE TABLE tipos(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL
);

CREATE TABLE fabricantes(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL
);

CREATE TABLE produtos(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	id_fabricante INT REFERENCES fabricantes(id) NOT NULL,
	quantidade INT NOT NULL,
	id_tipo INT REFERENCES tipos(id) NOT NULL
);

INSERT INTO tipos (nome) VALUES ('Celular');
INSERT INTO tipos (nome) VALUES ('Notebook');
INSERT INTO tipos (nome) VALUES ('Console');

INSERT INTO fabricantes (nome) VALUES ('Sony');
INSERT INTO fabricantes (nome) VALUES ('Dell');
INSERT INTO fabricantes (nome) VALUES ('Microsoft');
INSERT INTO fabricantes (nome) VALUES ('Apple');

INSERT INTO produtos (nome, id_fabricante, quantidade, id_tipo)
	VALUES ('Playstation 5', 1, 15, 3);
INSERT INTO produtos (nome, id_fabricante, quantidade, id_tipo)
	VALUES ('Core 4 Pro', 2, 25, 2);
INSERT INTO produtos (nome, id_fabricante, quantidade, id_tipo)
	VALUES ('Xbox PRO Series X', 3, 20, 3);
INSERT INTO produtos (nome, id_fabricante, quantidade, id_tipo)
	VALUES ('Iphone 14', 4, 20, 1);
	
SELECT t.nome AS tipo, f.nome AS fabricante, SUM(p.quantidade) AS quantidade_total
	FROM tipos as t, fabricantes as f, produtos as p WHERE t.id = p.id_tipo AND
	f.id = p.id_fabricante GROUP BY t.nome, f.nome;
	
SELECT t.nome AS tipo, f.nome AS fabricante, SUM(p.quantidade) AS quantidade_total
	FROM tipos as t, fabricantes as f, produtos as p WHERE t.id = p.id_tipo AND
	f.id = p.id_fabricante GROUP BY t.nome, f.nome HAVING SUM(p.quantidade) > 15;
	
SELECT * FROM produtos ORDER BY quantidade DESC;
