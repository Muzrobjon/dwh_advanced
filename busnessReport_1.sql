WITH MonthlySales AS (
    SELECT 
        dd.date,
        EXTRACT(YEAR FROM dd.date) AS year,
        EXTRACT(MONTH FROM dd.date) AS month,
        SUM(fs.total_amount) AS total_sales,
        SUM(fs.tax_amount) AS total_tax,
        COUNT(fs.sales_id) AS transaction_count
    FROM 
        fact_sales fs
        JOIN dimdate dd ON fs.date_id = dd.date_id
    GROUP BY 
        dd.date, EXTRACT(YEAR FROM dd.date), EXTRACT(MONTH FROM dd.date)
),
RollingAverage AS (
    -- calculate the rolling average for sales, tax, and transaction count over a 3-month period
    SELECT 
        year, 
        month,
        total_sales, 
        total_tax, 
        transaction_count,
        ROUND(AVG(total_sales) OVER (PARTITION BY year ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS rolling_avg_sales,
        ROUND(AVG(total_tax) OVER (PARTITION BY year ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS rolling_avg_tax,
        ROUND(AVG(transaction_count) OVER (PARTITION BY year ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS rolling_avg_transactions
    FROM 
        MonthlySales
)
SELECT 
    year,
    month,
    total_sales, 
    total_tax, 
    transaction_count,
    rolling_avg_sales, 
    rolling_avg_tax, 
    rolling_avg_transactions
FROM 
    RollingAverage
WHERE 
    year = 2012 -- specify the year range
ORDER BY 
    year, month;
