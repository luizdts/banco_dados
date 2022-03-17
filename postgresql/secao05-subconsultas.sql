CREATE TABLE escritorios(
	id SERIAL PRIMARY KEY,
	pais VARCHAR(50) NOT NULL
);

CREATE TABLE funcionarios(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	sobrenome VARCHAR(50) NOT NULL,
	id_escritorio INT REFERENCES escritorios(id) NOT NULL
);

CREATE TABLE pagamentos(
	id SERIAL PRIMARY KEY,
	id_funcionario INT REFERENCES funcionarios(id) NOT NULL,
	salario DECIMAL(8,2) NOT NULL,
	data DATE NOT NULL
);

INSERT INTO escritorios (pais) VALUES ('Brasil');
INSERT INTO escritorios (pais) VALUES ('Estados Unidos');
INSERT INTO escritorios (pais) VALUES ('Alemanha');
INSERT INTO escritorios (pais) VALUES ('França');

INSERT INTO funcionarios (nome, sobrenome, id_escritorio) 
	VALUES ('Pedro','Alves', 1);
INSERT INTO funcionarios (nome, sobrenome, id_escritorio) 
	VALUES ('Sandra','Neves', 2);
INSERT INTO funcionarios (nome, sobrenome, id_escritorio) 
	VALUES ('Mikail','Vorov', 3);
INSERT INTO funcionarios (nome, sobrenome, id_escritorio) 
	VALUES ('Oliver','Stephen', 4);
	
INSERT INTO pagamentos (id_funcionario, salario, data)
	VALUES (1, '4500', '2022-03-15');
INSERT INTO pagamentos (id_funcionario, salario, data)
	VALUES (2, '7500', '2022-03-15');
INSERT INTO pagamentos (id_funcionario, salario, data)
	VALUES (3, '9500', '2022-03-15');
INSERT INTO pagamentos (id_funcionario, salario, data)
	VALUES (4, '22500', '2022-03-15');
	
-- Subconsultas

SELECT nome, sobrenome FROM funcionarios WHERE id_escritorio IN (SELECT id FROM escritorios WHERE pais = 'Brasil');

-- não utilizando as subconsultas:

SELECT nome, sobrenome FROM funcionarios, escritorios AS e WHERE id_escritorio = e.id AND e.pais = 'Brasil';

SELECT f.nome, f.sobrenome, e.pais, p.salario FROM
	pagamentos as P, funcionarios as f, escritorios as e
	WHERE f.id_escritorio = e.id
		AND f.id = p.id_funcionario
		AND salario = (SELECT MAX(salario) FROM pagamentos);
		
SELECT f.nome, f.sobrenome, e.pais, p.salario FROM
	pagamentos as P, funcionarios as f, escritorios as e
	WHERE f.id_escritorio = e.id
		AND f.id = p.id_funcionario
		AND salario < (SELECT AVG(salario) FROM pagamentos);