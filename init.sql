-- Create-tables script for quick_postgresql

CREATE TYPE producttype AS ENUM ('bubble', 'trouble', 'crap');


CREATE TABLE products(
    prodid              BIGSERIAL PRIMARY KEY,
    entrytime           TIMESTAMP DEFAULT current_timestamp,
    prodname            TEXT,
    description         TEXT,
    prodtype            producttype,
    mrsp                REAL,
    note                TEXT,
    tags                JSONB
);
COMMENT ON TABLE products IS 'A product is an item manufactured for sale.';


CREATE TABLE customers(
    custid              BIGSERIAL PRIMARY KEY,
    entrytime           TIMESTAMP DEFAULT current_timestamp,
    custbusinessname    TEXT,
    custbusinessaddr    TEXT,
    custbusinesscity    TEXT,
    custbusinessstate   TEXT,
    custbusinesszip     TEXT,
    poc_prefix          TEXT,
    poc_firstname       TEXT,
    poc_lastname        TEXT,
    poc_email           TEXT,
    poc_phonenum        TEXT,
    purchasedprev       BOOLEAN,
    note                TEXT,
    tags                JSONB
);
COMMENT ON TABLE customers IS 'A customer is a business contact who has purchased a product.';


CREATE TABLE businesses(
    busid               BIGSERIAL PRIMARY KEY,
    entrytime           TIMESTAMP DEFAULT current_timestamp,
    businessname        TEXT,
    businessaddr        TEXT,
    businesscity        TEXT,
    businessstate       TEXT,
    businesszip         TEXT,
    poc_prefix          TEXT,
    poc_firstname       TEXT,
    poc_lastname        TEXT,
    poc_email           TEXT,
    poc_phonenum        TEXT,
    note                TEXT,
    tags                JSONB
);
COMMENT ON TABLE businesses IS 'A business is a seller of products to customers.';


CREATE TABLE sales(
    saleid              BIGSERIAL PRIMARY KEY,
    entrytime           TIMESTAMP DEFAULT current_timestamp,
    prodid              INTEGER REFERENCES products(prodid),
    busid               INTEGER REFERENCES businesses(busid),
    custid              INTEGER REFERENCES customers(custid),
    saledate            TIMESTAMP,
    itemprice           REAL,
    quantity            INTEGER,
    note                TEXT,
    tags                JSONB
);
COMMENT ON TABLE sales IS 'A sale records a customer buying product(s) from a business.';


CREATE TABLE audits(
    auditid             BIGSERIAL PRIMARY KEY,
    entrytime           TIMESTAMP DEFAULT current_timestamp,
    auditdate           TIMESTAMP,
    audbusinessname     TEXT,
    audbusinessaddr     TEXT,
    audbusinesscity     TEXT,
    audbusinessstate    TEXT,
    audbusinesszip      TEXT,
    poc_prefix          TEXT,
    poc_firstname       TEXT,
    poc_lastname        TEXT,
    poc_email           TEXT,
    poc_phonenum        TEXT,
    note                TEXT,
    tags                JSONB
);
COMMENT ON TABLE audits IS 'An audit is an evaluation of a collection of sales.';


CREATE TABLE sale_audits(
    auditid             INTEGER REFERENCES audits(auditid),
    saleid              INTEGER REFERENCES sales(saleid),
    entrytime           TIMESTAMP DEFAULT current_timestamp,
    note                TEXT,
    tags                JSONB
);
COMMENT ON TABLE sale_audits IS 'A sales-audit connects a sale to an audit in many to many relationship.';
