IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO


CREATE  VIEW gold.fact_sales AS
SELECT 
sd.sls_ord_num AS order_number,
pr.product_key,
cu.customer_key,
sd.sls_order_dt AS order_date,
sd.sls_ship_dt AS ship_date,
sd.sls_due_dt AS due_date,
sd.sls_sales AS sales,
sd.sls_quanytity AS quantity,
sd.sls_price AS price 


FROM silver.crm_sales_details sd
LEFT JOIN  gold.dim_product pr
ON sd.sls_prd_key = pr.product_number
LEFT JOIN  gold.dim_custumer cu
ON sd.sls_cust_id = cu.customer_id