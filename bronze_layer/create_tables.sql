select current_database() ;

-- create schemas
create schema edw_bronze ;
create schema edw_silver ;
create schema edw_gold ;

-- create tables
-- transactions table
CREATE TABLE edw_bronze.transactions (
    receipt_id TEXT,
    purchase_date DATE,
    scan_date TIMESTAMP,
    store_name TEXT,
    user_id TEXT,
    barcode TEXT,
    final_quantity TEXT,
    final_sale TEXT
);


-- products table
CREATE TABLE edw_bronze.products (
    category_1 TEXT,
    category_2 TEXT,
    category_3 TEXT,
    category_4 TEXT,
    manufacturer TEXT,
    brand TEXT,
    barcode TEXT PRIMARY KEY
);


-- users table
CREATE TABLE edw_bronze.users (
    id TEXT PRIMARY KEY,
    created_date TIMESTAMP,
    birth_date DATE,
    state TEXT,
    language TEXT,
    gender TEXT
);
