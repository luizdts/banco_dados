import socket
import couchdb
import couchdb.http


def conectar():
    """
    Função para conectar ao servidor
    """
    user = 'admin'
    password = 'admin'
    conn = couchdb.Server(f'http://{user}:{password}@localhost:5984')

    banco = 'pcouchdb'

    if banco in conn:
        db = conn[banco]
        return db
    else:
        try:
            db = conn.create(banco)
        except socket.gaierror as e:
            print(f'Erro ao conectar ao servidor.')

        except couchdb.http.Unauthorized as f:
            print(f'Você não têm permissão de acesso. {f}')

        except ConnectionRefusedError as g:
            print(f'Não foi possível conectar ao servidor: {g}')


def desconectar():
    """ 
    Função para desconectar do servidor.
    """
    print('Desconectando do servidor...')


def listar():
    """
    Função para listar os produtos
    """
    db = conectar()

    if db:
        if db.info()['doc_count'] > 0:
            print('Listando produtos')
            print('-----------------')
            for doc in db:
                print(f"ID: {db[doc]['_id']}")
                print(f"Rev: {db[doc]['_rev']}")
                print(f"Nome: {db[doc]['nome']}")
                print(f"Preço: {db[doc]['preco']}")
                print(f"Estoque: {db[doc]['estoque']}")
                print('--------------------------')

        else:
            print('Não existem produtos cadastrados.')
    else:
        print('Não foi possível se conectar ao servidor.')


def inserir():
    """
    Função para inserir um produto
    """  
    db = conectar()

    if db:
        nome = input('Informe o nome do produto: ')
        preco = float(input('Informe o preço do produto: '))
        estoque = int(input('Informe o estoque do produto: '))

        produto = {"nome": nome, "preco": preco, "estoque": estoque}

        res = db.save(produto)

        if res:
            print(f'O produto {nome} foi inserido com sucesso.')
        else:
            print('O produto não foi salvo.')
    else:
        print('Não foi possível se conectar ao servidor.')


def atualizar():
    """
    Função para atualizar um produto
    """
    db = conectar()

    if db:
        chave = input('Informe o id do produto: ')

        try:
            doc = db[chave]

            nome = input('Informe o nome do produto: ')
            preco = float(input('Informe o preço: '))
            estoque = int(input('Informe o estoque: '))

            doc['nome'] = nome
            doc['preco'] = preco
            doc['estoque'] = estoque
            db[doc.id] = doc
            print('O produto foi atualizado com sucesso.')

        except couchdb.http.ResourceNotFound as e:
            print(f'Produto não encontrado.')
    else:
        print('Não foi possível se conectar ao servidor.')


def deletar():
    """
    Função para deletar um produto
    """  
    db = conectar()

    if db:
        _id = input('Informe o ID do produto: ')

        try:
            db.delete(db[_id])
            print('Produto deletado com sucesso.')
        except couchdb.http.ResourceNotFound as e:
            print(f'Não foi possível deletar o produto: {e}')

    else:
        print('Não foi possível se conectar ao servidor.')


def menu():
    """
    Função para gerar o menu inicial
    """
    print('=========Gerenciamento de Produtos==============')
    print('Selecione uma opção: ')
    print('1 - Listar produtos.')
    print('2 - Inserir produtos.')
    print('3 - Atualizar produto.')
    print('4 - Deletar produto.')
    opcao = int(input())
    if opcao in [1, 2, 3, 4]:
        if opcao == 1:
            listar()
        elif opcao == 2:
            inserir()
        elif opcao == 3:
            atualizar()
        elif opcao == 4:
            deletar()
        else:
            print('Opção inválida')
    else:
        print('Opção inválida')
