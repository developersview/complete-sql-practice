WITH sorted_task AS (
    SELECT
        Task_ID, Start_Date, End_Date,
        LAG(End_Date) OVER(ORDER BY End_Date) AS previous_end
    FROM
        Projects
),
flagged_task AS (
    SELECT
        Task_ID, Start_Date, End_Date,
        CASE
            WHEN DATEDIFF(End_Date, previous_end) = 1 THEN 0
            ELSE 1
        END AS is_new_project
    FROM
        sorted_task
),
project_groups AS (
    SELECT
        Task_ID, Start_Date, End_Date,
        SUM(is_new_project) OVER(ORDER BY End_Date ROWS UNBOUNDED PRECEDING) AS project_id
    FROM
        flagged_task
)
SELECT
    MIN(Start_Date) AS project_start,
    MAX(End_Date) AS project_end
FROM
    project_groups
GROUP BY project_id
ORDER BY DATEDIFF(MAX(End_Date), MIN(Start_Date)), MIN(Start_Date);