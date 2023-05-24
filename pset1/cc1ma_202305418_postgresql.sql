-- Comando para apagar o banco de dados, caso ele já exista na máquina.

DROP DATABASE IF EXISTS uvv;

--Comando para apagar o usuário, caso ele já exista na máquina.

DROP USER IF EXISTS felipe_angelo;

-- Comando para excluir, caso já exista um esquema com o mesmo nome já existir um schema com esse nome ele será apagado e criado um novo.

DROP SCHEMA IF EXISTS lojas CASCADE;

-- Comando para criar um usuário que, posteriormente, será o "dono" do banco de dados.

CREATE USER felipe_angelo 
WITH CREATEDB CREATEROLE
ENCRYPTED PASSWORD '13052101@Angelo';


-- Comando para criar um banco de dados, cujo responsável é o usuário "felipe_angelo".

CREATE DATABASE uvv
OWNER = felipe_angelo
TEMPLATE = template0
ENCODING = 'UTF8'
LC_COLLATE = 'pt_BR.UTF-8'
LC_CTYPE = 'pt_BR.UTF-8'
CONNECTION LIMIT = -1;

-- Comando para adicionar um comentário ao banco de dados, explicando sobre o que ele se trata.

COMMENT ON DATABASE uvv IS 'Banco de dados para tratar de informações sobre a loja UVV e suas franquias';

-- Comando para trocar de usuário, para começar a trabalhar no banco de dados.

\c "host=localhost dbname=uvv user=felipe_angelo password=13052101@Angelo";

-- Comando para criação de um esquema separado, cujo "dono" é felipe_angelo.

CREATE SCHEMA lojas 
AUTHORIZATION felipe_angelo;

-- Comando para comentar sobre o esquema criado.

COMMENT ON SCHEMA lojas IS 'Esquema onde será organizado o banco de dados das lojas UVV';

-- Comando para mostrar em qual esquema está sendo utilizado como padrão.

SELECT CURRENT_SCHEMA();

-- Comando para alterar o esquema em que os dados serão armazenados.

SET SEARCH_PATH TO lojas;

-- Comando para excluir a tabela lojas, caso ela já exista.

DROP TABLE IF EXISTS lojas.lojas;

-- Comando para criar a tabela (entidade) "loja" com informações relevantes sobre as lojas da franquia, além de restringir uma coluna como chave-primária da tabela. 

CREATE TABLE lojas.lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT loja_id PRIMARY KEY (loja_id)
);

-- Comando para fazer comentário sobre a tabela "loja", explicando o que há nela.

COMMENT ON TABLE lojas.lojas IS 'Mostra informações sobre cada loja da franquia';

-- Comando para fazer comentários sobre as colunas da tabela "loja", explicando o que há de informação em cada coluna.

COMMENT ON COLUMN lojas.lojas.loja_id IS 'Identifica cada loja da franquia por um número único';
COMMENT ON COLUMN lojas.lojas.nome IS 'Mostra o nome específico de cada loja da franquia';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'Identifica o endereço do site de cada loja, se houver um site da loja';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'Identifica o endereco fisico da loja, ou seja, em que lugar do mundo real a loja se encontra, se houver uma loja física.';
COMMENT ON COLUMN lojas.lojas.latitude IS 'Mostra a latitude em que a loja se encontra no planeta';
COMMENT ON COLUMN lojas.lojas.longitude IS 'Mostra a longitude em que a loja se encontra no planeta';
COMMENT ON COLUMN lojas.lojas.logo IS 'Mostra o dado binário para gerar a imagem da logo da loja';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'Mostra em qual extensão (ou formato) o arquivo da logo da loja está';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'Identifica o nome do arquivo do logo de cada loja';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'Identifica o conjunto de caracteres usado para codificar o logo da loja';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'Mostra a data em que houve a última alteração na logo da loja';

-- Comando para criar a restrição de, pelo menos, uma coluna de endereço (web ou fisíco) ser preenchida em uma inserção de dados.

ALTER TABLE lojas.lojas
ADD CONSTRAINT verficacao_endereco CHECK (
  (endereco_web IS NOT NULL AND endereco_web != '') OR
  (endereco_fisico IS NOT NULL AND endereco_fisico != '')
);

-- Comando para criar a restrição na coluna de "longitude", sendo apenas válidos valores entre -180 e 180. 

ALTER TABLE lojas.lojas
ADD CONSTRAINT validacao_longitude CHECK (longitude >= -180 AND longitude <= 180);

-- Comando para criar a restrição na coluna de "latitude", sendo apenas válidos valores entre -90 e 90. 

ALTER TABLE lojas.lojas
ADD CONSTRAINT validacao_longitude CHECK (longitude >= -180 AND longitude <= 180);

-- Comando para criar a restrição na coluna de "logo_utilma_atualizacao", sendo apenas válidos datas iguais ou maiores que 01/01/2020. 

ALTER TABLE lojas.lojas
ADD CONSTRAINT validacao_data_logo_ultima_atualizacao CHECK (logo_ultima_atualizacao >= TO_DATE('01-01-2020', 'DD-MM-YYYY'));

-- Comando para excluir a tabela produtos, caso ela já exista.

DROP TABLE IF EXISTS lojas.produtos;

-- Comando para criação da tabela (entidade) "produto" com informações relevantes sobre os produtos vendido pelas lojas da franquia, além de criar uma restrição para que a coluna "produto_id" seja a chave-primária da tabela.

CREATE TABLE lojas.produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT produto_id PRIMARY KEY (produto_id)
);

-- Comando para fazer comentário sobre a tabela "produtos", explicando o que há nela.

COMMENT ON TABLE lojas.produtos IS 'Mostra informações dos produtos vendidos nas lojas';

-- Comando para fazer comentário sobre as colunas da tabela "produto", explicando o que há de informação em cada coluna.

COMMENT ON COLUMN lojas.produtos.produto_id IS 'Identifica o identificador exclusivo de cada tipo de produto';
COMMENT ON COLUMN lojas.produtos.nome IS 'Mostra o nome do produto';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'Mostra por qual preço é vendido uma unidade do produto';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'Mostra alguns detalhes necessários sobre o produto';
COMMENT ON COLUMN lojas.produtos.imagem IS 'Mostra uma sequência binária para gerar uma imagem do produto';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'Identifica o tipo de formato/extensão que a imagem do produto possui';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'Mostra o nome do arquivo da imagem do produto';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'Mostra o conjunto de caracteres usado para codificar a imagem do produto';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'Mostra a data da última modificação feita na imagem do produto';

-- Comando para restringir a coluna "preco_unitario" para que não aceite valores negativos.

ALTER TABLE lojas.produtos
ADD CONSTRAINT validacao_preco_unitario_positivo CHECK (preco_unitario >= 0);

-- Comando para restringir a coluna "imagem_ultima_atualizacao" para que a data minima seja 1/1/2020.

ALTER TABLE lojas.produtos
ADD CONSTRAINT validacao_data_imagem_ultima_atualizacao CHECK (imagem_ultima_atualizacao >= TO_DATE('01-01-2020', 'DD-MM-YYYY'));

-- Comando para excluir a tabela clientes, caso ela já exista.

DROP TABLE IF EXISTS lojas.clientes;


-- Comando para criação da tabela "clientes" com informações relevantes sobre os clientes das lojas, além disso restringe a coluna "cliente_id" como chave-primária da tabela.

CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT cliente_id PRIMARY KEY (cliente_id)
);

-- Comando para adicionar um comemtário na tabela "clientes", explicando o que há nessa tabela.

COMMENT ON TABLE lojas.clientes IS 'Mostra informações de todos os clientes da loja';

-- Comando para adicionar um comentário nas colunas da tabela "clientes", explicando o que há de informação em cada coluna.

COMMENT ON COLUMN lojas.clientes.cliente_id IS 'Mostra o identificador único de cada cliente';
COMMENT ON COLUMN lojas.clientes.email IS 'Mostra qual o email cadastrado pelo cliente para contato';
COMMENT ON COLUMN lojas.clientes.nome IS 'Mostra qual o nome completo do cliente';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'Mostra o primeiro telefone cadastrado pelo cliente para contato';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'Mostra o segundo telefone cadastrado pelo cliente para contato';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'Mostra o terceiro telefone cadastrado pelo cliente para contato';

-- Comando para restringir a coluna "email" para que possua, obrigatoriamente, o caracter especial "@".

ALTER TABLE lojas.clientes
ADD CONSTRAINT verificacao_formato_email CHECK (email LIKE '%@%');

-- Comando para restringir as colunas "telefone1", "telefone2" e "telefone3", para que não aceite os caracteres "-", "(" e ")"

-- Restrição para telefone1
ALTER TABLE lojas.clientes
ADD CONSTRAINT formato_telefone1 CHECK (telefone1 NOT LIKE '%-%' AND telefone1 NOT LIKE '%(%' AND telefone1 NOT LIKE '%)%');

-- Restrição para telefone2
ALTER TABLE lojas.clientes
ADD CONSTRAINT formato_telefone2 CHECK (telefone2 NOT LIKE '%-%' AND telefone2 NOT LIKE '%(%' AND telefone2 NOT LIKE '%)%');

-- Restrição para telefone3
ALTER TABLE lojas.clientes
ADD CONSTRAINT formato_telefone3 CHECK (telefone3 NOT LIKE '%-%' AND telefone3 NOT LIKE '%(%' AND telefone3 NOT LIKE '%)%');


-- Comando para excluir a tabela estoques, caso ela já exista.

DROP TABLE IF EXISTS lojas.estoques;

-- Comando para criação da tabela "estoques" com informações relevantes sobre os estoques de produtos das lojas, além de adicionar a coluna "estoque_id" como chave-primária da tabela.

CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                CONSTRAINT estoque_id PRIMARY KEY (estoque_id)
);

-- Comando para adicionar um comentário à tabela "estoques", explicando o que há nela.

COMMENT ON TABLE lojas.estoques IS 'Mostra o controle de estoque das lojas UVV';

-- Comando para adicionar comentários nas colunas da tabela "estoques", explicando quais tipos de informações há em cada coluna.

COMMENT ON COLUMN lojas.estoques.estoque_id IS 'Mostra o identificador primário de cada estoque';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'Mostra a quantidade de produtos no estoque';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'Identifica cada loja da franquia por um número único de até 38 dígitos';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'Identifica o identificador exclusivo de cada tipo de produto';

-- Comando para criar uma restrição que impede que a coluna "quantidade" aceite valores negativos.

ALTER TABLE lojas.estoques
ADD CONSTRAINT verificacao_quantidade_positivo CHECK (quantidade >= 0);

-- Comando para criar um relacionamento entre as tabelas "estoques" e "produtos", no qual a tabela pai é "produtos" e a tabela filho é "estoques".

ALTER TABLE lojas.estoques ADD CONSTRAINT produto_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Comando para criar um relacionamento entre as tabelas "estoques" e "lojas", no qual a tabela pai é "lojas" e a tabela filho é "estoques".

ALTER TABLE lojas.estoques ADD CONSTRAINT loja_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Comando para excluir a tabela envios, caso ela já exista.

DROP TABLE IF EXISTS lojas.envios;

-- Comando para criação da tabela "envios" com informações relevantes para o processo de envio de mercadorias, além de adicionar a coluna "envio_id" como chave-primária da tabela.

CREATE TABLE lojas.envios (
                envio_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envio_id PRIMARY KEY (envio_id)
);

-- Comando para adicionar um comentário na tabela "envios" para explicar o que há nela.

COMMENT ON TABLE lojas.envios IS 'Mostra informações para o processo de envios do produto';

-- Comando para adicionar comentários nas colunas da tabela "envios", explicando quais tipos de informações há em cada coluna.

COMMENT ON COLUMN lojas.envios.envio_id IS 'Mostra o identificador único de cada envios';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'Mostra o identificador único de cada cliente';
COMMENT ON COLUMN lojas.envios.loja_id IS 'Identifica cada loja da franquia por um número único de até 38 dígitos';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'Mostra para qual endereço o pedido do cliente está sendo levado';
COMMENT ON COLUMN lojas.envios.status IS 'Mostra se o produto está no estado no processo de entrega o produto está';

-- Comando para restringir as opções do status da tabela de "envios".

ALTER TABLE lojas.envios 
ADD CONSTRAINT check_status CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

-- Comando para criar um relacionamento entre as tabelas "envios" e "clientes", no qual a tabela pai é "clientes" e a tabela filho é "envios".

ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envio_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Comando para criar um relacionamento entre as tabelas "envios" e "lojas", no qual a tabela pai é "lojas" e a tabela filho é "envios".

ALTER TABLE lojas.envios ADD CONSTRAINT loja_envio_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Comando para excluir a tabela pedidos, caso ela já exista.

DROP TABLE IF EXISTS lojas.pedidos;

-- Comando para criação da tabela "pedidos" a qual possui informações relevantes sobre os pedidos feitos pelos clientes, além de definir a coluna "pedido_id" como a chave-primária da tabela.

CREATE TABLE lojas.pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                status VARCHAR(15) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_id PRIMARY KEY (pedido_id)
);

-- Comando para restringir as opções do status da tabela de "pedidos".

ALTER TABLE lojas.pedidos
ADD CONSTRAINT valicacao_status_pedidos CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

-- Comando para restringir o formato em que é adicionada a data.

ALTER TABLE lojas.pedidos
ADD CONSTRAINT check_data_hora_format CHECK (TO_CHAR(data_hora, 'DD-MM-YYYY') = TO_CHAR(data_hora, 'DD-MM-YYYY'));

-- Comando para adicionar comentário na tabela "pedidos", explicando o que há nela.

COMMENT ON TABLE lojas.pedidos IS 'Mostra informações sobre os pedidos feitas em cada loja';

-- Comando para adicionar comentários nas colunas da tabela "pedidos", explicando quais informações há em cada coluna.

COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'Mostra o identificador único de cada pedido feito na loja';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'Identifica em que dia e hora o clientes fez o pedido do produto';
COMMENT ON COLUMN lojas.pedidos.status IS 'Mostra se o produto está no estado de produção, envios ou se já foi entregue ao cliente';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'Mostra o identificador único de cada cliente';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'Identifica cada loja da franquia por um número único';

-- Comando para criar um relacionamento entre as tabelas "pedidos" e "clientes", no qual a tabela pai é "clientes" e a tabela filho é "pedidos".

ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Comando para criar um relacionamento entre as tabelas "pedidos" e "lojas", no qual a tabela pai é "lojas" e a tabela filho é "pedidos". 

ALTER TABLE lojas.pedidos ADD CONSTRAINT loja_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Comando para excluir a tabela pedidos_itens, caso ela já exista.

DROP TABLE IF EXISTS lojas.pedidos_itens;

-- Comando para criação da tabela "pedidos_itens", a qual possui informações relevanes sobre os itens de uma ordem do cliente. 

CREATE TABLE lojas.pedidos_itens (
                produto_id NUMERIC(38) NOT NULL,
                pedido_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38) NOT NULL,
                CONSTRAINT fk_pedido_id__fk_produto_id PRIMARY KEY (produto_id, pedido_id)
);

-- Comando para adicionar comentários na tabela, explicando sobre quais são as informações dela.

COMMENT ON TABLE lojas.pedidos_itens IS 'Mostra quais produtos foram requistidos por cada ordem de pedido';

-- Comando para adicionar comentários nas colunas da tabela, explicando quais são as informações em cada coluna.

COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'Identifica o identificador exclusivo de cada tipo de produto';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'Mostra o identificador único de cada pedido feito na loja';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS '?????';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'Mostra o preço pago pelo cliente ao comprar cada unidade dos produtos na ordem';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'Mostra a quantidade de unidades pedida pelo cliente em sua ordem';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'Mostra o identificador único de cada envios';

-- Comando para restringir a coluna "preco_unitario" para que não aceite valores negativos.

ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT validacao_preco_unitario_positivo CHECK (preco_unitario >= 0);

-- Comando para restringir a coluna "quantidade" para que não aceite valores negativos.

ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT validacao_quantidade_positiva CHECK (quantidade >= 0);

-- Comando para criar um relacionamento entre as tabelas "pedidos_itens" e "produtos", no qual a tabela filho é "pedidos_itens" e a tabela pai é "produtos".

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produto_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Comando para criar um relacionamento entre as tabelas "pedidos_itens" e "envios", no qual a tabela filho é "pedidos_itens" e a tabela pai é "envios".

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Comando para criar um relacionamento entre as tabelas "pedidos_itens" e "pedidos", no qual a tabela pai é "pedidos" e a tabela pai é "pedidos_itens".

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;





