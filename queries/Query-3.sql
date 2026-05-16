 --Revenue by Category and Sub-Category
SELECT 
    category,
    sub_category,
    ROUND(SUM(sales)::numeric, 2) AS revenue,
    ROUND(SUM(profit)::numeric, 2) AS profit,
    ROUND(SUM(profit)/NULLIF(SUM(sales),0)*100, 2) AS margin_pct
FROM orders
GROUP BY category, sub_category
ORDER BY category, revenue DESC;