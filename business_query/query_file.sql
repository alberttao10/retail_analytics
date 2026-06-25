-- Business Question: Which stores generate the most revenue?
SELECT store_name, SUM(sale)
FROM edw_silver.transactions
GROUP BY store_name
ORDER BY SUM(sale) DESC;

-- Insight:
-- Walmart dominates in sheer sales revenue by a large margin and then warehouse club retail (top 3), followed by pharmacy-grocery stores.

-- Q1. Find the total sales (FINAL_SALE) for each store and rank stores from highest to lowest revenue.

SELECT store_name,
       SUM(CAST(sale AS DECIMAL)) AS total_sales
FROM edw_silver.transactions
WHERE sale IS NOT NULL
GROUP BY store_name
ORDER BY total_sales DESC;


-- Q2. Which top 5 product CATEGORY_1 groups generate the most revenue? Sort by highest revenue.

SELECT p.category_main,
       SUM(CAST(t.sale AS DECIMAL)) AS total_revenue
FROM edw_silver.transactions t
         JOIN edw_silver.products p
              ON t.barcode = p.barcode
WHERE t.sale IS NOT NULL
GROUP BY p.category_main
ORDER BY total_revenue DESC
LIMIT 5;

-- Q3. What is the average total spend per user?

SELECT
    AVG(user_total) AS avg_spend_per_user
FROM (
    SELECT
        user_id,
        SUM(CAST(sale AS DECIMAL)) AS user_total
    FROM edw_silver.transactions
    WHERE sale IS NOT NULL
    GROUP BY user_id
) sub;


-- Q4. Which states generate the highest total sales?

SELECT
    u.state,
    SUM(CAST(t.sale AS DECIMAL)) AS total_sales
FROM edw_silver.transactions t
JOIN edw_silver.users u
    ON t.user_id = u.id
WHERE t.sale IS NOT NULL
GROUP BY u.state
ORDER BY total_sales DESC;


-- Q5. Find the top 10 most popular brands by total quantity sold.

SELECT
    p.brand,
    SUM(CAST(t.quantity AS DECIMAL)) AS total_quantity
FROM edw_silver.transactions t
JOIN edw_silver.products p
    ON t.barcode = p.barcode
WHERE t.quantity IS NOT NULL
GROUP BY p.brand
ORDER BY total_quantity DESC
LIMIT 10;


-- Q6. What percentage of users made more than one purchase? (repeat customer rate)

SELECT
    COUNT(CASE WHEN purchase_count > 1 THEN 1 END) * 100.0 / COUNT(*)
        AS repeat_customer_percentage
FROM (
    SELECT
        user_id,
        COUNT(DISTINCT receipt_id) AS purchase_count
    FROM edw_silver.transactions t
    GROUP BY user_id
) sub;


-- Q7. What are the stores ranked by revenue?

SELECT
    store_name,
    SUM(sale) AS revenue,
    RANK() OVER (ORDER BY SUM(sale) DESC) AS rank
FROM edw_silver.transactions
GROUP BY store_name;