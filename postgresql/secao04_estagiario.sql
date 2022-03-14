INSERT INTO empresas (nome, funcionarios, cidade) VALUES ('Apple', 4500, 'Cupertino');
INSERT INTO empresas (nome, funcionarios, cidade) VALUES ('Microsoft', 24500, 'Palo Alto');
INSERT INTO empresas (nome, funcionarios, cidade) VALUES ('Amazon', 5000, 'Santos');

SELECT * FROM empresas;

UPDATE empresas SET funcionarios = 1500 WHERE id = 3;

DELETE FROM empresas WHERE id = 3;

