
CREATE TABLE carp_category (
  id                 INTEGER     NOT NULL,
  description        VARCHAR(255),
  name               VARCHAR(20) NOT NULL,
  parent_category_id INTEGER,
  PRIMARY KEY (id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE carp_product (
  id                 BIGINT      NOT NULL AUTO_INCREMENT,
  long_description   LONGTEXT,
  name               VARCHAR(64) NOT NULL,
  parent_category_id INTEGER,
  short_description  VARCHAR(255),
  PRIMARY KEY (id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE carp_sku (
  id               BIGINT NOT NULL AUTO_INCREMENT,
  list_price       DECIMAL(12, 2),
  on_sale          BIT,
  sale_price       DECIMAL(12, 2),
  sku_name         VARCHAR(64),
  stock_level      INTEGER,
  stock_locked     INTEGER,
  stock_safe_level INTEGER,
  product_id       BIGINT,
  PRIMARY KEY (id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
ALTER TABLE carp_sku
  ADD CONSTRAINT FK_product_id FOREIGN KEY (product_id) REFERENCES carp_product (id);

CREATE TABLE carp_order (
  order_id      BIGINT         NOT NULL,
  customer_id   BIGINT,
  customer_name VARCHAR(20),
  raw_subtotal  DECIMAL(12, 2) NOT NULL,
  raw_total     DECIMAL(12, 2) NOT NULL,
  subtotal      DECIMAL(12, 2) NOT NULL,
  total         DECIMAL(12, 2) NOT NULL,
  PRIMARY KEY (order_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE carp_order_item (
  order_item_id BIGINT         NOT NULL,
  order_id      BIGINT,
  price         DECIMAL(12, 2) NOT NULL,
  product_id    BIGINT         NOT NULL,
  product_name  VARCHAR(64)    NOT NULL,
  quantity      INTEGER        NOT NULL,
  raw_price     DECIMAL(12, 2) NOT NULL,
  raw_subtotal  DECIMAL(12, 2) NOT NULL,
  sku_id        BIGINT,
  sku_name      VARCHAR(64),
  subtotal      DECIMAL(12, 2) NOT NULL,
  PRIMARY KEY (order_item_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
ALTER TABLE carp_order_item
  ADD CONSTRAINT FK_order_id FOREIGN KEY (order_id) REFERENCES carp_order (order_id);
