CREATE OR REPLACE EXTERNAL TABLE `fhv_test.external_fhv_tripdata`
OPTIONS (
  format = 'parquet',
  uris = ['gs://fhv_vehicle_bucket/fhv/fhv_tripdata_2019-*.parquet.gz']
);


CREATE OR REPLACE TABLE fhv_test.fhv_tripdata_non_partitoned AS
SELECT * FROM fhv_test.external_fhv_tripdata;

-- 1. What is the count for fhv vehicle records for year 2019?
SELECT COUNT(*) FROM fhv_test.fhv_tripdata_non_partitoned


-- 2. Count the distinct number of affiliated_base_number for the entire dataset
SELECT COUNT(DISTINCT Affiliated_base_number) FROM `fhv_test.external_fhv_tripdata`


--3. How many records have both a blank (null) PUlocationID and DOlocationID in the entire dataset
SELECT COUNT(*) FROM fhv_test.fhv_tripdata_non_partitoned
WHERE PUlocationID IS NULL AND DOlocationID IS NULL


-- 4 and 5. Paritioning and clustering


DROP TABLE fhv_test.fhv_tripdata_partitoned_clustered;

CREATE OR REPLACE TABLE fhv_test.fhv_tripdata_partitoned_clustered
PARTITION BY DATE(dt)
CLUSTER BY `Affiliated_base_number`
AS (
SELECT *, DATETIME(pickup_datetime) as dt
FROM fhv_test.fhv_tripdata_non_partitoned);

-- query to retrieve the distinct affiliated_base_number between pickup_datetime 2019/03/01 and 2019/03/31 (inclusive)
SELECT * FROM fhv_test.fhv_tripdata_non_partitoned 
WHERE DATETIME(pickup_datetime) BETWEEN "2019-03-01" AND "2019-03-31";

SELECT * FROM fhv_test.fhv_tripdata_partitoned_clustered 
WHERE dt BETWEEN "2019-03-01" AND "2019-03-31";

SELECT COUNT(DISTINCT affiliated_base_number) FROM fhv_test.fhv_tripdata_partitoned_clustered;

-- some date time parsing functions
-- SELECT
--  DATE(DATETIME(pickup_datetime)) as dtime,
--  FORMAT_DATETIME('%Y-%m-%d', DATETIME(pickup_datetime)) as dt,
--  CAST(DATETIME(pickup_datetime) AS STRING FORMAT 'MONTH') as casted, 
--  PARSE_DATETIME('%Y-%m-%d %H:%M:%S', pickup_datetime) 
--   AS formatted
-- FROM fhv_test.fhv_tripdata_non_partitoned limit 20;





