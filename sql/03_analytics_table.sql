CREATE OR REPLACE TABLE `project.analytics.sales_by_month` AS
SELECT
  EXTRACT(YEAR FROM order_date) AS year,
  EXTRACT(MONTH FROM order_date) AS month,
  SUM(sales) AS total_sales,
  SUM(profit) AS total_profit,
  COUNT(DISTINCT order_id) AS total_orders
FROM `project.raw.superstore_native`
GROUP BY year, month
ORDER BY year, month;






CREATE OR REPLACE TABLE `project.analytics.sales_by_region_category` AS
SELECT
  region,
  category,
  SUM(sales) AS total_sales,
  SUM(profit) AS total_profit,
  COUNT(DISTINCT order_id) AS total_orders
FROM `project.raw.superstore_native`
GROUP BY region, category;





CREATE OR REPLACE TABLE `project.analytics.order_summary` AS
SELECT
  order_id,
  MIN(order_date) AS order_date,
  SUM(sales) AS order_sales,
  SUM(profit) AS order_profit
FROM `project.raw.superstore_native`
GROUP BY order_id;
