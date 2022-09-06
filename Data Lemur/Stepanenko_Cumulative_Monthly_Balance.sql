WITH
ds AS
(
  SELECT
    transaction_date,
    type,
    COALESCE(amount,0) AS deposit
  FROM transactions
  WHERE type='deposit'
  ORDER BY transaction_date
),
ws AS
(
  SELECT
    transaction_date,
    type,
    COALESCE(amount,0) AS withdrawal
  FROM transactions
  WHERE type='withdrawal'
  ORDER BY transaction_date
),
combined_table AS
(
  SELECT
  COALESCE
  (
    DATE_TRUNC('day',ds.transaction_date),
    DATE_TRUNC('day',ws.transaction_date)
  ) AS date,
  SUM(COALESCE(deposit,0)) AS deposit,
  SUM(COALESCE(withdrawal,0)) AS withdrawal

  FROM ds
  FULL OUTER JOIN ws
  ON ds.transaction_date=ws.transaction_date
  GROUP BY
    COALESCE
    (
      DATE_TRUNC('day',ds.transaction_date),
      DATE_TRUNC('day',ws.transaction_date)
    )
  ORDER BY
    COALESCE
    (
      DATE_TRUNC('day',ds.transaction_date),
      DATE_TRUNC('day',ws.transaction_date)
    )
),
balance AS
(
  SELECT
  date,
  SUM(deposit-withdrawal)
    OVER
    (
      PARTITION BY DATE_TRUNC('month',date) ORDER BY date
    )
  AS day_balance
  FROM
  combined_table
  ORDER BY date
)
SELECT * FROM balance;
