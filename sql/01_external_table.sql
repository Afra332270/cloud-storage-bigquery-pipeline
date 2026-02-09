-- Creating an external table (called 'superstore_external'), which is part of our main (raw) dataset.

CREATE OR REPLACE EXTERNAL TABLE `glowing-bird-474605-c3.raw.superstore_external`
OPTIONS (
  format = 'CSV',
  uris = ['gs://de-beginner-raw-data/sales/superstore_sales_cleaned.csv'],
  skip_leading_rows = 1
);


-- does not support autodetect
CREATE OR REPLACE EXTERNAL TABLE `<glowing-bird-474605-c3>.raw.superstore_external`
OPTIONS (
  format = 'CSV',
  uris = ['gs://de-beginner-raw-data/sales/superstore_sales_cleaned.csv'],
  skip_leading_rows = 1,
  autodetect = TRUE
);

-- The next queries show how we read, inspect and validate the dataset (externally)


-- Previewing the dataset
SELECT * FROM `glowing-bird-474605-c3.raw.superstore_external` LIMIT 10;


-- Checking for the total number of rows
SELECT COUNT(*) FROM `glowing-bird-474605-c3.raw.superstore_external`;



-- Checking for all the table names in the dataset and their type. We are using metadata fields (table_name, table_type) provided by BigQuery’s INFORMATION_SCHEMA
SELECT
  table_name,
  table_type
FROM `glowing-bird-474605-c3.raw.INFORMATION_SCHEMA.TABLES`;



-- Checking for all column names and their data types. We are using metadata fields (column_name, data_type) provided by BigQuery’s INFORMATION_SCHEMA
SELECT column_name, data_type
FROM `glowing-bird-474605-c3.raw.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'superstore_external';


-- Checking for the total number of rows and to see if there are any missing order_id values (null values).
SELECT
  COUNT(*) AS total_rows,
  COUNT(order_id) AS order_id_present
FROM `glowing-bird-474605-c3.raw.superstore_external`;


SELECT COUNT(*)
FROM `glowing-bird-474605-c3.raw.superstore_external`
WHERE SAFE_CAST(sales AS FLOAT64) IS NULL;
