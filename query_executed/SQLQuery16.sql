USE DataWarehouse
GO

IF OBJECT_ID('gold.dim_custumer', 'V') IS NOT NULL
    DROP VIEW gold.dim_custumer;
GO


CREATE VIEW gold.dim_custumer AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,
	ci.cst_id AS customer_id,
	ci.cst_key AS customer_number,
	ci.cst_firstname AS firstname,
	ci.cst_lastname AS lastname,
	la.cntry AS country,
	ci.cst_material_status AS marital_status,
	CASE WHEN ci.cst_gndr !=  'N/A' THEN ci.cst_gndr  --CRM isthe master for the gender 
	     ELSE COALESCE(ca.gen, 'N/A')
    END AS gender,
	ca.bdate AS birthdate,
	ci.cst_create_date AS create_date
	
	



FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca 
ON     ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101  la
ON     ci.cst_key = la.cid