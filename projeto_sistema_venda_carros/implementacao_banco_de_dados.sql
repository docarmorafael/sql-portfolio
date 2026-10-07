-- Etapa DDL (Data Definition Language):
-- Aplicação do comando 'CREATE DATABASE' na criação do novo banco de dados chamado 'Sistema de Venda de Carros'.
-- Aplicação do comando 'CREATE TABLE' na criação das tabelas 'veiculos', 'clientes', 'vendedores' e 'vendas'.
-- Bem como, criação das colunas e definição dos tipos de dados que serão suportados por elas.
CREATE DATABASE sistema_venda_carros;

CREATE TABLE veiculos (
id_veiculo INT PRIMARY KEY,
modelo TEXT,
marca TEXT,
ano INT,
preco DECIMAL (10,2)
);

CREATE TABLE clientes (
id_cliente INT PRIMARY KEY,
nome VARCHAR(100),
telefone VARCHAR(20)
);

CREATE TABLE vendedores (
id_vendedor INT PRIMARY KEY,
nome TEXT,
comissao DECIMAL (5,2)
);

CREATE TABLE vendas (
id_venda INT PRIMARY KEY,
data_venda DATE,
valor_final DECIMAL (10,2),

-- Chaves estrangeiras que, por meio das chaves primárias, estabelecem conexão entre a tabela 'vendas' e as tabelas 'veiculos', 'clientes' e 'vendedores'.
id_veiculo INT,
FOREIGN KEY (id_veiculo) REFERENCES veiculos(id_veiculo),
id_cliente INT,
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
id_vendedor INT,
FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor)
);

-- Etapa DML (Data Manipulation Language):
-- Aplicação do comando 'INSERT' na inserção dos dados nas colunas das tabelas 'veiculos', 'clientes', 'vendedores' e 'vendas'.
INSERT INTO veiculos VALUES (1, 'Corolla', 'Toyota', 2022, 95000);
INSERT INTO veiculos VALUES (2, 'Civic', 'Honda', 2023, 105000);
INSERT INTO veiculos VALUES (3, 'Onix', 'Chevrolet', 2021, 75000);

-- Alteração posterior da tabela 'veiculos' por meio do comando 'ALTER TABLE', adicionando a coluna 'cor' e atualizando os dados por meio do comando 'UPDATE'.
ALTER TABLE veiculos
ADD cor VARCHAR(10);
UPDATE veiculos SET cor = 'Preto' WHERE id_veiculo = 1;
UPDATE veiculos SET cor = 'Branco' WHERE id_veiculo = 2;
UPDATE veiculos SET cor = 'Prata' WHERE id_veiculo = 3;

INSERT INTO clientes VALUES (1, 'Carlos Silva', '61988887777');
INSERT INTO clientes VALUES (2, 'Ana Souza', '61999996666');
INSERT INTO clientes VALUES (3, 'João Pereira', '61888885555');

-- Atualização do número do telefone do cliente identificado pela chave primária 3 por meio do comando 'UPDATE'.
UPDATE clientes SET telefone = '61777774444' WHERE id_cliente = 3;

INSERT INTO vendedores VALUES (1, 'Fernando Lima', 0.05);
INSERT INTO vendedores VALUES (2, 'Roberto Carlos', 0.04);

INSERT INTO vendas VALUES (1, '2025-05-20', 93000, 1, 1, 1);
INSERT INTO vendas VALUES (2, '2025-05-22', 102000, 2, 2, 2);
INSERT INTO vendas VALUES (3, '2025-05-23', 74000, 3, 3, 1);

-- Remoção da linha da tabela 'vendas' identificada pela chave primária 3.
DELETE FROM vendas WHERE id_venda = 3;

-- Etapa DQL (Data Query Language):
-- Consulta dos dados presentes nas tabelas informadas por meio do comando 'SELECT'.
-- Utilizando o método 'INNER JOIN' que faz uma junção interna entre as colunas de fora da tabela selecionada em 'FROM' por meio das chaves estrangeiras.
SELECT vendas.data_venda,
vendas.valor_final,
vendedores.nome AS vendedor,
clientes.nome AS cliente,
veiculos.modelo AS modelo,
veiculos.marca AS marca
FROM vendas
INNER JOIN vendedores ON vendedores.id_vendedor = vendas.id_vendedor
INNER JOIN clientes ON clientes.id_cliente = vendas.id_cliente
INNER JOIN veiculos ON veiculos.id_veiculo = vendas.id_veiculo;