package util;
import java.io.*;

/**
 * Utility class for reading user input from the keyboard.
 */
public class KeyboardReader {

    private static BufferedReader in =
        new BufferedReader(new InputStreamReader(System.in));

    public KeyboardReader() {
    }

    // ---- Original-style helpers (optional but harmless) ----
    public static String getPromptedString(String prompt) {
        String response = null;
        System.out.print(prompt);
        try {
            response = in.readLine();
        } catch (IOException e) {
            System.out.println("IOException occurred");
        }
        return response;
    }

    public static char getPromptedChar(String prompt) {
        return getPromptedString(prompt).charAt(0);
    }

    public static int getPromptedInt(String prompt) {
        return Integer.parseInt(getPromptedString(prompt));
    }

    public static float getPromptedFloat(String prompt) {
        return Float.parseFloat(getPromptedString(prompt));
    }

    public static double getPromptedDouble(String prompt) {
        return Double.parseDouble(getPromptedString(prompt));
    }

    // ---- Required methods for this assignment ----
    public String readString(String prompt) {
        System.out.print(prompt);
        try {
            return in.readLine();
        } catch (IOException e) {
            System.out.println("IOException occurred");
            return "";
        }
    }

    public int readInt(String prompt) {
        while (true) {
            try {
                return Integer.parseInt(readString(prompt));
            } catch (NumberFormatException e) {
                System.out.println("Invalid number. Try again.");
            }
        }
    }

    public boolean readYesNo(String prompt) {
        while (true) {
            String s = readString(prompt).trim().toLowerCase();
            if (s.equals("y") || s.equals("yes")) return true;
            if (s.equals("n") || s.equals("no")) return false;
            System.out.println("Enter y or n.");
        }
    }
}
