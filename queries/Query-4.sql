--Rank Customers by Revenue (DENSE_RANK)
SELECT 
    customer_name,
    segment,
    region,
    ROUND(SUM(sales)::numeric, 2) AS total_sales,
    DENSE_RANK() OVER (ORDER BY SUM(sales) DESC) AS revenue_rank
FROM orders
GROUP BY customer_name, segment, region
ORDER BY revenue_rank
LIMIT 20;