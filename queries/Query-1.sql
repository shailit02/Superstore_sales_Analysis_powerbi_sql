--Total Revenue by Region
SELECT 
    region,
    ROUND(SUM(sales)::numeric, 2) AS total_revenue,
    ROUND(SUM(profit)::numeric, 2) AS total_profit
FROM orders
GROUP BY region
ORDER BY total_revenue DESC;