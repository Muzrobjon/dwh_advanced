--Display a sales chart (with the total amount of sales and the quantity of items sold)
-- for the first week of each month. This involves querying the FactSales and DimDate tables.
SELECT 
    EXTRACT(YEAR FROM dd.date) AS year,
    EXTRACT(MONTH FROM dd.date) AS month,
    SUM(fs.total_amount) AS total_sales,
    SUM(fs.quantity_sold) AS total_items_sold
FROM fact_sales fs
JOIN dimdate dd ON fs.date_id = dd.date_id
WHERE EXTRACT(DAY FROM dd.date) BETWEEN 1 AND 7
GROUP BY EXTRACT(YEAR FROM dd.date), EXTRACT(MONTH FROM dd.date)
ORDER BY year, month;
