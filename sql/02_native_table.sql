--  Creating a bigquery table called 'superstore_native',  and loading data from the external table into the native table in bigquery

CREATE OR REPLACE TABLE `glowing-bird-474605-c3.raw.superstore_native` AS
SELECT *
FROM `glowing-bird-474605-c3.raw.superstore_external`;


-- In the next queries, we validate the table to check if everything was loaded properly from cloud storage to bigquery

--  This query checks to see if all the rows have been loaded from cloud storage
SELECT COUNT(*) AS total_rows
FROM `glowing-bird-474605-c3.raw.superstore_native`;


SELECT order_id,customer_id,product_id, COUNT(*) AS cnt
FROM `glowing-bird-474605-c3.raw.superstore_native`
GROUP BY
  order_id,
  product_id,
  customer_id
HAVING COUNT(*) > 1;


SELECT *
FROM `glowing-bird-474605-c3.raw.superstore_native`
WHERE order_id = 'CA-2017-129714';



-- This query checks to see if there are any missing values in major columns by giving the count of non-missing values of each column
SELECT
  COUNT(*) AS total_rows,
  COUNT(order_id) AS order_id_non_null,
  COUNT(order_date) AS order_date_non_null,
  COUNT(sales) AS sales_non_null
FROM `glowing-bird-474605-c3.raw.superstore_native`;



SELECT * FROM `glowing-bird-474605-c3.raw.superstore_native` WHERE customer_name IS NULL;




SELECT COUNT(*)
FROM `glowing-bird-474605-c3.raw.superstore_native`
WHERE sales < 0;




SELECT
  MIN(sales) AS min,
  MAX(sales) AS max,
  AVG(sales) AS avg
FROM `glowing-bird-474605-c3.raw.superstore_native`;



SELECT * FROM `glowing-bird-474605-c3.raw.superstore_native` WHERE sales>10000;



SELECT
  APPROX_QUANTILES(sales, 100)[OFFSET(95)] AS p95,
  APPROX_QUANTILES(sales, 100)[OFFSET(99)] AS p99
FROM `glowing-bird-474605-c3.raw.superstore_native`;




SELECT *
FROM `project.raw.superstore_native`
WHERE sales >
(
  SELECT APPROX_QUANTILES(sales, 100)[OFFSET(99)]
  FROM `glowing-bird-474605-c3.raw.superstore_native`
);




WITH stats AS (
  SELECT
    APPROX_QUANTILES(sales, 4)[OFFSET(1)] AS q1,
    APPROX_QUANTILES(sales, 4)[OFFSET(3)] AS q3
  FROM `project.raw.superstore_native`
)
SELECT *
FROM `glowing-bird-474605-c3.raw.superstore_native`, stats
WHERE sales > (q3 + 1.5 * (q3 - q1));




SELECT
  MIN(sales),
  MAX(sales),
  APPROX_QUANTILES(sales, 10)
FROM `glowing-bird-474605-c3.raw.superstore_native`;




SELECT
  order_id,
  sales,
  product_name,
  category
FROM `glowing-bird-474605-c3.raw.superstore_native`
WHERE sales >
(
  SELECT APPROX_QUANTILES(sales, 100)[OFFSET(99)]
  FROM `glowing-bird-474605-c3.raw.superstore_native`
)
ORDER BY sales DESC;





CREATE OR REPLACE TABLE `glowing-bird-474605-c3.analytics.sales_with_outlier_flag` AS
SELECT *,
  CASE
    WHEN sales >
      (SELECT APPROX_QUANTILES(sales, 100)[OFFSET(99)]
       FROM `glowing-bird-474605-c3.raw.superstore_native`)
    THEN 'outlier'
    ELSE 'normal'
  END AS sales_flag
FROM `glowing-bird-474605-c3.raw.superstore_native`;
