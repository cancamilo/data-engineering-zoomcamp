-- total records for 
SELECT COUNT(*)
FROM public.yellow_taxi_trips a

-- total trips for one date
SELECT COUNT(*)
FROM public.yellow_taxi_trips a
WHERE TO_CHAR(a.tpep_pickup_datetime, 'MM-DD') = '01-15' 

SELECT COUNT(*) FROM public.green_taxi_trips a
WHERE TO_CHAR(a.lpep_pickup_datetime, 'MM-DD') = '01-15' 
;

-- largest trip
SELECT * FROM public.green_taxi_trips a
ORDER BY trip_distance DESC LIMIT 1

-- passenger cunts
SELECT passenger_count, COUNT(*) FROM public.green_taxi_trips
WHERE TO_CHAR(lpep_pickup_datetime, 'YYYY-MM-DD') = '2019-01-01'
GROUP BY passenger_count


-- pick up drop off zones largest trips
SELECT * FROM (
	SELECT 
		s.*,
		pup."Zone" as pickup_zone,
		doff."Zone" as dropoff_zone
	FROM public.green_taxi_trips s 
	INNER JOIN public.zones pup ON s."PULocationID" = pup."LocationID"
	INNER JOIN public.zones doff ON s."DOLocationID" = doff."LocationID"
) d
WHERE d.pickup_zone = 'Astoria'
ORDER BY (lpep_dropoff_datetime - lpep_pickup_datetime) DESC
LIMIT 1