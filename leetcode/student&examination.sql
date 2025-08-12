SELECT 
    s.student_id,
    s.student_name,
    sub.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM
    students s
        CROSS JOIN
    subjects sub
        LEFT JOIN
    examinations e ON s.student_id = e.student_id
        AND sub.subject_name = e.subject_name
GROUP BY s.student_id , s.student_name , sub.subject_name
ORDER BY student_id , subject_name;