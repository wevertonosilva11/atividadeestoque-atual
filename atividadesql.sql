CREATE DATABASE estoque;

USE estoque;

CREATE TABLE fornecedores(
id_fornecedor INT PRIMARY KEY IDENTITY(1,1),
razao_social VARCHAR(100) NOT NULL,
cnpj CHAR(18) UNIQUE,
email VARCHAR(100) UNIQUE,
telefone VARCHAR(20)
);

CREATE TABLE categorias(
id_categoria INT PRIMARY KEY IDENTITY(1,1),
nome_categoria VARCHAR(50) UNIQUE
);

CREATE TABLE produtos(
id_produto  INT PRIMARY KEY IDENTITY(1,1),
nome_produto VARCHAR(100),
codigo_barras VARCHAR(30) UNIQUE,
preco DECIMAL(10,2),
quantidade_estoque INT,
id_categoria INT,
id_fornecedor INT
FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria),
FOREIGN KEY (id_fornecedor) REFERENCES fornecedores (id_fornecedor),
);

CREATE TABLE Funcionarios(
id_funcionario INT PRIMARY KEY IDENTITY(1,1),
nome VARCHAR(100) NOT NULL,
cpf CHAR(14) UNIQUE,
email VARCHAR(100) UNIQUE
);

CREATE TABLE Movimentacoes(
id_movimentacao INT PRIMARY KEY IDENTITY(1,1),
id_produto INT,
id_funcionario INT,
tipo_movimentacao VARCHAR(10),
quantidade INT NOT NULL,
data_movimentacao DATE ,
FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto),
FOREIGN KEY (id_funcionario) REFERENCES Funcionarios (id_funcionario),
CHECK (tipo_movimentacao IN ('ENTRADA', 'SAIDA'))
); 

select * from Funcionarios

CREATE TABLE pedidosCompras(
id_pedido  INT PRIMARY KEY IDENTITY(1,1),
id_fornecedor INT,
data_pedido DATE,
valor_total DECIMAL(10,2),
FOREIGN KEY (id_fornecedor) REFERENCES Fornecedores(id_fornecedor),
CHECK(valor_total>0)
);

CREATE TABLE itensPedido(
id_item INT PRIMARY KEY IDENTITY(1,1),
id_pedido INT,
quantidade INT,
id_produto INT,
valor_unitario DECIMAL(10,2),
FOREIGN KEY (id_pedido) REFERENCES pedidosCompras(id_pedido),
FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto),
CHECK (quantidade >0)
);