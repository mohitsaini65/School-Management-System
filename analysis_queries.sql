
-- 1. Total Students, Teachers, Classes

SELECT 
    (SELECT COUNT(*) FROM students) AS total_students,
    (SELECT COUNT(*) FROM teachers) AS total_teachers,
    (SELECT COUNT(*) FROM classes) AS total_classes;

-- 2. Student Count per Class (1A, 1B…12B)

SELECT 
    c.class_id,
    CONCAT(c.grade, c.section) AS class_name,
    COUNT(e.student_id) AS student_count
FROM classes c
LEFT JOIN enrollments e ON c.class_id = e.class_id
GROUP BY c.class_id;

-- 3. Attendance Percentage of Each Student

SELECT 
    s.student_id,
    s.name,
    ROUND(AVG(att.status = 'Present') * 100, 2) AS attendance_percent
FROM students s
JOIN attendance att ON s.student_id = att.student_id
GROUP BY s.student_id
ORDER BY attendance_percent DESC;

-- 4. Top 10 Students with Best Attendance

SELECT 
    s.student_id, s.name,
    ROUND(AVG(att.status = 'Present') * 100, 2) AS attendance_percent
FROM students s
JOIN attendance att ON s.student_id = att.student_id
GROUP BY s.student_id
ORDER BY attendance_percent DESC
LIMIT 10;

-- 5. Monthly Attendance Summary (3 months)

SELECT 
    DATE_FORMAT(date, '%Y-%m') AS month,
    SUM(status = 'Present') AS present_days,
    SUM(status = 'Absent') AS absent_days
FROM attendance
GROUP BY DATE_FORMAT(date, '%Y-%m');

-- 6. Total Fees Paid vs Pending (Overall)

SELECT
    SUM(status = 'Paid') AS paid_records,
    SUM(status = 'Pending') AS pending_records,
    SUM(amount) AS total_amount
FROM fees;

-- 7. Fee Defaulters (Students with Pending Fees)

SELECT 
    f.student_id,
    s.name,
    f.amount,
    f.status
FROM fees f
JOIN students s ON f.student_id = s.student_id
WHERE f.status = 'Pending';

-- 8. Top 20 Highest Scorers in Final Exam

SELECT 
    m.student_id,
    s.name,
    m.subject_id,
    m.marks_obtained
FROM marks m
JOIN students s ON m.student_id = s.student_id
WHERE m.exam_type = 'Final'
ORDER BY m.marks_obtained DESC
LIMIT 20;

-- 9. Average Marks per Subject

SELECT 
    sub.subject_name,
    ROUND(AVG(m.marks_obtained), 2) AS avg_marks
FROM marks m
JOIN subjects sub ON m.subject_id = sub.subject_id
GROUP BY sub.subject_id;

-- 10. Weak Subjects (Subjects Avg < 40)

SELECT 
    sub.subject_name,
    ROUND(AVG(m.marks_obtained), 2) AS average_marks
FROM marks m
JOIN subjects sub ON m.subject_id = sub.subject_id
GROUP BY sub.subject_id
HAVING AVG(m.marks_obtained) < 40;

-- 11. Students Failing in Any Subject (Marks < 33)

SELECT 
    DISTINCT m.student_id,
    s.name
FROM marks m
JOIN students s ON m.student_id = s.student_id
WHERE m.marks_obtained < 33;

-- 12. Top 5 Scorers per Class (Final Exam)

SELECT *
FROM (
    SELECT 
        s.student_id, s.name,
        c.class_id,
        m.marks_obtained,
        ROW_NUMBER() OVER (PARTITION BY c.class_id ORDER BY m.marks_obtained DESC) AS rank_in_class
    FROM marks m
    JOIN enrollments e ON m.student_id = e.student_id
    JOIN classes c ON e.class_id = c.class_id
    JOIN students s ON m.student_id = s.student_id
    WHERE m.exam_type = 'Final'
) ranked
WHERE rank_in_class <= 5;


-- 13. Attendance Defaulters (Attendance < 75%)

SELECT 
    s.student_id,
    s.name,
    ROUND(AVG(att.status = 'Present') * 100, 2) AS attendance_percent
FROM students s
JOIN attendance att ON s.student_id = att.student_id
GROUP BY s.student_id
HAVING attendance_percent < 75;

-- 14. Teacher Workload (Subjects Assigned)

SELECT 
    t.teacher_id,
    t.name,
    COUNT(sub.subject_id) AS subjects_count
FROM teachers t
LEFT JOIN subjects sub ON t.teacher_id = sub.teacher_id
GROUP BY t.teacher_id;

-- 15. Class-Wise Average Marks (Final Exam)

SELECT 
    CONCAT(c.grade, c.section) AS class_name,
    ROUND(AVG(m.marks_obtained), 2) AS class_average
FROM marks m
JOIN enrollments e ON m.student_id = e.student_id
JOIN classes c ON e.class_id = c.class_id
WHERE m.exam_type = 'Final'
GROUP BY c.class_id;

-- 16. Students with Multiple Absences (>10)

SELECT 
    s.student_id,
    s.name,
    SUM(att.status = 'Absent') AS total_absent
FROM attendance att
JOIN students s ON att.student_id = s.student_id
GROUP BY s.student_id
HAVING total_absent > 10;


-- 17. Students Who Paid Full Fees

SELECT 
    s.student_id,
    s.name,
    SUM(f.amount) AS total_paid
FROM students s
JOIN fees f ON s.student_id = f.student_id
WHERE f.status = 'Paid'
GROUP BY s.student_id
ORDER BY total_paid DESC;

-- 18. Overall School Performance Summary

SELECT
    (SELECT COUNT(*) FROM students) AS total_students,
    (SELECT ROUND(AVG(marks_obtained),2) FROM marks) AS avg_marks,
    (SELECT ROUND(AVG(status = 'Present') * 100,2) FROM attendance) AS avg_attendance,
    (SELECT SUM(amount) FROM fees WHERE status='Paid') AS fee_collected,
    (SELECT SUM(amount) FROM fees WHERE status='Pending') AS fee_pending;