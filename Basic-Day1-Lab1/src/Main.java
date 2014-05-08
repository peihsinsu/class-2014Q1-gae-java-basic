import java.util.Scanner;
 
/**
 * @author Simon su
 * @Reference https://crunchify.com/write-java-program-to-print-fibonacci-series-upto-n-number/
 */
public class Main {
 
    public static void main(String args[]) {
 
        System.out.print("Enter number upto which Fibonacci series to print: ");
        int number = new Scanner(System.in).nextInt();
 
        System.out.println("\n\nFibonacci series upto " + number +" numbers : ");
        for(int i=1; i<=number; i++){
            System.out.print(fibonacciRecusion(i) +" ");
        }
    } 
 
    public static int fibonacciRecusion(int number){
        if(number == 1 || number == 2){
            return 1;
        }
        return fibonacciRecusion(number-1) + fibonacciRecusion(number -2); //tail recursion
    }
}