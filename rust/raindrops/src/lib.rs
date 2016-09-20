pub fn raindrops(n: usize) -> String {
  let mut result = String::new();

  if n % 3 == 0 {
    result.push_str("Pling");
  }

  if n % 5 == 0 {
    result.push_str("Plang");
  }

  if result.is_empty() {
    result = n.to_string()
  }

  result
}
