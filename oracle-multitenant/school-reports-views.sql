/* WebucatorProject: SQL Queries XEPDB1 schooladmin */

-- (5%) Count for each table (Individual Queries)
SELECT COUNT(*) AS schools_count FROM schools;
SELECT COUNT(*) AS subjects_count FROM subjects;
SELECT COUNT(*) AS people_count FROM people;
SELECT COUNT(*) AS teachers_count FROM teachers;
SELECT COUNT(*) AS students_count FROM students;
SELECT COUNT(*) AS principals_count FROM principals;
SELECT COUNT(*) AS classrooms_count FROM classrooms;
SELECT COUNT(*) AS classroom_students_count FROM classroom_students;

-- (2%) Table Summary Report
SELECT 'people' AS table_name, COUNT(*) AS num_records FROM people
UNION ALL SELECT 'principals', COUNT(*) FROM principals
UNION ALL SELECT 'students', COUNT(*) FROM students
UNION ALL SELECT 'teachers', COUNT(*) FROM teachers;

-- (3%) Teacher Names Ordered
SELECT p.first_name, p.last_name
FROM people p
JOIN teachers t ON p.person_id = t.person_id
ORDER BY p.last_name, p.first_name;

-- (5%) People per School
SELECT s.school_name, COUNT(p.person_id) AS num_people
FROM schools s
JOIN people p ON s.school_id = p.school_id
GROUP BY s.school_name
ORDER BY num_people DESC;

-- (5%) Students per School
SELECT s.school_name, COUNT(st.student_id) AS num_students
FROM schools s
JOIN people p ON s.school_id = p.school_id
JOIN students st ON p.person_id = st.person_id
GROUP BY s.school_name
ORDER BY num_students DESC;

-- (3%) Clinton/Washington Search
SELECT (first_name || ' ' || last_name) AS full_name, address, city
FROM people
WHERE city = 'Clinton' 
  AND address LIKE '%Washington%';

-- (3%) Oldest Student Birth Date
SELECT MIN(p.birth_date) AS oldest_student_dob
FROM people p
JOIN students s ON p.person_id = s.person_id;

-- (4%) Oldest Student Details
SELECT p.first_name, p.last_name, p.city, p.region AS state, p.birth_date
FROM people p
JOIN students s ON p.person_id = s.person_id
WHERE p.birth_date = (
    SELECT MIN(birth_date) 
    FROM people p2 
    JOIN students s2 ON p2.person_id = s2.person_id
);

-- (5%) Multi-Role Report
SELECT 
    (p.first_name || ' ' || p.last_name) AS full_name,
    CASE 
        WHEN pr.principal_id IS NOT NULL THEN 'principal'
        WHEN t.teacher_id IS NOT NULL THEN 'teacher'
        WHEN s.student_id IS NOT NULL THEN 'student'
    END AS role,
    CASE 
        WHEN s.student_id IS NOT NULL THEN 'N/A'
        WHEN pr.principal_id IS NOT NULL THEN TO_CHAR(pr.salary, '$999,999')
        WHEN t.teacher_id IS NOT NULL THEN TO_CHAR(t.salary, '$999,999')
    END AS salary,
    sch.school_name
FROM people p
JOIN schools sch ON p.school_id = sch.school_id
LEFT JOIN principals pr ON p.person_id = pr.person_id
LEFT JOIN teachers t ON p.person_id = t.person_id
LEFT JOIN students s ON p.person_id = s.person_id;

-- (5%) Classroom Master Report
SELECT 
    c.classroom_id,
    (tp.first_name || ' ' || tp.last_name) AS teacher_name,
    c.semester,
    c.year,
    sub.subject,
    sch.school_name
FROM classrooms c
JOIN teachers t ON c.teacher_id = t.teacher_id
JOIN people tp ON t.person_id = tp.person_id
JOIN subjects sub ON c.subject_id = sub.subject_id
JOIN schools sch ON tp.school_id = sch.school_id
ORDER BY sch.school_name, c.year, c.semester, sub.subject;

-- (2%) View Creation
CREATE OR REPLACE VIEW classroom_students_view AS
SELECT ps.first_name || ' ' || ps.last_name AS student, cs.grade,
      pt.first_name || ' ' || pt.last_name AS teacher,
      sub.subject, c.semester, c.year
FROM people ps
  JOIN students s ON ps.person_id = s.person_id
  JOIN classroom_students cs ON s.student_id = cs.student_id
  JOIN classrooms c ON c.classroom_id = cs.classroom_id
  JOIN subjects sub ON sub.subject_id = c.subject_id
  JOIN teachers t ON t.teacher_id = c.teacher_id
  JOIN people pt ON pt.person_id = t.person_id;

-- (3%) Querying the View: Megan Gray's Science Class
SELECT student, grade
FROM classroom_students_view
WHERE teacher = 'Megan Gray'
  AND semester = 'spring'
  AND year = 2021
  AND subject = 'Science'
ORDER BY grade DESC;

-- (5%) Fayetteville-Manlius Science Teacher
SELECT pt.first_name || ' ' || pt.last_name AS teacher_name
FROM people pt
JOIN teachers t ON pt.person_id = t.person_id
JOIN classrooms c ON t.teacher_id = c.teacher_id
JOIN subjects sub ON c.subject_id = sub.subject_id
JOIN schools sch ON pt.school_id = sch.school_id
WHERE sch.school_name = 'Fayetteville-Manlius School'
  AND sub.subject = 'Science'
  AND c.semester = 'spring'
  AND c.year = 2021;