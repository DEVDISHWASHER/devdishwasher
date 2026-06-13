package school;

import util.Displayable;

/**
 * Represents a teacher who instructs a subject and can display their information.
 */
public class Teacher extends Person implements Displayable {
    private String subject;

    public Teacher() {
    }

    public Teacher(String firstName, String lastName, String subject) {
        setFirstName(firstName);
        setLastName(lastName);
        this.subject = subject;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    @Override
    public String display() {
        return getFullName() + " teaches " + subject + ".";
    }
}
