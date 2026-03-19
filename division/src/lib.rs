use std::io::{self, Write};

#[unsafe(no_mangle)]
pub extern "C" fn divide() -> i32
{
    let mut input = String::new();

    print!("[Rust] Enter first number: ");
    io::stdout().flush().unwrap();
    io::stdin().read_line(&mut input).unwrap();
    let a: i32 = input.trim().parse().unwrap_or(0);

    input.clear();

    print!("[Rust] Enter second number: ");
    io::stdout().flush().unwrap();
    io::stdin().read_line(&mut input).unwrap();
    let b: i32 = input.trim().parse().unwrap_or(1);

    if b == 0
    {
        println!("[Rust] Error: Cannot divide by zero!");
        return 0;
    }

    let result = a / b;
    println!("[Rust] The total is: {}", result);

    result
}
