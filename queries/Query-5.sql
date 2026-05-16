--Running Total of Sales by Date
WITH daily_sales AS (
    SELECT 
        order_date,
        ROUND(SUM(sales)::numeric, 2) AS daily_revenue
    FROM orders
    GROUP BY order_date
)
SELECT 
    order_date,
    daily_revenue,
    ROUND(SUM(daily_revenue) OVER (
        ORDER BY order_date
    )::numeric, 2) AS running_total
FROM daily_sales
ORDER BY order_date;