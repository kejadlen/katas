use std::collections::HashMap;

pub fn score(s: &str) -> usize {
  Scrabble::new().score(s)
}

struct Scrabble {
  letter_values: HashMap<char, usize>,
}

impl Scrabble {
  fn new() -> Self {
    let letter_values = [("aeioulnrst", 1),
                         ("dg", 2),
                         ("bcmp", 3),
                         ("fhvwy", 4),
                         ("k", 5),
                         ("jx", 8),
                         ("qz", 10)]
      .iter()
      .flat_map(|&(x, v)| x.chars().map(move |c| (c, v)))
      .collect();
    Scrabble { letter_values: letter_values }
  }

  fn score(&self, s: &str) -> usize {
    s.to_lowercase()
      .chars()
      .map(|c| self.letter_values.get(&c).map(|&x| x).unwrap_or(0 as usize))
      .sum()
  }
}
