IF OBJECT_ID('gold.dim_product', 'V') IS NOT NULL
    DROP VIEW gold.dim_product;
GO

CREATE VIEW gold.dim_product AS
SELECT 
      ROW_NUMBER() OVER(ORDER BY pn.prd_start_dt, pn.prd_key ) AS product_key,
      pn.prd_id AS product_id,
	  pn.prd_key AS product_number,
	  pn.prd_nm AS product_name,
	  pn.cat_id AS categort_id,
	  pc.cat AS category,
	  pc.subcat AS subcategory,
	  pc.maintenance,
	  pn.prd_cost AS cost,
	  pn.prd_line AS product_line,
	  pn.prd_start_dt AS start_date
	 
      

FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
ON     pn.cat_id=pc.id
WHERE prd_end_dt IS NULL -- Filter all historical data
