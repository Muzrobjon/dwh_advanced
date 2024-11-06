--sales rankings by product category
SELECT dc.category_name,
    SUM(fs.total_amount) AS total_sales,
    DENSE_RANK() OVER (ORDER BY SUM(fs.total_amount) DESC) AS category_rank -- ranking 
FROM fact_sales fs
JOIN dimproduct dp ON fs.product_id = dp.product_id
JOIN dimcategory dc ON dp.category_id = dc.category_id
GROUP BY dc.category_name
ORDER BY total_sales DESC;
