--Display the top (worst) five customers by number of transactions and purchase amount 
WITH CustomerSales AS (
    SELECT 
        dc.customer_id,
        COUNT(fs.sales_id) AS transaction_count,
        SUM(fs.total_amount) AS total_purchase_amount,
        dc.region,
        dc.country,
        dct.category_name
    FROM fact_sales fs
    JOIN dimcustomer dc ON fs.customer_id = dc.customer_id
    JOIN dimcategory dct ON fs.category_id = dct.category_id
    GROUP BY dc.customer_id, dc.region, dc.country, dct.category_name

)

SELECT 
    customer_id,
    transaction_count,
    total_purchase_amount,
    region,
    country,
    category_name
FROM CustomerSales
ORDER BY transaction_count DESC, total_purchase_amount DESC
LIMIT 5;
