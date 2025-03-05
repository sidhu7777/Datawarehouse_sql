--Check the Null values or dulicates
--Expected :no results


SELECT
cst_id,
COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*)> 1 OR cst_id IS NULL


--CHECK THE UNWANTED SPACES

SELECT cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM (cst_firstname)

--DATA STANDARDIZATION & CONSISTENCY 
SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info

SELECT * FROM silver.crm_cust_info