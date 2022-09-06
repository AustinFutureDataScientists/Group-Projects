WITH
mr AS
  (
  SELECT
    measurement_id,
    date_trunc('day', measurement_time) AS DAY,
    measurement_value,
    RANK()
      OVER
        (
          PARTITION BY
            date_trunc('day', measurement_time)
          ORDER BY
            measurement_time
        )
      AS measurement_rank
    ,
    measurement_time

  FROM measurements m
  ),
odd_measurements AS
  (
  SELECT day, sum(measurement_value) AS measurement_sum
  FROM mr
  WHERE measurement_rank%2=1
  GROUP BY day
  ),
even_measurements AS
  (
  SELECT day, sum(measurement_value) AS measurement_sum
  FROM mr
  WHERE measurement_rank%2=0
  GROUP BY day
  ),

final_query AS
(
SELECT
  DISTINCT mr.day,
  odd_measurements.measurement_sum AS odd_measurement_sum,
  even_measurements.measurement_sum AS even_measurement_sum
FROM mr
INNER JOIN odd_measurements ON
    mr.day=odd_measurements.day
INNER JOIN even_measurements ON
    mr.day=even_measurements.day
)

SELECT * FROM final_query
 
