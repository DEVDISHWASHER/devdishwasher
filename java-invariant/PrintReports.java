import java.util.ArrayList;
import util.KeyboardReader;
import util.Displayable;
import school.*;

/**
 * Main program to collect classroom, teacher, student info
 * from user. Print formatted school report.
 */
public class PrintReports {

    private KeyboardReader reader;

    public PrintReports() {
        reader = new KeyboardReader();
    }

    public static void main(String[] args) {
        PrintReports pr = new PrintReports();
        pr.run();
    }

    public void run() {
        ArrayList<Displayable> classrooms = new ArrayList<Displayable>();

        boolean more = true;
        while (more) {
            classrooms.add(enterClassroom());
            more = reader.readYesNo("Enter another classroom? (y/n): ");
        }

        report(classrooms);
    }

    public Displayable enterClassroom() {
        Classroom c = new Classroom();

        int room = reader.readInt("Enter room number (>=100): ");
        while (room < 100) {
            room = reader.readInt("Room must be >=100. Try again: ");
        }
        c.setRoomNumber(room);

        System.out.println("\n--- Enter Teacher Info ---");
        Teacher t = (Teacher) enterTeacher();
        c.setTeacher(t);

        System.out.println("\n--- Enter Students ---");
        boolean more = true;
        while (more) {
            Student s = (Student) enterStudent();
            c.addStudent(s);
            more = reader.readYesNo("Add another student? (y/n): ");
        }

        return c;
    }

    public Displayable enterTeacher() {
        Teacher t = new Teacher();

        String first = reader.readString("Teacher first name: ");
        t.setFirstName(first);

        String last = reader.readString("Teacher last name: ");
        t.setLastName(last);

        String subject = reader.readString("Subject taught: ");
        t.setSubject(subject);

        return t;
    }

    public Displayable enterStudent() {
        Student s = new Student();

        int id = reader.readInt("Student ID (>0): ");
        while (id <= 0) {
            id = reader.readInt("ID must be >0. Try again: ");
        }
        s.setStudentId(id);

        String first = reader.readString("Student first name: ");
        s.setFirstName(first);

        String last = reader.readString("Student last name: ");
        s.setLastName(last);

        int grade = reader.readInt("Final grade (0-100): ");
        while (grade < 0 || grade > 100) {
            grade = reader.readInt("Grade must be 0-100. Try again: ");
        }
        s.setFinalGrade(grade);

        return s;
    }

    public void report(ArrayList<Displayable> list) {
        System.out.println("\n===== SCHOOL REPORT =====\n");

        for (Displayable d : list) {
            System.out.println(d.display());
            System.out.println("-------------------------");
        }
    }
}
