-- DROP SCHEMA `trabalho_dsw2015` ;

-- CREATE SCHEMA IF NOT EXISTS `trabalho_dsw2015` ;

USE trabalho_dsw2015;

DROP TABLE IF EXISTS item_carrinho CASCADE;
DROP TABLE IF EXISTS carrinho CASCADE;
DROP TABLE IF EXISTS produto CASCADE;
DROP TABLE IF EXISTS comprador CASCADE;


CREATE TABLE comprador (
	id int not null AUTO_INCREMENT, 
	nome_usuario varchar(100) NOT NULL, 
	senha varchar(20) NOT NULL,
	PRIMARY KEY(id)
);


CREATE TABLE produto (
	id int not null AUTO_INCREMENT, 
	nome varchar(100) NOT NULL, 
	categoria varchar(200) not null,
	valor decimal(8, 2) NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE carrinho (
	id int not null AUTO_INCREMENT, 
	comprador_id int not null, 
    data_compra datetime,
	valor_total decimal(8, 2) NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE item_carrinho (
	id int not null AUTO_INCREMENT, 
	carrinho_id int not null, 
	produto_id int not null,
	quantidade int,
    valor decimal(8,2),
	PRIMARY KEY(id)
);

ALTER TABLE carrinho ADD CONSTRAINT carrinho_usuario FOREIGN KEY (comprador_id) REFERENCES comprador(id);

ALTER TABLE item_carrinho ADD CONSTRAINT item_carrinho_carrinho FOREIGN KEY (carrinho_id) REFERENCES carrinho(id);
ALTER TABLE item_carrinho ADD CONSTRAINT item_carrinho_produto FOREIGN KEY (produto_id) REFERENCES produto(id);


insert into produto (nome, categoria, valor) values ('Iogurte', 'Lácteos', 1.25);
insert into produto (nome, categoria, valor) values ('Leite', 'Lácteos', 2.75);
insert into produto (nome, categoria, valor) values ('Torradas', 'Pães', 1.05);
insert into produto (nome, categoria, valor) values ('Croissant', 'Pães', 3.75);

insert into comprador(nome_usuario, senha) values ('professor', 'professor');
insert into comprador(nome_usuario, senha) values ('wendell', 'wendell');
insert into comprador(nome_usuario, senha) values ('cliente', 'cliente');

