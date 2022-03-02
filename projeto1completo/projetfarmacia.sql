USE farmacia;
# DML
-- Insercao de dados nas tabelas 
 
INSERT INTO tipos_produtos (tipo) VALUES ('Remédios');
INSERT INTO tipos_produtos (tipo) VALUES ('Cosméticos');
INSERT INTO tipos_produtos (tipo) VALUES ('Diversos');

INSERT INTO fabricantes (fabricante) VALUES ('Roche');
INSERT INTO fabricantes (fabricante) VALUES ('P&G');
INSERT INTO fabricantes (fabricante) VALUES ('Palmolive');

INSERT INTO medicos (nome, crm) VALUES ('Alfredo Muniz', '1231333SP');
INSERT INTO medicos (nome, crm) VALUES ('Killiam Mbappe', '3334177RJ');
INSERT INTO medicos (nome, crm) VALUES ('Ronaldo Cristiano', '7770777SP');

INSERT INTO clientes (nome, endereco, telefone, cep, localidade, cpf) VALUES ('Josue Joao','Rua Calada, 12','9998-4444','59000-000','São Paulo','123.444.999-44');
INSERT INTO clientes (nome, endereco, telefone, cep, localidade, cpf) VALUES ('Carlos Maneco','Rua do Barulho, 412','9338-4234','59321-040','Rio de Janeiro','134.111.329-12');
INSERT INTO clientes (nome, endereco, telefone, cep, localidade, cpf) VALUES ('Rosa Carla','Rua dos Navios, 981','9777-4424','59090-100','Bahia','393.987.123-45');

INSERT INTO produtos (produto, designacao, composicao, preco_venda, id_tipo_produto, id_fabricante)
	VALUES ('Dipirona', 'Dores em geral', 'Doriles Cabera', '12.00', 1, 1);
INSERT INTO produtos (produto, designacao, composicao, preco_venda, id_tipo_produto, id_fabricante)
	VALUES ('Shampoo anti-caspa', 'Shampoo para caspas', 'Cristianis Eliminator', '22.00', 2, 2);
INSERT INTO produtos (produto, designacao, composicao, preco_venda, id_tipo_produto, id_fabricante)
	VALUES ('Protetor Solar', 'Protetor Solar', 'Soro de abacate', '92.00', 2, 1);

INSERT INTO compras (id_cliente, data) VALUES (1, '2021-09-13');
INSERT INTO compras (id_cliente, data) VALUES (2, '2021-12-22');
INSERT INTO compras (id_cliente, data) VALUES (1, CURDATE());

INSERT INTO produtos_compra (id_compra, id_produto, quantidade) VALUES (1, 1, 2);
INSERT INTO produtos_compra (id_compra, id_produto, quantidade) VALUES (1, 2, 3);
INSERT INTO produtos_compra (id_compra, id_produto, quantidade) VALUES (2, 3, 1);

INSERT INTO receitas_medica (id_produto_compra, id_medico, receita) VALUES (1, 1, 'receita1.pdf');
INSERT INTO receitas_medica (id_produto_compra, id_medico, receita) VALUES (3, 3, 'receita2.pdf');


# Consultas simples

SELECT * FROM tipos_produtos;
SELECT * FROM tipos_produtos ORDER BY id DESC;

SELECT * FROM fabricantes;

SELECT * FROM medicos;

SELECT * FROM clientes;
SELECT * FROM clientes ORDER BY id DESC;

SELECT * FROM compras;

SELECT * FROM produtos_compra;
SELECT * FROM produtos_compra WHERE quantidade > 1;

SELECT * FROM receitas_medica;

# Consultas complexas

SELECT * FROM compras;

SELECT com. id, cli.nome, com.data FROM compras AS com, clientes AS cli WHERE com.id_cliente = cli.id;

SELECT * FROM produtos_compra;

SELECT proc.id as 'Prod. Compra',
	com.id as 'Compra',
	prod.produto as 'produto',
	prod.preco_venda as 'Preco',
	proc.quantidade as 'Quantidade', (prod.preco_venda * proc.quantidade) AS 'Valor total'
    FROM produtos_compra AS proc, compras AS com, produtos AS prod
    WHERE com.id = proc.id_compra AND prod.id = proc.id_produto;
    
SELECT com.id as 'Venda',
	cli.nome as 'Cliente',
	prod.preco_venda as 'Preco',
	(prod.preco_venda * proc.quantidade) AS 'Valor total'
    FROM produtos_compra AS proc, compras AS com, produtos AS prod, clientes as cli
    WHERE com.id = proc.id_compra AND prod.id = proc.id_produto AND cli.id = com.id_cliente;
    
SELECT com.id as 'Venda',
	cli.nome as 'Cliente',
	prod.preco_venda as 'Preco',
	(prod.preco_venda * proc.quantidade) AS 'Valor total',
    com.data as 'Data da compra'
    FROM produtos_compra AS proc, compras AS com, produtos AS prod, clientes as cli
    WHERE com.id = proc.id_compra AND prod.id = proc.id_produto AND cli.id = com.id_cliente;

SELECT com.id as 'Venda',
	cli.nome as 'Cliente',
	SUM(prod.preco_venda * proc.quantidade) AS 'Valor total',
    com.data as 'Data da compra'
    FROM produtos_compra AS proc, compras AS com, produtos AS prod, clientes as cli
    WHERE com.id = proc.id_compra AND prod.id = proc.id_produto AND cli.id = com.id_cliente
    GROUP BY com.id;
    
# Atualizando dados

INSERT INTO tipos_produtos (tipo) VALUES ('Outros');
SELECT * FROM tipos_produtos;
UPDATE tipos_produtos SET tipo = 'Bijouteria' WHERE id = 4;

SELECT * FROM produtos;

UPDATE produtos SET preco_venda = '9.99' WHERE id = 1;
UPDATE produtos SET composicao = 'Cabecetes Doriles Plus' WHERE id = 1;
UPDATE produtos SET designacao = 'Protetor Solar Facial', composicao = 'Queratina e Arginina', preco_venda = '99.90' WHERE id = 3;

SELECT * FROM produtos_compra;

UPDATE produtos_compra SET quantidade = '4' WHERE id = 1;
UPDATE produtos_compra SET quantidade = '2' WHERE id = 3;

# Excluindo dados

SELECT * FROM tipos_produtos;

DELETE FROM tipos_produtos WHERE id = 4;

SELECT * FROM receitas_medica;

DELETE FROM receitas_medica WHERE id_produto_compra = 3;

SELECT * FROM produtos_compra;

DELETE FROM produtos_compra WHERE id = 3;