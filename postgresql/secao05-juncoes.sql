CREATE TABLE profissoes(
	id SERIAL PRIMARY KEY,
	cargo VARCHAR(50) NOT NULL
);

CREATE TABLE clientes(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	data_nascimento DATE NOT NULL,
	telefone VARCHAR(50) NOT NULL,
	id_profissao INT REFERENCES profissoes(id) NOT NULL
);

CREATE TABLE consumidor(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	contato VARCHAR(50) NOT NULL,
	endereco VARCHAR(50) NOT NULL,
	cidade VARCHAR(50) NOT NULL,
	cep VARCHAR(10) NOT NULL,
	pais VARCHAR(50) NOT NULL
);

INSERT INTO profissoes(cargo) VALUES ('Programador');
INSERT INTO profissoes(cargo) VALUES ('Analista de Sistemas');
INSERT INTO profissoes(cargo) VALUES ('Suporte');
INSERT INTO profissoes(cargo) VALUES ('Gerente');

INSERT INTO clientes (nome, data_nascimento, telefone, id_profissao)
	VALUES ('João Pereira', '1999-08-12', '1234-4444', 1);
INSERT INTO clientes (nome, data_nascimento, telefone, id_profissao)
	VALUES ('José Mendes', '1977-02-12', '1234-1234', 2);
INSERT INTO clientes (nome, data_nascimento, telefone, id_profissao)
	VALUES ('Felipe O.', '1989-03-12', '1234-4324', 3);
INSERT INTO clientes (nome, data_nascimento, telefone, id_profissao)
	VALUES ('Mariano Marques', '1969-02-12', '1234-1112', 4);
	
INSERT INTO consumidor (nome, contato, endereco, cidade, cep, pais)
	VALUES ('Carlos', 'Roberto', 'Rua de cima, 12', 'Cidadópolis', '12222-444', 'Brasil');
INSERT INTO consumidor (nome, contato, endereco, cidade, cep, pais)
	VALUES ('Ana', 'Clodoaldo', 'Rua de baixo, 332', 'Cidadópolis', '12222-444', 'Brasil');
INSERT INTO consumidor (nome, contato, endereco, cidade, cep, pais)
	VALUES ('Leandro V.', 'Rogério', 'Rua do meio, 1204', 'Cidadópolis', '12222-444', 'Brasil');

-- Produto Cartesiano
SELECT c.id, c.nome, c.data_nascimento, c.telefone, p.cargo FROM clientes AS c, profissoes AS p WHERE
	c.id_profissao = p.id;

-- Full Outer Join

SELECT * FROM clientes FULL OUTER JOIN profissoes ON clientes.id_profissao = profissoes.id;