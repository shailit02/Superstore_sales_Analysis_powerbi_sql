--Top 10 Most Profitable Products
SELECT 
    product_name,
    category,
    ROUND(SUM(sales)::numeric, 2) AS total_sales,
    ROUND(SUM(profit)::numeric, 2) AS total_profit
FROM orders
GROUP BY product_name, category
ORDER BY total_profit DESC
LIMIT 10;