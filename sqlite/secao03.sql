
INSERT INTO tipos_produtos (descricao) VALUES ('Diversos');

INSERT INTO produtos (descricao, preco, id_tipo_produto)
	VALUES ('Notebook Dell 1544', 2000, 1);
INSERT INTO produtos (descricao, preco, id_tipo_produto)
	VALUES ('Impr. Jato de Tinta', 400, 2);
INSERT INTO produtos (descricao, preco, id_tipo_produto)
	VALUES ('Mouse sem fio', 40, 3);

INSERT INTO pacientes (nome, endereco, bairro, cidade, estado,
	cep, data_nascimento)
		VALUES ('Angelina', 'Rua de cima, 42', 'Nova Lima', 'Nova cidade',
		'SP', '122345-003' ,'1989-09-12');
		
INSERT INTO professor (nome, telefone) 
	VALUES ('Jose Carlo', '1111-4421');

INSERT INTO turma (capacidade, id_professor)
	VALUES ('35', 1);

	
SELECT * FROM tipos_produtos;

SELECT * FROM turma;

SELECT * FROM pacientes;

SELECT * FROM professor;

SELECT * FROM produtos;

