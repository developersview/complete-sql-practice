WITH snapchat_activities AS (
  SELECT
    ab.age_bucket,
    SUM(CASE
          WHEN a.activity_type = 'send' THEN a.time_spent
          ELSE 0
        END
    ) AS time_spend_sending,
    SUM(CASE
          WHEN a.activity_type = 'open' THEN a.time_spent
          ELSE 0
        END
    ) AS time_spend_opening,
    SUM(CASE
          WHEN a.activity_type IN ('open', 'send') THEN a.time_spent
          ELSE 0
        END
    ) AS total_time
  FROM 
    activities a
      JOIN
    age_breakdown ab ON a.user_id = ab.user_id
  GROUP BY 1
)
SELECT
  age_bucket,
  ROUND((time_spend_sending / total_time) * 100.0, 2) AS send_perc,
  ROUND((time_spend_opening / total_time) * 100.0, 2) AS open_perc
FROM
  snapchat_activities;