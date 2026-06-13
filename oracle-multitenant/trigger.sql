CREATE OR REPLACE TRIGGER check_teacher_subject
BEFORE INSERT OR UPDATE ON classrooms
FOR EACH ROW
DECLARE
    l_teacher_name VARCHAR2(100);
    l_subject_name VARCHAR2(60);
    l_count NUMBER;
BEGIN
    -- Check if the teacher is qualified for the subject
    SELECT COUNT(*)
    INTO l_count
    FROM teachers
    WHERE teacher_id = :NEW.teacher_id
      AND subject_id = :NEW.subject_id;

    IF l_count = 0 THEN
        -- Fetch names for the error message
        SELECT first_name || ' ' || last_name INTO l_teacher_name 
        FROM people p JOIN teachers t ON p.person_id = t.person_id 
        WHERE t.teacher_id = :NEW.teacher_id;
        
        SELECT subject INTO l_subject_name FROM subjects WHERE subject_id = :NEW.subject_id;

        RAISE_APPLICATION_ERROR(-20001, l_teacher_name || ' does not teach ' || l_subject_name);
    END IF;
END;
/

-- TEST SUITE
-- 1. This should succeed (Valid mapping)
INSERT INTO classrooms (teacher_id, subject_id, semester, year)
VALUES (1, 1, 'spring', 2022);

-- 2. This should fail (Invalid mapping - Sarah Garcia vs Math)
INSERT INTO classrooms (teacher_id, subject_id, semester, year)
VALUES (2, 1, 'spring', 2022);

ROLLBACK;