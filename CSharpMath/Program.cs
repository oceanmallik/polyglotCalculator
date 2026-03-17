using System;

namespace CSharpMath
{
    class Program
    {
        public static void Main(string[] args)
        {
            Console.Write("[C#] Enter first number: ");
            string? input1 = Console.ReadLine();
            int a = int.Parse(input1 ?? "0");

            Console.Write("[C#] Enter second number: ");
            string? input2 = Console.ReadLine();
            int b = int.Parse(input2 ?? "0");

            int result = a * b;
            Console.WriteLine($"[C#] The total is: {result}");
        }
    }
}