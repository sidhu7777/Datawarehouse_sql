USE DataWarehouse
GO

INSERT INTO silver.crm_cust_info(
      cst_id,
      cst_key,
	  cst_firstname,
	  cst_lastname,
	  cst_material_status,
	  cst_gndr,
	  cst_create_date
)
SELECT
cst_id,
cst_key,
TRIM(cst_firstname) AS cst_firstname,
TRIM(cst_lastname) AS cst_lastname,

CASE WHEN UPPER(TRIM(cst_material_status)) = 'S' THEN 'SINGLE'
     WHEN UPPER(TRIM(cst_material_status)) = 'M' THEN 'MARRIED'
	 ELSE 'N/A'
END cst_material_status,


CASE WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'FEMALE'
     WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'MALE'
	 ELSE 'N/A'
END cst_gndr,


cst_create_date

FROM (
	SELECT *,
	ROW_NUMBER() OVER  (PARTITION BY cst_id ORDER BY  cst_create_date DESC) as flag_name
	FROM bronze.crm_cust_info
	WHERE cst_id IS NOT NULL
	)t WHERE flag_name = 1 

