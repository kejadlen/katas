#![feature(inclusive_range_syntax)]

fn main() {
  let result: Vec<String> = (1...100)
    .map(|n| match n {
      n if n % 15 == 0 => "FizzBuzz".into(),
      n if n % 3 == 0 => "Fizz".into(),
      n if n % 5 == 0 => "Buzz".into(),
      n => format!("{}", n),
    })
    .collect();
  println!("{:?}", result);
}
