-- Creating an external table (called 'superstore_external'), which is part of our main (raw) dataset.

CREATE OR REPLACE EXTERNAL TABLE `<glowing-bird-474605-c3>.raw.superstore_external`
OPTIONS (
  format = 'CSV',
  uris = ['gs://de-beginner-raw-data/sales/superstore_sales_cleaned.csv'],
  skip_leading_rows = 1,
  autodetect = TRUE
);

