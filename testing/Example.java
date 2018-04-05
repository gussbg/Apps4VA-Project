import java.util.Scanner;

/**
 * Example program for CS 474 svn lab. Each team member should edit one of the
 * four methods below. No two people should edit the same line of code. The goal
 * is to practice committing/updating changes to/from your svn repository.
 * try this
 * @author Chris Mayfield
 * @version 02/13/2015
 */
public class Example {
    
    private static Scanner keyboard = new Scanner(System.in);
    
    /**
     * Reads a double (or integer) from keyboard
     * and consumes the rest of the current line.
     *
     * @param prompt text to display to the user
     * @return number read from the keyboard
     */
    public static double inputNumber(String prompt) {
        double input;
        System.out.print(prompt + ": ");
        input = keyboard.nextDouble();
        keyboard.nextLine();
        return input;
    }
    
    /**
     * Reads the next line from keyboard.
     *
     * @param prompt text to display to the user
     * @return line read from the keyboard
     */
    public static String inputLine(String prompt) {
        System.out.print(prompt + ": ");
        return keyboard.nextLine();
    }
    
    /**
     * Prints a single item with required formatting.
     *
     * @param code the item's code
     * @param qty the item's quantity
     * @param price the item's price
     */
    public static void printItem(String code, int qty, double price) {
        System.out.print(code + "\t" + qty + "\t");
        System.out.printf("%.2f\n", price);
    }
    
    /**
     * Creates an invoice based on user inputs.
     *
     * @param args command line arguments
     */
    public static void main(String[] args) {
        String code1;
        int qty1;
        double price1;
        
        // display prompts and read user inputs
        code1 = inputLine("Enter Item 1 Code");
        qty1 = (int) inputNumber("Enter Item 1 Qty");
        price1 = inputNumber("Enter Item 1 Price");
        
        // display formatted output
        System.out.println("Item\tQty\tPrice");
        System.out.println("----\t---\t-----");
        printItem(code1, qty1, price1);
    }
    
}
