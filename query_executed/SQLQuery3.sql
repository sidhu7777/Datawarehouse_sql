USE DataWarehouse;
GO

CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
    DECLARE @start_time DATETIME,@end_time DATETIME,@batch_start_time DATETIME,@batch_end_time DATETIME;
	
	BEGIN TRY
	        SET @batch_start_time = GETDATE();
			PRINT '=============================================';
			PRINT 'LOADING THE BRONZE LAYER';
			PRINT '=============================================';
			PRINT '---------------------------------------------';
			PRINT 'LOADING THE CRM TABLES';
			PRINT '---------------------------------------------';

			SET @start_time = GETDATE();

			PRINT 'TRUNCATING  THE TABLE :bronze.crm_cust_info';

			TRUNCATE TABLE bronze.crm_cust_info;
			PRINT 'BULK INSERTING  THE DATA INTO :bronze.crm_cust_info';

			BULK INSERT bronze.crm_cust_info
			FROM 'C:\Users\91832\Desktop\Sql_project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
			WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK

			);
			SET @end_time = GETDATE();

			PRINT 'LOAD DURATION:' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
			PRINT '----------------------------------------';

			SET @start_time = GETDATE();

			PRINT 'TRUNCATING  THE TABLE :bronze.crm_prd_info';

			TRUNCATE TABLE bronze.crm_prd_info;

			PRINT 'BULK INSERTING  THE DATA INTO :bronze.crm_prd_info';


			BULK INSERT bronze.crm_prd_info
			FROM 'C:\Users\91832\Desktop\Sql_project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
			WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK

			);

			SET @end_time = GETDATE();

			PRINT 'LOAD DURATION:' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
			PRINT '----------------------------------------';

			SET @start_time = GETDATE();

			PRINT 'TRUNCATING  THE TABLE :bronze.crm_sales_details';

			TRUNCATE TABLE bronze.crm_sales_details;

			PRINT 'BULK INSERTING  THE DATA INTO :bronze.crm_sales_details';

			BULK INSERT bronze.crm_sales_details
			FROM 'C:\Users\91832\Desktop\Sql_project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
			WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK

			);
			SET @end_time = GETDATE();

			PRINT 'LOAD DURATION:' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
			PRINT '----------------------------------------';


			PRINT '---------------------------------------------';
			PRINT 'LOADING THE ERP TABLES';
			PRINT '---------------------------------------------';

			SET @start_time = GETDATE();

			PRINT 'TRUNCATING  THE TABLE :bronze.erp_cust_az12';

			TRUNCATE TABLE bronze.erp_cust_az12;

			PRINT 'BULK INSERTING  THE DATA INTO :bronze.erp_cust_az12';
    
			BULK INSERT bronze.erp_cust_az12
			FROM 'C:\Users\91832\Desktop\Sql_project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
			WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK

			);

			SET @end_time = GETDATE();

			PRINT 'LOAD DURATION:' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
			PRINT '----------------------------------------';

			SET @start_time = GETDATE();

			PRINT 'TRUNCATING  THE TABLE :bronze.erp_loc_a101';
			TRUNCATE TABLE bronze.erp_loc_a101;
			PRINT 'BULK INSERTING  THE DATA INTO :bronze.erp_loc_a101';
			BULK INSERT bronze.erp_loc_a101
			FROM 'C:\Users\91832\Desktop\Sql_project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
			WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK

			);

			SET @end_time = GETDATE();

			PRINT 'LOAD DURATION:' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
			PRINT '----------------------------------------';

			SET @start_time = GETDATE();

			PRINT 'TRUNCATING  THE TABLE :bronze.erp_px_cat_g1v2';

			TRUNCATE TABLE bronze.erp_px_cat_g1v2;

			PRINT 'BULK INSERTING  THE DATA INTO :bronze.erp_px_cat_g1v2';

			BULK INSERT bronze.erp_px_cat_g1v2
			FROM 'C:\Users\91832\Desktop\Sql_project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
			WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK

			);
			SET @end_time = GETDATE();

			PRINT 'LOAD DURATION:' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
			PRINT '----------------------------------------';


			SET @batch_end_time = GETDATE();
			PRINT '=============================';
			PRINT 'BRONZE LAYER LOADING COMPLETED';
			PRINT ' - TOTAL LOAD DURATION :' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'seconds';
			PRINT '=============================';
		   END TRY
		   BEGIN CATCH 
			   PRINT '================================';
			   PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
			   PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
			   PRINT 'ERROR MESSAGE' + CAST (ERROR_NUMBER() AS NVARCHAR);
			   PRINT 'ERROR MESSAGE' + CAST (ERROR_STATE() AS NVARCHAR);
			   PRINT '================================';
		   END CATCH
END


 