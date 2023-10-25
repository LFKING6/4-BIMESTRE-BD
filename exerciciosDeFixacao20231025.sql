CREATE DATABASE exercicios_trigger;
USE exercicios_trigger;

-- Criação das tabelas
CREATE TABLE Clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE Auditoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    mensagem TEXT NOT NULL,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    estoque INT NOT NULL
);

CREATE TABLE Pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT,
    quantidade INT NOT NULL,
    FOREIGN KEY (produto_id) REFERENCES Produtos(id)
);

CREATE TRIGGER inserir_cliente 
ON Clientes
AFTER INSERT 
AS
BEGIN
    INSERT INTO Auditoria(data_hora)
    VALUES ('06/12/2023 12:00')
END;

CREATE TRIGGER deletar_cliente
BEFORE DELETE
ON Clientes FOR EACH ROW
BEGIN
    INSERT INTO Audiotoria
    VALUES CONCAT('Uma tentativa de exclusão foi feita!')
END

CREATE TRIGGER atualizar_cliente
AFTER UPDATE 
ON Clientes FOR EACH ROW
BEGIN
    IF velho.nome <> novo.nome THEN
        INSERT INTO Auditoria
        VALUES CONCAT(velho.nome, novo.nome);
END

