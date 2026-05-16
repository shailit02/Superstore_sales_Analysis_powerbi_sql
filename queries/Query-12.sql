-- Pareto 80/20 Analysis (Cumulative SUM OVER)
WITH customer_revenue AS (
    SELECT 
        customer_id,
        customer_name,
        ROUND(SUM(sales)::numeric, 2) AS total_revenue
    FROM orders
    GROUP BY customer_id, customer_name
),
ranked AS (
    SELECT *,
        SUM(total_revenue) OVER (ORDER BY total_revenue DESC) AS cumulative_revenue,
        SUM(total_revenue) OVER () AS grand_total
    FROM customer_revenue
)
SELECT 
    customer_id,
    customer_name,
    total_revenue,
    ROUND(cumulative_revenue / grand_total * 100, 2) AS cumulative_pct,
    CASE 
        WHEN cumulative_revenue / grand_total <= 0.8 
        THEN 'Top 80%' 
        ELSE 'Bottom 20%' 
    END AS pareto_group
FROM ranked
ORDER BY total_revenue DESC;