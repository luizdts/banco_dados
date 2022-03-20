/*

// Criando BD Mongo

use meubanco // SEMPRE SELECIONE O BANCO ANTES DE COMEÇAR A TRABALHAR

// Inserindo dados em uma coleção

db.meubanco.insert(
    {
        "Valor": "Valor"
    }
)

Buscando dados em uma coleção

db.meubanco.find(
    {
        "Dado": "dado"
    }
)

db.meubanco.find(
    {
        "Dado": "dado"
    }
).pretty()


Operadores $or e $in

db.inscricoes.find(
    {
        $or: [
            {"curso.nome": "Data Science"},
            {"curso.nome": "JavaScript"}
        ]
    }
)

db.inscricoes.find(
    {
        "skills.nome": "Python",
        "skills.nivel": {
            $in : ["Avançado", "Intermediário"]
        }
    }
)

-- Atualizando Dados

db.inscricoes.insert(
    {
        "aluno": "Guilherme Dantas",
        "data": new Date(),
        "curso": {
            "nome": "Programação para internet"
        },
        "notas": [7, 8.5, 10]
    }
)

db.inscricoes.insert(
    {
        "aluno": "Angela Souza",
        "data": new Date(),
        "curso": {
            "nome": "Programação para Internet"
        },
        "notas": [7.4, 9.5, 9.4]
    }
)

db.inscricoes.find(
    {
        "curso.nome": "Programação para Internet"
    }
)

// O Update deve receber dois parâmetros
// O primeiro localiza o dado que deve ser alterado
// O segundo é o dado já corrigido

// Ele irá atualizar apenas o primeiro documento que contenha os dados incorretos
// Caso haja mais de um, deve-se colocar os dados novamente

db.inscricoes.update(
        {"curso.nome": "Programação para internet"},
        {
            $set: {
                "curso.nome": "Programação para Internet"
            }
        }
)

// Deletando dados

db.inscricoes.remove(
    {
        "_id": ObjectId("62363d58388cd426fa1a2fa6")
    }
)

// Inserindo

db.inscricoes.insert(
    {
        "aluno": "William Douglas",
        "data": new Date(),
        "curso": {
            "nome": "Programação para internet"
        },
        "notas": [6.4, 3.5, 6.4]
    }
)

// Atualizando múltiplos documentos

db.inscricoes.update(
        {"curso.nome": "Programação para internet"},
        {
            $set: {
                "curso.nome": "Programação para Internet"
            }
        },
        {
            multi: true
        }
)

o $set vai procurar o campo especificado e irá alterá-lo

- Atualizando as notas

db.inscricoes.update(
    {
        "_id" : ObjectId("62365426388cd426fa1a2faf")
    },
    {
    $push: { -- adiciona apenas um dado por vez
        notas: 6.7
    }
}
)

-- removendo um dado para corrigir o erro
db.inscricoes.remove(
    {
        "_id": ObjectId("62365197388cd426fa1a2fae")
    }
)

-- Adicionando novas notas a um dado já existente
-- para adicionar mais de um valor utilizamos $each junto ao $push

db.inscricoes.update(
    {
        "_id": ObjectId("6236501b388cd426fa1a2fad")
    },
    {
        $push: {
            notas: {
                $each: [9.5, 4.2]
            }
        }
    }
)

-- Filtrando dados de uma coleção com valores maiores que o
especificado

Operador: $gt => greater than

db.inscricoes.find(
    {
        "notas": {
            $gt: 8.0
        }
    }
)

Operador $gte => greater than or equal

db.inscricoes.find(
    {
        "notas": {
            $gte: 8.0
        }
    }
)

db.inscricoes.insert(
    {
        "aluno": "Jair Rodrigues",
        "data_nascimento": new Date(1981, 06, 19),
        "curso": {
            "nome": "História"
        },
        "notas": [6, 7, 8, 5.5]
    }
)

db.inscricoes.insert(
    {
        "aluno": "Bruna Marques",
        "data_nascimento": new Date(1995, 02, 16),
        "curso": {
            "nome": "História"
        },
        "notas": [10, 9.7, 9.2, 9.0]
    }
)

db.inscricoes.findOne({
    "notas": { $gt: 7.0 }
}
)

-- Fazendo a busca por ordem alfabética

db.inscricoes.find().sort({"aluno": 1}).pretty()


-- limitando à 3 resultados 

db.inscricoes.find().sort({"aluno": 1}).limit(3).pretty()

-- Busca por localização geográfica

Quando trabalhamos com coordenadas geográficas com MongoDB
precisamos ter um campo chamado 'coordinates' e especificar o
'type'

db.inscricoes.update(
    {"_id" : ObjectId("62365426388cd426fa1a2faf")},
    {
        $set: {
            "localizacao" : {
                "endereco": "Rua alternativa, 1223",
                "coordinates": [-20.388008, -54.577545],
                "type": "Point"
            }
        }
    }

)

Como importar dados para o banco de dados MongoDB

mongoimport -d meubanco -c inscricoes --jsonArray < inscricoes.json

meubanco é o banco de dados, incricoes é a coleção para onde queremos
importar os dados e inscricoes.json é a base de dados a ser importada.

// utilizando recursos avançados para buscar dados por localização

db.inscricoes.createIndex(
    {
        "localizacao": "2dsphere"
    }
)

// consulta utilizando agregação
$skip : permite pular um dado

db.inscricoes.aggregate( -- não há nenhuma alteração na estrutura da tabela
    [
        {
            $geoNear: {
                "near": {
                    "coordinates": [-20.388008, -54.577546],
                    "type": "Point"
                },
                "distanceField": "distancia.calculada",
                "spherical": true
            
            }
        },
        {
            $skip: 1
        }
    ]
)
*/
