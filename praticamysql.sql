CREATE DATABASE secao05;

USE secao05;

CREATE TABLE tipos_produto(
	codigo INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(30) NOT NULL,
    PRIMARY KEY (codigo)
);

CREATE TABLE produtos(
	codigo INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(30) NOT NULL,
    preco DECIMAL(8,2) NOT NULL,
    codigo_tipo INT NOT NULL,
    PRIMARY KEY (codigo),
    FOREIGN KEY (codigo_tipo) REFERENCES tipos_produto(codigo)
);
SELECT * FROM tipos_produto;
SELECT * FROM produtos;

INSERT INTO tipos_produto (descricao) VALUES ('Computador');
INSERT INTO tipos_produto (descricao) VALUES ('Impressora');

INSERT INTO produtos (descricao, preco, codigo_tipo) VALUES ('Desktop', 1200, 1);
INSERT INTO produtos (descricao, preco, codigo_tipo) VALUES ('Laptop', 1800, 1);
INSERT INTO produtos (descricao, preco, codigo_tipo) VALUES ('Impr. Jato de Tinta', 300, 2);
INSERT INTO produtos (descricao, preco, codigo_tipo) VALUES ('Impr. Laser', 500, 2);

-- Filtrando com WHERE

SELECT * FROM produtos WHERE codigo_tipo = 2; -- apenas impressoras

SELECT * FROM produtos WHERE codigo_tipo = 2 AND preco > 300;

-- consultas em múltiplas tabelas

SELECT p.codigo, p.descricao, p.preco, tp.descricao AS 'Tipo Produto' -- seleciona os campos para seleção // tp.descricao apelidado de Tipo Produto
																	  -- para evitar redundancia no retorno
	FROM produtos as p, tipos_produto as tp -- apelida as tabelas 
    WHERE p.codigo_tipo = tp.codigo; -- filtra comparando os tipos dos produtos nas tabelas
    
# junção de tabelas

CREATE DATABASE juncao;
use juncao;

CREATE TABLE profissoes (
	id INT NOT NULL AUTO_INCREMENT,
    cargo VARCHAR(60) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE clientes (
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(10) NOT NULL,
    id_profissao INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_profissao) REFERENCES profissoes(id)
);

CREATE TABLE consumidor(
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    contato VARCHAR(50) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
	cep VARCHAR(20) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);
SELECT * FROM profissoes;
SELECT * FROM clientes;
SELECT * FROM consumidor;

INSERT INTO profissoes (cargo) VALUES ('Programador');
INSERT INTO profissoes (cargo) VALUES ('Analista de Sistemas');
INSERT INTO profissoes (cargo) VALUES ('Suporte');
INSERT INTO profissoes (cargo) VALUES ('Gerente');

INSERT INTO clientes (nome, data_nascimento, telefone, id_profissao) VALUES ('João', '1981-06-15', '1234-5678', 1);
INSERT INTO clientes (nome, data_nascimento, telefone, id_profissao) VALUES ('Jose', '1991-02-13', '8765-4321', 2);
INSERT INTO clientes (nome, data_nascimento, telefone, id_profissao) VALUES ('Adriao Jose', '1973-02-08', '1122-3678', 3);
INSERT INTO clientes (nome, data_nascimento, telefone, id_profissao) VALUES ('Carlos Franca', '1970-04-25', '3334-5678', 1);

INSERT INTO consumidor (nome, contato, endereco, cidade, cep, pais) VALUES ('Alfredo','Carmen Dias','Rua 1, 89','São Paulo','59000-001','Brasil');
INSERT INTO consumidor (nome, contato, endereco, cidade, cep, pais) VALUES ('Poliana','Rafael Freitas','Rua 334, 112','Rio de Janeiro','43221-091','Brasil');
INSERT INTO consumidor (nome, contato, endereco, cidade, cep, pais) VALUES ('Marcia Neves','Daniel Neves','Rua Jaboatão, 2234','São Paulo','59084-222','Brasil');

-- Junção em produto cartesiano

SELECT c.id, c.nome, c.data_nascimento, c.telefone, p.cargo FROM clientes AS c, profissoes AS p WHERE c.id_profissao = p.id;

-- Inner Join - a saída tem que ser a mesma que em cima

SELECT c.id, c.nome, c.data_nascimento, c.telefone, p.cargo FROM clientes AS c INNER JOIN profissoes AS p ON c.id_profissao = p.id;

-- Left-Outer-Join

SELECT * FROM clientes LEFT OUTER JOIN profissoes ON clientes.id_profissao = profissoes.id;

-- Right-Outer-Join

SELECT * FROM clientes RIGHT OUTER JOIN profissoes ON clientes.id_profissao = profissoes.id;

-- Full Outer Join

# SELECT * FROM clientes FULL OUTER JOIN profissoes ON clientes.id_profissao = profissoes.id; NÃO FUNCIONA

-- FOJ que funciona em MySQL

SELECT * FROM clientes LEFT OUTER JOIN profissoes ON clientes.id_profissao = profissoes.id
UNION SELECT * FROM clientes RIGHT OUTER JOIN profissoes ON clientes.id_profissao = profissoes.id;

-- Cross Join

SELECT c.id, c.nome, c.data_nascimento, c.telefone, p.cargo FROM clientes AS c CROSS JOIN profissoes AS p;

-- Self Join

SELECT a.nome AS Consumidor1, b.nome AS Consumidor2, a.cidade FROM consumidor AS a INNER JOIN consumidor AS b ON a.id <> b.id
	AND a.cidade = b.cidade ORDER BY a.cidade;


# Funções de agregação

CREATE DATABASE agregacao;
USE agregacao;

CREATE TABLE categorias(
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE produtos(
	id INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(60) NOT NULL,
    preco_venda DECIMAL(8,2) NOT NULL,
    preco_custo DECIMAL(8,2) NOT NULL,
    id_categoria INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id)
);

INSERT INTO categorias (nome) VALUES ('Material escolar');
INSERT INTO categorias (nome) VALUES ('Acessório informática');
INSERT INTO categorias (nome) VALUES ('Material escritório');
INSERT INTO categorias (nome) VALUES ('Gamer');

INSERT INTO produtos (descricao, preco_venda, preco_custo, id_categoria) VALUES ('Caderno', '5.45', '2.30', 1);
INSERT INTO produtos (descricao, preco_venda, preco_custo, id_categoria) VALUES ('Caneta', '1.20', '0.45', 1);
INSERT INTO produtos (descricao, preco_venda, preco_custo, id_categoria) VALUES ('Pendrive 32GB', '120.30', '32.50', 2);
INSERT INTO produtos (descricao, preco_venda, preco_custo, id_categoria) VALUES ('Mouse', '17.60', '4.30', 2);

SELECT * FROM categorias;
SELECT * FROM produtos;

SELECT MAX(preco_venda) FROM produtos;

SELECT MIN(preco_venda) FROM produtos;

SELECT AVG(preco_venda) FROM produtos;

SELECT ROUND(AVG(preco_venda),2) FROM produtos;

SELECT COUNT(preco_venda) AS Quantidade FROM produtos WHERE id_categoria = 1;

SELECT id_categoria, MAX(preco_venda) FROM produtos GROUP BY id_categoria;

SELECT id_categoria, MAX(preco_venda) FROM produtos GROUP BY id_categoria HAVING MAX(preco_venda) > 10;

# Agrupamento

CREATE DATABASE agrupamento;

USE agrupamento;

CREATE TABLE tipos(
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE fabricantes(
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE produtos(
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
	id_fabricante INT NOT NULL,
	quantidade INT NOT NULL,
    id_tipo INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_fabricante) REFERENCES fabricantes(id),
    FOREIGN KEY (id_tipo) REFERENCES tipos(id)
);

INSERT INTO tipos (nome) VALUES ('Console');
INSERT INTO tipos (nome) VALUES ('Notebook');
INSERT INTO tipos (nome) VALUES ('Celular');
INSERT INTO tipos (nome) VALUES ('Smartphone');
INSERT INTO tipos (nome) VALUES ('Sofá');
INSERT INTO tipos (nome) VALUES ('Armário');
INSERT INTO tipos (nome) VALUES ('Refrigerador');

INSERT INTO fabricantes (nome) VALUES ('Sony');
INSERT INTO fabricantes (nome) VALUES ('Dell');
INSERT INTO fabricantes (nome) VALUES ('Microsoft');
INSERT INTO fabricantes (nome) VALUES ('Samsung');
INSERT INTO fabricantes (nome) VALUES ('Apple');
INSERT INTO fabricantes (nome) VALUES ('Beline');
INSERT INTO fabricantes (nome) VALUES ('Magnum');
INSERT INTO fabricantes (nome) VALUES ('CCE');
INSERT INTO fabricantes (nome) VALUES ('Nintendo');

INSERT INTO produtos (nome, id_fabricante, quantidade, id_tipo) VALUES ('Playstation 3', 1, 100, 1);
INSERT INTO produtos (nome, id_fabricante, quantidade, id_tipo) VALUES ('Core 2 Duo 4GB RAM 500GB HD', 2, 200, 2);
INSERT INTO produtos (nome, id_fabricante, quantidade, id_tipo) VALUES ('Xbox 360 120GB', 3, 200, 1);
INSERT INTO produtos (nome, id_fabricante, quantidade, id_tipo) VALUES ('GT-I200 Quad Band', 4, 50, 1);
INSERT INTO produtos (nome, id_fabricante, quantidade, id_tipo) VALUES ('Iphone 6 32GB', 5, 200, 4);
INSERT INTO produtos (nome, id_fabricante, quantidade, id_tipo) VALUES ('Playstation 4', 1, 100, 1);
INSERT INTO produtos (nome, id_fabricante, quantidade, id_tipo) VALUES ('Sofá', 6, 20, 5);
INSERT INTO produtos (nome, id_fabricante, quantidade, id_tipo) VALUES ('Armário de serviço', 7, 10, 6);
INSERT INTO produtos (nome, id_fabricante, quantidade, id_tipo) VALUES ('Refrigerador 500L', 1, 5, 7);
INSERT INTO produtos (nome, id_fabricante, quantidade, id_tipo) VALUES ('Nintendo DS 2022', 8, 100, 1);
INSERT INTO produtos (nome, id_fabricante, quantidade, id_tipo) VALUES ('Nintendo DS 2022 ORIGINAL', 9, 150, 1);

SELECT * FROM tipos;
SELECT * FROM fabricantes;
SELECT * FROM produtos;

-- Aplicando funções de ordenação e agrupamento

SELECT t.nome AS Tipo, f.nome AS Fabricante, SUM(p.quantidade) AS 'Estoque' FROM tipos AS t, fabricantes AS f, produtos AS p
	WHERE t.id = p.id_tipo AND f.id = p.id_fabricante GROUP BY t.nome, f.nome;

SELECT t.nome AS Tipo, f.nome AS Fabricante, SUM(p.quantidade) AS 'Estoque' FROM tipos AS t, fabricantes AS f, produtos AS p
	WHERE t.id = p.id_tipo AND f.id = p.id_fabricante GROUP BY t.nome, f.nome HAVING SUM(p.quantidade) > 100;

SELECT * FROM produtos;

SELECT id, nome, id_tipo, id_fabricante, quantidade FROM produtos ORDER BY id ASC;

SELECT id, nome, id_tipo, id_fabricante, quantidade FROM produtos ORDER BY quantidade DESC;

# funções data-hora

SELECT CURDATE() AS Data_atual;
SELECT CURTIME();
SELECT CURRENT_TIME() AS Hora_atual;

SELECT DATE_ADD(CURDATE(), INTERVAL 3 DAY) AS 'Data de vencimento';

SELECT DATE_SUB(CURDATE(), INTERVAL 10 DAY) AS 'Data de matrícula';

SELECT DATEDIFF(CURDATE(), DATE_SUB(CURDATE(), INTERVAL 10 DAY)) AS 'Dias em atraso';

SELECT DATE_FORMAT(CURDATE(), '%d/%m/%Y') AS 'Data formatada';

SELECT DAYNAME(CURDATE());

SELECT DAYOFMONTH(CURDATE());

SELECT DAYOFWEEK(CURDATE());

SELECT DAYOFYEAR(CURDATE());

SELECT FROM_DAYS(803284);

SELECT NOW();

SELECT CURRENT_TIMESTAMP(); -- FUNCIONA IGUAL O NOW()

SELECT TIME(CURRENT_TIMESTAMP()); -- RETORNA APENAS AS HORAS

SELECT TIME_TO_SEC('01:00:00');

SELECT HOUR(CURRENT_TIMESTAMP()) AS 'HORA', MINUTE(CURRENT_TIMESTAMP()) AS 'MINUTOS', SECOND(current_timestamp()) AS 'SEGUNDOS';

SELECT QUARTER ('2022-03-01');

SELECT WEEKDAY ('2022-03-01');

# SUB-CONSULTAS

CREATE DATABASE subconsulta;
use subconsulta;

CREATE TABLE escritorios(
	id INT NOT NULL AUTO_INCREMENT,
    pais VARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE funcionarios(
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(20) NOT NULL,
    sobrenome VARCHAR(20) NOT NULL,
    id_escritorio INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_escritorio) REFERENCES escritorios(id)
);

CREATE TABLE pagamentos(
	id INT NOT NULL AUTO_INCREMENT,
    id_funcionario INT NOT NULL,
    salario DECIMAL(8,2) NOT NULL,
    data DATE NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id)
);

INSERT INTO escritorios (pais) VALUES ('Brasil');
INSERT INTO escritorios (pais) VALUES ('Estados Unidos');
INSERT INTO escritorios (pais) VALUES ('Alemanha');
INSERT INTO escritorios (pais) VALUES ('França');

INSERT INTO funcionarios (nome, sobrenome, id_escritorio) VALUES ('Pedro', 'Souza', 1);
INSERT INTO funcionarios (nome, sobrenome, id_escritorio) VALUES ('Sandro', 'Lopes', 2);
INSERT INTO funcionarios (nome, sobrenome, id_escritorio) VALUES ('Mihael', 'Zoio', 3);
INSERT INTO funcionarios (nome, sobrenome, id_escritorio) VALUES ('Oliver', 'Khan', 4);

INSERT INTO pagamentos (id_funcionario, salario, data) VALUES (1, '5348.99', '2022-02-28');
INSERT INTO pagamentos (id_funcionario, salario, data) VALUES (2, '3418.99', '2022-02-28');
INSERT INTO pagamentos (id_funcionario, salario, data) VALUES (3, '2343.29', '2022-02-28');
INSERT INTO pagamentos (id_funcionario, salario, data) VALUES (4, '9348.99', '2022-02-28');

SELECT nome, sobrenome FROM funcionarios WHERE id_escritorio IN (SELECT id FROM escritorios WHERE pais = 'Brasil');

SELECT nome, sobrenome FROM funcionarios, escritorios AS e WHERE id_escritorio = e.id AND e.pais = 'Brasil';

SELECT f.nome, f.sobrenome, e.pais, p.salario FROM pagamentos AS p, funcionarios AS f, escritorios AS e WHERE f.id_escritorio = e.id 
	AND f.id = p.id_funcionario AND salario = (SELECT MAX(salario) FROM pagamentos);

SELECT f.nome, f.sobrenome, e.pais, p.salario FROM pagamentos AS p, funcionarios AS f, escritorios AS e WHERE f.id_escritorio = e.id 
	AND f.id = p.id_funcionario AND salario < (SELECT AVG(salario) FROM pagamentos);
    
SELECT f.nome, f.sobrenome, e.pais, p.salario FROM pagamentos AS p, funcionarios AS f, escritorios AS e WHERE f.id_escritorio = e.id 
	AND f.id = p.id_funcionario AND salario > (SELECT AVG(salario) FROM pagamentos);