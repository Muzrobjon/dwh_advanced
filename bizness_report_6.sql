WITH MonthlySales AS (
    SELECT 
        EXTRACT(YEAR FROM dd.date) AS year,
        EXTRACT(MONTH FROM dd.date) AS month,
        dc.country,
        dp.product_name,
        SUM(fs.total_amount) AS total_sales
    FROM fact_sales fs
    JOIN dimdate dd ON fs.date_id = dd.date_id
    JOIN dimproduct dp ON fs.product_id = dp.product_id
    JOIN dimcustomer dc ON fs.customer_id = dc.customer_id
    GROUP BY EXTRACT(YEAR FROM dd.date), EXTRACT(MONTH FROM dd.date), dc.country, dp.product_name
)
SELECT 
    year,
    month,
    country,
    product_name,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total_sales) AS median_sales
FROM MonthlySales
GROUP BY year, month, country, product_name
ORDER BY year, month, country, product_name;

