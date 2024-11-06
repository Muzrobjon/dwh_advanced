SELECT 
    EXTRACT(YEAR FROM dd.date) AS year,
    EXTRACT(WEEK FROM dd.date) AS week,
    EXTRACT(MONTH FROM dd.date) AS month,
    dp.product_name,
    SUM(fs.total_amount) AS total_sales,
    SUM(fs.quantity_sold) AS total_items_sold
FROM fact_sales fs
JOIN dimdate dd ON fs.date_id = dd.date_id
JOIN dimproduct dp ON fs.product_id = dp.product_id
WHERE dd.date BETWEEN '2012-01-01' AND '2012-12-31'  -- specify the year period
GROUP BY EXTRACT(YEAR FROM dd.date), EXTRACT(WEEK FROM dd.date), EXTRACT(MONTH FROM dd.date), dp.product_name
ORDER BY year, month, week, dp.product_name;
