--Top 3 Customers per Region (ROW_NUMBER)
WITH ranked AS (
    SELECT 
        customer_name,
        region,
        ROUND(SUM(sales)::numeric, 2) AS total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY region 
            ORDER BY SUM(sales) DESC
        ) AS rn
    FROM orders
    GROUP BY customer_name, region
)
SELECT * FROM ranked
WHERE rn <= 3
ORDER BY region, rn;