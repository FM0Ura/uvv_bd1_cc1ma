
CREATE TABLE lojas.produto (
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
COMMENT ON TABLE lojas.produto IS 'Mostra informações dos produtos vendidos nas lojas';
COMMENT ON COLUMN lojas.produto.produto_id IS 'Identifica o identificador exclusivo de cada tipo de produto';
COMMENT ON COLUMN lojas.produto.nome IS 'Mostra o nome do produto';
COMMENT ON COLUMN lojas.produto.preco_unitario IS 'Mostra por qual preço é vendido uma unidade do produto';
COMMENT ON COLUMN lojas.produto.detalhes IS 'Mostra alguns detalhes necessários sobre o produto';
COMMENT ON COLUMN lojas.produto.imagem IS 'Mostra uma sequência binária para gerar uma imagem do produto';
COMMENT ON COLUMN lojas.produto.imagem_mime_type IS 'Identifica o tipo de formato/extensão que a imagem do produto possui';
COMMENT ON COLUMN lojas.produto.imagem_arquivo IS 'Mostra o nome do arquivo da imagem do produto';
COMMENT ON COLUMN lojas.produto.imagem_charset IS 'Mostra o conjunto de caracteres usado para codificar a imagem do produto';
COMMENT ON COLUMN lojas.produto.imagem_ultima_atualizacao IS 'Mostra a data da última modificação feita na imagem do produto';


CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT cliente_id PRIMARY KEY (cliente_id)
);
COMMENT ON TABLE lojas.clientes IS 'Mostra informações de todos os clientes da loja';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'Mostra o identificador único de cada cliente';
COMMENT ON COLUMN lojas.clientes.email IS 'Mostra qual o email cadastrado pelo cliente para contato';
COMMENT ON COLUMN lojas.clientes.nome IS 'Mostra qual o nome completo do cliente';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'Mostra o primeiro telefone cadastrado pelo cliente para contato';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'Mostra o segundo telefone cadastrado pelo cliente para contato';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'Mostra o terceiro telefone cadastrado pelo cliente para contato';


CREATE TABLE lojas.loja (
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
COMMENT ON TABLE lojas.loja IS 'Mostra informações sobre cada loja da franquia';
COMMENT ON COLUMN lojas.loja.loja_id IS 'Identifica cada loja da franquia por um número único';
COMMENT ON COLUMN lojas.loja.nome IS 'Mostra o nome específico de cada loja da franquia';
COMMENT ON COLUMN lojas.loja.endereco_web IS 'Identifica o endereço do site de cada loja, se houver um site da loja';
COMMENT ON COLUMN lojas.loja.endereco_fisico IS 'Identifica o endereco fisico da loja, ou seja, em que lugar do mundo real a loja se encontra, se houver uma loja física.';
COMMENT ON COLUMN lojas.loja.latitude IS 'Mostra a latitude em que a loja se encontra no planeta';
COMMENT ON COLUMN lojas.loja.longitude IS 'Mostra a longitude em que a loja se encontra no planeta';
COMMENT ON COLUMN lojas.loja.logo IS 'Mostra o dado binário para gerar a imagem da logo da loja';
COMMENT ON COLUMN lojas.loja.logo_mime_type IS 'Mostra em qual extensão (ou formato) o arquivo da logo da loja está';
COMMENT ON COLUMN lojas.loja.logo_arquivo IS 'Identifica o nome do arquivo do logo de cada loja';
COMMENT ON COLUMN lojas.loja.logo_charset IS 'Identifica o conjunto de caracteres usado para codificar o logo da loja';
COMMENT ON COLUMN lojas.loja.logo_ultima_atualizacao IS 'Mostra a data em que houve a última alteração na logo da loja';


CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                CONSTRAINT estoque_id PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE lojas.estoques IS 'Mostra o controle de estoque das lojas UVV';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'Mostra o identificador primário de cada estoque';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'Mostra a quantidade de produtos no estoque';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'Identifica cada loja da franquia por um número único de até 38 dígitos';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'Identifica o identificador exclusivo de cada tipo de produto';


CREATE TABLE lojas.envio (
                envio_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envio_id PRIMARY KEY (envio_id)
);
COMMENT ON TABLE lojas.envio IS 'Mostra informações para o processo de envio do produto';
COMMENT ON COLUMN lojas.envio.envio_id IS 'Mostra o identificador único de cada envio';
COMMENT ON COLUMN lojas.envio.cliente_id IS 'Mostra o identificador único de cada cliente';
COMMENT ON COLUMN lojas.envio.loja_id IS 'Identifica cada loja da franquia por um número único de até 38 dígitos';
COMMENT ON COLUMN lojas.envio.endereco_entrega IS 'Mostra para qual endereço o pedido do cliente está sendo levado';
COMMENT ON COLUMN lojas.envio.status IS 'Mostra se o produto está no estado no processo de entrega o produto está';


CREATE TABLE lojas.pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                status VARCHAR(15) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_id PRIMARY KEY (pedido_id)
);
COMMENT ON TABLE lojas.pedidos IS 'Mostra informações sobre os pedidos feitas em cada loja';
COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'Mostra o identificador único de cada pedido feito na loja';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'Identifica em que dia e hora o clientes fez o pedido do produto';
COMMENT ON COLUMN lojas.pedidos.status IS 'Mostra se o produto está no estado de produção, envio ou se já foi entregue ao cliente';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'Mostra o identificador único de cada cliente';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'Identifica cada loja da franquia por um número único';


CREATE TABLE lojas.pedidos_itens (
                produto_id NUMERIC(38) NOT NULL,
                pedido_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38) NOT NULL,
                CONSTRAINT fk_pedido_id__fk_produto_id PRIMARY KEY (produto_id, pedido_id)
);
COMMENT ON TABLE lojas.pedidos_itens IS 'Mostra quais produtos foram requistidos por cada ordem de pedido';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'Identifica o identificador exclusivo de cada tipo de produto';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'Mostra o identificador único de cada pedido feito na loja';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS '?????';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'Mostra o preço pago pelo cliente ao comprar cada unidade dos produtos na ordem';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'Mostra a quantidade de unidades pedida pelo cliente em sua ordem';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'Mostra o identificador único de cada envio';


ALTER TABLE lojas.estoques ADD CONSTRAINT produto_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produto (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produto_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produto (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envio ADD CONSTRAINT clientes_envio_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT loja_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.loja (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envio ADD CONSTRAINT loja_envio_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.loja (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques ADD CONSTRAINT loja_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.loja (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envio_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envio (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
