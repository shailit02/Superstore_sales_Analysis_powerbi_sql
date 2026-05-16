--Cohort Retention Analysis (CTE + FIRST_VALUE)
WITH cohort AS (
    SELECT 
        customer_id,
        DATE_TRUNC('month', MIN(order_date)) AS cohort_month
    FROM orders
    GROUP BY customer_id
),
activity AS (
    SELECT 
        o.customer_id,
        c.cohort_month,
        DATE_TRUNC('month', o.order_date) AS order_month,
        EXTRACT(YEAR FROM AGE(
            DATE_TRUNC('month', o.order_date), 
            c.cohort_month)) * 12 +
        EXTRACT(MONTH FROM AGE(
            DATE_TRUNC('month', o.order_date), 
            c.cohort_month)) AS month_number
    FROM orders o
    JOIN cohort c USING (customer_id)
)
SELECT 
    cohort_month,
    month_number,
    COUNT(DISTINCT customer_id) AS active_customers,
    ROUND(COUNT(DISTINCT customer_id) * 100.0 /
          FIRST_VALUE(COUNT(DISTINCT customer_id)) OVER (
              PARTITION BY cohort_month 
              ORDER BY month_number
          ), 2) AS retention_rate
FROM activity
GROUP BY cohort_month, month_number
ORDER BY cohort_month, month_number;