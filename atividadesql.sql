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

INSERT INTO Fornecedores VALUES
('Tech Distribuidora Ltda','11.111.111/0001-11','contato@tech.com','(11)99999-1111'),
('Alfa Comércio Ltda','22.222.222/0001-22','vendas@alfa.com','(21)98888-2222'),
('Mega Suprimentos','33.333.333/0001-33','atendimento@mega.com','(31)97777-3333');

INSERT INTO Categorias VALUES
('Informática'),
('Periféricos'),
('Escritório'),
('Acessórios');

INSERT INTO Produtos VALUES
('Notebook Dell','789100000001',4500.00,15,1,1),
('Mouse Logitech','789100000002',120.00,80,2,2),
('Teclado Mecânico','789100000003',350.00,40,2,2),
('Monitor LG 24','789100000004',950.00,25,1,1),
('Cadeira Escritório','789100000005',680.00,12,3,3),
('Webcam Full HD','789100000006',250.00,30,4,3),
('Headset Gamer','789100000007',320.00,20,4,2),
('Impressora HP','789100000008',890.00,10,3,1);

INSERT INTO Funcionarios VALUES
('Carlos Silva','111.111.111-11','carlos@empresa.com'),
('Ana Souza','222.222.222-22','ana@empresa.com'),
('Marcos Lima','333.333.333-33','marcos@empresa.com');

INSERT INTO Movimentacoes VALUES
(1,1,'ENTRADA',5,'2025-05-01'),
(2,2,'SAIDA',10,'2025-05-02'),
(3,1,'ENTRADA',15,'2025-05-03'),
(4,3,'SAIDA',2,'2025-05-04'),
(5,2,'ENTRADA',8,'2025-05-05'),
(6,1,'SAIDA',4,'2025-05-06'),
(7,3,'ENTRADA',6,'2025-05-07'),
(8,2,'SAIDA',1,'2025-05-08'),
(2,1,'ENTRADA',20,'2025-05-09'),
(1,3,'SAIDA',3,'2025-05-10');


ALTER TABLE Produtos
ADD produto_vendido INT;

select * from produtos;

EXEC sp_rename 'produtos.produto_vendido',
'vendido',
'COLUMN';

ALTER TABLE Produtos
ALTER COLUMN Vendido VARCHAR(10);
