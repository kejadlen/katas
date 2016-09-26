#![feature(inclusive_range_syntax)]

fn main() {
  for n in 1...100 {
    match n {
      n if n % 15 == 0 => {
        println!("FizzBuzz");
      }
      n if n % 3 == 0 => {
        println!("Fizz");
      }
      n if n % 5 == 0 => {
        println!("Buzz");
      }
      n => {
        println!("{}", n);
      }
    }
  }
}
