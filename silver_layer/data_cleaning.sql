-- SILVER TABLES
DROP VIEW IF EXISTS edw_silver.transactions;
DROP VIEW IF EXISTS edw_silver.products;
DROP VIEW IF EXISTS edw_silver.users;

-- transactions
CREATE VIEW
    edw_silver.transactions AS
SELECT receipt_id,
       purchase_date,
       store_name,
       user_id,
       barcode,
       CASE
           WHEN final_quantity = 'zero' THEN 0
           ELSE CAST(final_quantity AS NUMERIC)
           END AS quantity,
       CASE
           WHEN final_sale IS NULL OR final_sale = ' ' THEN 0
           ELSE CAST(final_sale AS NUMERIC)
           END AS sale
FROM edw_bronze.transactions;

-- products
CREATE VIEW edw_silver.products AS
SELECT COALESCE(category_1, 'Other')   AS category_main,
       COALESCE(category_2, 'Other')   AS category_sub,
       COALESCE(category_3, 'Other')   AS category_product,
       COALESCE(category_4, 'Other')   AS product_name,
       COALESCE(manufacturer, 'Other') AS manufacturer,
       COALESCE(brand, 'Other')        AS brand,
       barcode
FROM edw_bronze.products;

-- users
CREATE VIEW edw_silver.users AS
SELECT
FROM edw_bronze.users;


-- save
COMMIT;