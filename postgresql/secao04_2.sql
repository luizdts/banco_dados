-- Criando usuário
CREATE USER estagiario WITH PASSWORD '123456';

CREATE TABLE empresas(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	funcionarios INT NOT NULL,
	cidade VARCHAR(50) NOT NULL
);

-- Concedendo privilégios ao user

GRANT ALL ON empresas TO estagiario;

GRANT USAGE, SELECT ON SEQUENCE empresas_id_seq TO estagiario;

-- As permissões adicionadas ao estagiário funcionaram.

-- Removendo permissões

REVOKE ALL ON empresas FROM estagiario;

-- Adicionando permissões básicas ao estagiário

GRANT SELECT ON empresas TO estagiario;

-- Removendo usuário

DROP USER estagiario;

REVOKE USAGE, SELECT ON SEQUENCE empresas_id_seq FROM estagiario;

-- DTL

SELECT * FROM tipos_produto;
SELECT * FROM produtos;

INSERT INTO tipos_produto (descricao) VALUES ('Impressora');
INSERT INTO tipos_produto (descricao) VALUES ('Notebook');

INSERT INTO produtos (descricao, preco, codigo_tipo) VALUES ('Impr. Jato de Tinta', 500, 3);

BEGIN TRANSACTION;

INSERT INTO tipos_produto (descricao) VALUES ('Nobreak');

COMMIT;

SELECT * FROM tipos_produto;

BEGIN TRANSACTION;

INSERT INTO tipos_produto (descricao) VALUES ('Mouse');

ROLLBACK;
