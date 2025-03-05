USE DataWarehouse;
GO

INSERT INTO silver.crm_prd_info(
prd_id,
cat_id,
prd_key,
prd_nm,
prd_cost,
prd_line,
prd_start_dt,
prd_end_dt


)

SELECT 
prd_id,
REPLACE(SUBSTRING(prd_key, 1, 5), '-' ,'_') AS cat_id,
SUBSTRING(prd_key, 7, len(prd_key)) AS prd_key,
prd_nm,
ISNULL(prd_cost,0) AS prd_cost,

CASE UPPER(TRIM(prd_line))
     WHEN  'M' THEN 'MOUNTAIN'
     WHEN  'R' THEN 'ROAD'
	 WHEN  'S' THEN 'OTHER SALES'
	 WHEN  'T' THEN 'TOURING'
	 ELSE 'N/A'
END prd_line,
CAST (prd_start_dt AS DATE) AS prd_start_dt,
CAST (LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS DATE) AS prd_end_dt


FROM bronze.crm_prd_info



