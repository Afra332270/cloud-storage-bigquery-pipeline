--  Creating a bigquery table called 'superstore_native',  and loading data from the external table into the native table in bigquery

CREATE OR REPLACE TABLE `glowing-bird-474605-c3.raw.superstore_native` AS
SELECT *
FROM `glowing-bird-474605-c3.raw.superstore_external`;


-- In the next queries, we validate the table to check if everything was loaded properly from cloud storage to bigquery

--  This query checks to see if all the rows have been loaded from cloud storage
SELECT COUNT(*) AS total_rows
FROM `glowing-bird-474605-c3.raw.superstore_native`;



-- This query checks to see if there are any missing values in major columns by giving the count of non-missing values of each column
SELECT
  COUNT(*) AS total_rows,
  COUNT(order_id) AS order_id_non_null,
  COUNT(order_date) AS order_date_non_null,
  COUNT(sales) AS sales_non_null
FROM `glowing-bird-474605-c3.raw.superstore_native`;
