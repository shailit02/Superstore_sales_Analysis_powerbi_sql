--Discount Impact on Profit (CASE + GROUP BY)
SELECT 
    CASE 
        WHEN discount = 0    THEN '0 - No Discount'
        WHEN discount <= 0.1 THEN '1 - Low (1-10%)'
        WHEN discount <= 0.2 THEN '2 - Medium (11-20%)'
        ELSE                      '3 - High (21%+)'
    END AS discount_tier,
    COUNT(*) AS order_count,
    ROUND(AVG(sales)::numeric, 2) AS avg_revenue,
    ROUND(AVG(profit)::numeric, 2) AS avg_profit,
    ROUND(SUM(profit)/NULLIF(SUM(sales),0)*100, 2) AS margin_pct
FROM orders
GROUP BY discount_tier
ORDER BY discount_tier;