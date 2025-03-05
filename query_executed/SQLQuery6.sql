--Check the Null values or dulicates
--Expected :no results


SELECT
cst_id,
COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*)> 1 OR cst_id IS NULL


--CHECK THE UNWANTED SPACES

SELECT prd_nm
FROM bronze.crm_prd_info
WHERE prd_nm != TRIM (prd_nm)

--check the null or negative values

SELECT prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NUll


--DATA STANDARDIZATION & CONSISTENCY 
SELECT DISTINCT prd_line
FROM bronze.crm_prd_info

--check for the invalid data order
SELECT *
FROM bronze.crm_prd_info
WHERE prd_end_df < prd_start_dt
USE DataWarehouse;
GO

-- we are sorting the date order issue for start and end 
SELECT 
prd_id,
prd_key,
prd_nm,
prd_cost,
prd_start_dt,
prd_end_df,
LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS prd_end_df_test
FROM bronze.crm_prd_info
WHERE prd_key IN ('AC-HE-HL-U509-R','AC-HE-HL-U509')


--check the invalid  date in sales.crm 

SELECT 
NULLIF(sls_due_dt,0) sls_due_dt
FROM bronze.crm_sales_details
WHERE sls_due_dt<=0 OR LEN(sls_due_dt) != 8

-- check the sls_sales column 
SELECT 
sls_sales 
 
FROM  bronze.crm_sales_details
WHERE sls_sales <=0

--Fro the sls_sales, sls_quantity, sls_price we are apply bussiness rules like sales= quantity * price 
--After verifying the columns sales and price has negative and nan values 
--  now we are modifying the sales  column as if there is zero or negative values use the formula and replace with correct values othewise retrun the actual value
-- now for the price it there is zero or negative values or not correct values replace with sales / nullif (quantity ,0) values to correct the values .
USE DataWarehouse
GO

SELECT DISTINCT
sls_sales AS old_sls_sales,
sls_quanytity,
sls_price AS old_sls_price,

CASE WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quanytity *ABS(sls_price)
     THEN sls_quanytity *ABS(sls_price)
   ELSE sls_sales
END AS sls_sales,

CASE WHEN sls_price IS NULL OR sls_price <= 0
     THEN sls_sales / NULLIF(sls_quanytity, 0)
	 ELSE sls_price
END AS sls_price

FROM bronze.crm_sales_details

WHERE sls_sales != sls_quanytity * sls_price
OR sls_sales IS NULL  OR sls_quanytity IS NULL OR sls_price IS NULL 
OR sls_sales <= 0 OR sls_quanytity <= 0 OR sls_price<= 0

