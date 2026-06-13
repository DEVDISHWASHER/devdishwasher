SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION get_classroom_teacher (
    p_subject  IN VARCHAR2,
    p_school   IN VARCHAR2,
    p_year     IN NUMBER,
    p_semester IN VARCHAR2
) RETURN VARCHAR2 IS
    l_teacher_name VARCHAR2(100);
BEGIN
    SELECT pt.first_name || ' ' || pt.last_name
    INTO l_teacher_name
    FROM people pt
    JOIN teachers t ON pt.person_id = t.person_id
    JOIN classrooms c ON t.teacher_id = c.teacher_id
    JOIN subjects sub ON c.subject_id = sub.subject_id
    JOIN schools sch ON pt.school_id = sch.school_id
    WHERE sch.school_name = p_school
      AND sub.subject = p_subject
      AND c.semester = p_semester
      AND c.year = p_year;

    RETURN l_teacher_name;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    WHEN OTHERS THEN
        RETURN 'Error: Unexpected error';
END;
/

-- Test Block 1: 2021 (Expected: Megan Gray)
DECLARE
    l_subject  VARCHAR2(20) := 'Science';
    l_school   VARCHAR2(50) := 'Fayetteville-Manlius School';
    l_year     NUMBER := 2021;
    l_semester VARCHAR2(10) := 'spring';
    l_result   VARCHAR2(100);
BEGIN
    l_result := get_classroom_teacher(l_subject, l_school, l_year, l_semester);
    IF l_result IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('The teacher is ' || l_result || '.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No teacher found.');
    END IF;
END;
/

-- Test Block 2: 2023 (Expected: No teacher found)
DECLARE
    l_subject  VARCHAR2(20) := 'Science';
    l_school   VARCHAR2(50) := 'Fayetteville-Manlius School';
    l_year     NUMBER := 2023;
    l_semester VARCHAR2(10) := 'spring';
    l_result   VARCHAR2(100);
BEGIN
    l_result := get_classroom_teacher(l_subject, l_school, l_year, l_semester);
    IF l_result IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('The teacher is ' || l_result || '.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No teacher found.');
    END IF;
END;
/