--Customer Segmentation by Revenue (CTE + CASE)
WITH customer_revenue AS (
    SELECT 
        customer_id,
        customer_name,
        segment,
        ROUND(SUM(sales)::numeric, 2) AS total_sales,
        COUNT(DISTINCT order_id) AS total_orders
    FROM orders
    GROUP BY customer_id, customer_name, segment
),
segmented AS (
    SELECT *,
        CASE 
            WHEN total_sales > 5000 THEN 'High Value'
            WHEN total_sales > 2000 THEN 'Mid Value'
            ELSE 'Low Value'
        END AS value_segment
    FROM customer_revenue
)
SELECT 
    value_segment,
    COUNT(*) AS customer_count,
    ROUND(AVG(total_sales)::numeric, 2) AS avg_revenue,
    ROUND(SUM(total_sales)::numeric, 2) AS total_revenue
FROM segmented
GROUP BY value_segment
ORDER BY avg_revenue DESC;