--Month over Month Revenue Growth (LAG)
WITH monthly AS (
    SELECT 
        DATE_TRUNC('month', order_date) AS month,
        ROUND(SUM(sales)::numeric, 2) AS revenue
    FROM orders
    GROUP BY month
)
SELECT 
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS prev_month_revenue,
    ROUND((revenue - LAG(revenue) OVER (ORDER BY month)) /
          NULLIF(LAG(revenue) OVER (ORDER BY month), 0) * 100, 2) AS mom_growth_pct
FROM monthly
ORDER BY month;