--  Creating a bigquery table called 'superstore_native',  and loading data from the external table into bigquery table

CREATE OR REPLACE TABLE `glowing-bird-474605-c3.raw.superstore_native` AS
SELECT *
FROM `glowing-bird-474605-c3.raw.superstore_external`;

