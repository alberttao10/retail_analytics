## overwrite tables
DROP TABLE IF EXISTS edw_gold.store_revenue;
DROP TABLE IF EXISTS edw_gold.top_categories;

## store revenue
CREATE TABLE edw_gold.store_revenue AS
SELECT
    store_name,
    SUM(sale) AS total_revenue
FROM edw_silver.transactions
GROUP BY store_name
ORDER BY SUM(sale) DESC
LIMIT 10;


## top categories
CREATE TABLE edw_gold.top_categories AS
SELECT
    p.category_main,
    SUM(t.sale) AS revenue
FROM edw_silver.transactions t
JOIN edw_silver.products p
    ON t.barcode = p.barcode
GROUP BY p.category_main
ORDER BY revenue DESC;


-- ## write to csv, not available in datagrip
-- COPY edw_gold.store_revenue
-- TO LOCAL '/data_insights/store_revenue.csv'
-- WITH (FORMAT CSV, HEADER);
