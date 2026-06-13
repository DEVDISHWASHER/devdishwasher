package school;

import java.util.ArrayList;
import util.Displayable;

/**
 * Represents a classroom containing a room number, a teacher, and a list of students.
 */
public class Classroom implements Displayable {
    private int roomNumber;
    private Teacher teacher;
    private ArrayList<Student> students;

    public Classroom() {
        students = new ArrayList<Student>();
    }

    public Classroom(int roomNumber, Teacher teacher) {
        this.roomNumber = roomNumber;
        this.teacher = teacher;
        this.students = new ArrayList<Student>();
    }

    public int getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(int roomNumber) {
        this.roomNumber = roomNumber;
    }

    public Teacher getTeacher() {
        return teacher;
    }

    public void setTeacher(Teacher teacher) {
        this.teacher = teacher;
    }

    public ArrayList<Student> getStudents() {
        return students;
    }

    public void addStudent(Student student) {
        students.add(student);
    }

    @Override
    public String display() {
        StringBuilder sb = new StringBuilder();
        sb.append("Room: ").append(roomNumber).append("\n");
        if (teacher != null) {
            sb.append("Teacher: ").append(teacher.display()).append("\n");
        }
        sb.append("Students:\n");
        for (Student s : students) {
            sb.append("  ").append(s.display()).append("\n");
        }
        return sb.toString();
    }
}
