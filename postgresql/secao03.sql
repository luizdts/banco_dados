-- Secao 03 utilizando PostgreSQL

CREATE TABLE tipos_produtos(
	id SERIAL PRIMARY KEY, -- SERIAL => INT e AUTO_INCREMENT
	descricao CHARACTER VARYING(50) NOT NULL
);

CREATE TABLE produtos(
	id SERIAL PRIMARY KEY,
	descricao CHARACTER VARYING(50) NOT NULL,
	preco MONEY NOT NULL,
	id_tipo_produto INT REFERENCES tipos_produtos(id) NOT NULL
);

CREATE TABLE pacientes(
	id SERIAL PRIMARY KEY,
	nome CHARACTER VARYING(50) NOT NULL,
	endereco CHARACTER VARYING(50) NOT NULL,
	bairro CHARACTER VARYING(50) NOT NULL,
	cidade VARCHAR(40) NOT NULL,
	estado CHAR(2) NOT NULL,
	cep VARCHAR(9) NOT NULL,
	data_nascimento DATE NOT NULL
);

CREATE TABLE professores(
	id SERIAL PRIMARY KEY,
	telefone INT NOT NULL,
	nome VARCHAR(50) NOT NULL
);

CREATE TABLE turmas(
	id SERIAL PRIMARY KEY,
	capacidade INT NOT NULL,
	id_professor INT REFERENCES professores(id) NOT NULL

);

-- INSERINDO DADOS

INSERT INTO tipos_produtos (descricao) VALUES('Computadores');
INSERT INTO tipos_produtos (descricao) VALUES('Impressoras');
INSERT INTO tipos_produtos (descricao) VALUES('Outros');

-- selects

SELECT * FROM tipos_produtos;

INSERT INTO produtos (descricao, preco, id_tipo_produto) VALUES ('Notebook Dell', 2500, 1);
INSERT INTO produtos (descricao, preco, id_tipo_produto) VALUES ('Impressora', 500, 2);
INSERT INTO produtos (descricao, preco, id_tipo_produto) VALUES ('Mouse', 45, 3);

SELECT * FROM produtos;

INSERT INTO pacientes (nome, endereco, bairro, cidade, estado, cep, data_nascimento)
	VALUES ('Joao', 'Rua Alta 12', 'Mirassol', 'Natal', 'RN', '59000-000', '1990-09-12');
	
SELECT * FROM pacientes;