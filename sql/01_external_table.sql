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

-- Reading, Inspecting and Validating the dataset (externally)

SELECT * FROM `glowing-bird-474605-c3.raw.superstore_external` LIMIT 10;

SELECT COUNT(*) FROM `glowing-bird-474605-c3.raw.superstore_external`;

SELECT
  table_name,
  table_type
FROM `glowing-bird-474605-c3.raw.INFORMATION_SCHEMA.TABLES`;


-- Checking column names and order

SELECT column_name, data_type
FROM `project.raw.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'superstore_external';
