-- Top (worst) five products by number of transactions, total sales, and tax
SELECT 
    dp.product_name,
    COUNT(fs.sales_id) AS transaction_count,
    SUM(fs.total_amount) AS total_sales,
    SUM(fs.tax_amount) AS total_tax,
    dc.category_name
FROM 
    fact_sales fs
    JOIN dimproduct dp ON fs.product_id = dp.product_id
    JOIN dimcategory dc ON dp.category_id = dc.category_id
GROUP BY 
    dp.product_name, dc.category_name
ORDER BY 
    transaction_count ASC, total_sales ASC, total_tax ASC
LIMIT 5;
