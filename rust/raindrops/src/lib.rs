pub fn raindrops(n: usize) -> String {
  let mut result = String::new();

  if n % 3 == 0 {
    result.push_str("Pling");
  }

  if result.is_empty() {
    result = n.to_string()
  }

  result
}
