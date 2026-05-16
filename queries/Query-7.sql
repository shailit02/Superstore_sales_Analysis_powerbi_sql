--Year over Year Revenue by Region (LAG + PARTITION)
WITH yearly AS (
    SELECT 
        region,
        EXTRACT(YEAR FROM order_date) AS year,
        ROUND(SUM(sales)::numeric, 2) AS revenue
    FROM orders
    GROUP BY region, year
)
SELECT 
    region,
    year,
    revenue,
    LAG(revenue) OVER (PARTITION BY region ORDER BY year) AS prev_year,
    ROUND((revenue - LAG(revenue) OVER (PARTITION BY region ORDER BY year)) /
          NULLIF(LAG(revenue) OVER (PARTITION BY region ORDER BY year), 0) * 100, 2) AS yoy_growth_pct
FROM yearly
ORDER BY region, year;