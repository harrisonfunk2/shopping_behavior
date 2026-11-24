CREATE OR REPLACE TABLE
  `shopping-behavior-514902.shopping.events_flat_train`
PARTITION BY DATE(event_timestamp)
CLUSTER BY session_id
AS
SELECT 
  s.session AS session_id,
  event_index,
  e.aid AS product_id,
  e.type AS event_type,
  TIMESTAMP_MILLIS(e.ts) AS event_timestamp
FROM 
  `shopping-behavior-514902.shopping.sessions-raw-train` AS s
CROSS JOIN 
  UNNEST (s.events) AS e -- converts nested event array into rows
  WITH OFFSET AS event_index;