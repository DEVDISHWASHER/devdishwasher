SET SERVEROUTPUT ON;

-- Block 1: Global Teacher Loop
DECLARE
    CURSOR teacher_cursor IS
        SELECT p.first_name, p.last_name, t.salary
        FROM people p
        JOIN teachers t ON p.person_id = t.person_id
        ORDER BY p.last_name, p.first_name;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Global Salary Report ---');
    FOR r_teacher IN teacher_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(r_teacher.first_name || ' ' || r_teacher.last_name || 
                             ' earns ' || TO_CHAR(r_teacher.salary, '$99,999') || ' per year.');
    END LOOP;
END;
/

-- Block 2: Parameterized School Loop
DECLARE
    CURSOR teacher_cursor (teacher_school_name VARCHAR2) IS
        SELECT p.first_name, p.last_name, t.salary
        FROM people p
        JOIN teachers t ON p.person_id = t.person_id
        JOIN schools s ON p.school_id = s.school_id
        WHERE s.school_name = teacher_school_name
        ORDER BY p.last_name, p.first_name;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Scoped Report: Fayetteville-Manlius School ---');
    FOR r_teacher IN teacher_cursor('Fayetteville-Manlius School') LOOP
        DBMS_OUTPUT.PUT_LINE(r_teacher.first_name || ' ' || r_teacher.last_name || 
                             ' earns ' || TO_CHAR(r_teacher.salary, '$99,999') || ' per year.');
    END LOOP;
END;
/