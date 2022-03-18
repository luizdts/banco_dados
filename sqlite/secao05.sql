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

-- Filtrando dados com SELECT
	
SELECT * FROM tipos_produto WHERE codigo = 1;

SELECT * FROM produtos WHERE preco > 300;

SELECT codigo, descricao, codigo_tipo FROM produtos WHERE descricao = 'Laptop';

SELECT p.codigo AS cod, p.descricao AS descr, p.preco AS pre, p.codigo AS ctp FROM produtos AS p 
	WHERE p.codigo = 3;
	
SELECT p.codigo AS cod, p.descricao AS descr, p.preco AS pre, tp.descricao AS 'Tipo Produto' FROM produtos AS p, tipos_produto AS tp 
	WHERE p.codigo_tipo = tp.codigo;

-- Juncao

CREATE TABLE profissoes(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	cargo TEXT NOT NULL
);

CREATE TABLE clientes(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nome TEXT NOT NULL,
	data_nascimento TEXT NOT NULL,
	telefone TEXT NOT NULL,
	id_profissao INTEGER REFERENCES profissoes(id) NOT NULL
);

CREATE TABLE consumidor(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nome TEXT NOT NULL,
	contato TEXT NOT NULL,
	endereco TEXT NOT NULL,
	cidade TEXT NOT NULL,
	cep TEXT NOT NULL,
	pais TEXT NOT NULL
);

INSERT INTO profissoes (cargo) VALUES ('Programador');
INSERT INTO profissoes (cargo) VALUES ('Analista de Sistemas');
INSERT INTO profissoes (cargo) VALUES ('Suporte');
INSERT INTO profissoes (cargo) VALUES ('Gerente');

INSERT INTO clientes (nome, data_nascimento, telefone, id_profissao)
	VALUES ('Jose Benrad', '1987-02-11', '1111-3333', 1);
INSERT INTO clientes (nome, data_nascimento, telefone, id_profissao)
	VALUES ('Juliana Lima', '1998-03-21', '9887-3231', 2);
INSERT INTO clientes (nome, data_nascimento, telefone, id_profissao)
	VALUES ('Clara Benforte', '1981-03-11', '3821-3126', 3);
INSERT INTO clientes (nome, data_nascimento, telefone, id_profissao)
	VALUES ('Taciano Clarc', '1989-08-13', '1239-4627', 3);
	
INSERT INTO consumidor (nome, contato, endereco, cidade, cep, pais) 
	VALUES ('Reginaldo Lombre', 'Carlota Regina', 'Rua de cima, 12', 'São Bento', '11133-123', 'Brasil');
INSERT INTO consumidor (nome, contato, endereco, cidade, cep, pais) 
	VALUES ('Fabiana Luz', 'Angel Routz', 'Rua da praia, 3412', 'São José', '13123-323', 'Brasil');
INSERT INTO consumidor (nome, contato, endereco, cidade, cep, pais) 
	VALUES ('Carlos Snake', 'Juliano Fontoura', 'Rua da Prata, 132', 'São Carlos', '49873-498', 'Brasil');
	
SELECT c.nome, c.data_nascimento, c.telefone, p.cargo FROM clientes as c, profissoes as p
	WHERE c.id_profissao = p.id; -- Produto cartesiano
	
-- Right Outer Join e Full Outer Join não funcionam no SQLite

SELECT a.nome, b.nome, a.cidade FROM consumidor AS a INNER JOIN consumidor AS b ON a.id <> b.id AND a.cidade = b.cidade ORDER BY a.cidade;

-- Agregação

CREATE TABLE categorias(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nome TEXT NOT NULL
);

CREATE TABLE produtos(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	descricao TEXT NOT NULL,
	preco_venda REAL NOT NULL,
	preco_custo REAL NOT NULL,
	id_categoria INTEGER REFERENCES categorias(id) NOT NULL
);

INSERT INTO categorias (nome) VALUES ('Material Escolar');
INSERT INTO categorias (nome) VALUES ('Informática');
INSERT INTO categorias (nome) VALUES ('Material Escritório');
INSERT INTO categorias (nome) VALUES ('Gamer');

INSERT INTO produtos (descricao, preco_venda, preco_custo, id_categoria)
	VALUES ('Caderno', 5, 2, 1);
INSERT INTO produtos (descricao, preco_venda, preco_custo, id_categoria)
	VALUES ('Caneta', 2, 0.5, 1);
INSERT INTO produtos (descricao, preco_venda, preco_custo, id_categoria)
	VALUES ('Pendrive 2TB', 90, 32, 2);
INSERT INTO produtos (descricao, preco_venda, preco_custo, id_categoria)
	VALUES ('Mouse Logitech', 205, 99, 4);
	
-- Consultas

SELECT MAX(preco_venda) FROM produtos;

SELECT MIN(preco_venda) FROM produtos;

SELECT MAX(preco_custo) FROM produtos;

SELECT MIN(preco_custo) FROM produtos;

SELECT AVG(preco_venda) FROM produtos;

SELECT ROUND(AVG(preco_venda), 2) FROM produtos;

SELECT id_categoria, MAX(preco_venda) FROM produtos GROUP BY id_categoria;

SELECT id_categoria, MAX(preco_venda) FROM produtos GROUP BY id_categoria HAVING MAX(preco_venda) > 10;

-- AGRUPAMENTO

CREATE TABLE tipos(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nome TEXT NOT NULL
);

CREATE TABLE fabricantes(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nome TEXT NOT NULL
);

CREATE TABLE produtos(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nome TEXT NOT NULL,
	id_fabricante INTEGER REFERENCES fabricantes(id) NOT NULL,
	quantidade INTEGER NOT NULL,
	id_tipo INTEGER REFERENCES tipos(id) NOT NULL
);

INSERT INTO tipos(nome) VALUES ('Console');
INSERT INTO tipos(nome) VALUES ('Celular');
INSERT INTO tipos(nome) VALUES ('Notebook');

INSERT INTO fabricantes(nome) VALUES ('Sony');
INSERT INTO fabricantes(nome) VALUES ('Samsung');
INSERT INTO fabricantes(nome) VALUES ('Dell');

INSERT INTO produtos(nome, id_fabricante, quantidade, id_tipo)
	VALUES ('PS5', 1, 50, 1);
INSERT INTO produtos(nome, id_fabricante, quantidade, id_tipo)
	VALUES ('Samsung Galaxy S22', 2, 25, 2);
INSERT INTO produtos(nome, id_fabricante, quantidade, id_tipo)
	VALUES ('Dell Inspiron 9000', 3, 10, 3);
	
SELECT t.nome AS Tipo, f.nome AS Fabricante, SUM(p.quantidade) AS 'Estoque'
	FROM tipos AS t, fabricantes AS f, produtos AS p
		WHERE t.id = p.id_tipo AND f.id = p.id_fabricante
		GROUP BY t.nome, f.nome;
	
SELECT t.nome AS Tipo, f.nome AS Fabricante, SUM(p.quantidade) AS 'Estoque'
	FROM tipos AS t, fabricantes AS f, produtos AS p
		WHERE t.id = p.id_tipo AND f.id = p.id_fabricante
		GROUP BY t.nome, f.nome HAVING SUM(p.quantidade) > 20; 
	
SELECT * FROM produtos ORDER BY quantidade DESC;


-- data e hora

SELECT time(CURRENT_TIMESTAMP, 'localtime');

-- subconsultas
CREATE TABLE escritorios(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	pais TEXT NOT NULL
);

CREATE TABLE funcionarios(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nome TEXT NOT NULL,
	sobrenome TEXT NOT NULL,
	id_escritorio INTEGER REFERENCES escritorios(id) NOT NULL
);

CREATE TABLE pagamentos(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	salario REAL NOT NULL,
	data TEXT NOT NULL,
	id_funcionario INTEGER REFERENCES funcionarios(id) NOT NULL
);

INSERT INTO escritorios (pais) VALUES ('Brasil');
INSERT INTO escritorios (pais) VALUES ('EUA');

INSERT INTO funcionarios (nome, sobrenome, id_escritorio)
	VALUES ('Jose', 'Silva', 1);
INSERT INTO funcionarios (nome, sobrenome, id_escritorio)
	VALUES ('Fransueldo', 'Silva', 2);
	
INSERT INTO pagamentos (id_funcionario, salario, data)
	VALUES (1, 5000, '2022-03-18');
INSERT INTO pagamentos (id_funcionario, salario, data)
	VALUES (2, 9000, '2022-03-18');
	
SELECT nome, sobrenome FROM funcionarios WHERE id_escritorio IN
	(SELECT id FROM escritorios WHERE pais = 'Brasil');

SELECT f.nome, f.sobrenome, e.pais, p.salario FROM pagamentos as p, escritorios as e, funcionarios as f
	WHERE f.id_escritorio = e.id AND f.id = p.id_funcionario
		AND salario = (SELECT MAX(salario) FROM pagamentos);

SELECT f.nome, f.sobrenome, e.pais, p.salario FROM pagamentos as p, escritorios as e, funcionarios as f
	WHERE f.id_escritorio = e.id AND f.id = p.id_funcionario
		AND salario > (SELECT AVG(salario) FROM pagamentos);		