package school;

import util.Displayable;

/**
 * Represents a student with an ID and final grade who can display their information.
 */
public class Student extends Person implements Displayable {
    private int studentId;
    private int finalGrade;

    public Student() {
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public int getFinalGrade() {
        return finalGrade;
    }

    public void setFinalGrade(int finalGrade) {
        this.finalGrade = finalGrade;
    }

    @Override
    public String display() {
        return "Student ID: " + studentId + "\t" +
               getFullName() + "\tFinal Grade: " + finalGrade;
    }
}
