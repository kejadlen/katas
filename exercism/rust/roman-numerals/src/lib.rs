use std::iter;

pub struct Roman {
  n: usize,
}

impl Roman {
  fn original_mapping() -> Vec<(usize, char)> {
    vec![
      (1_000, 'M'),
      (500, 'D'),
      (100, 'C'),
      (50, 'L'),
      (10, 'X'),
      (5, 'V'),
      (1, 'I'),
    ]
  }

  fn subtractive_replacements() -> Vec<(String, String)> {
    vec![
      ("DCCCC", "CM"),
      ("CCCC", "CD"),
      ("LXXXX", "XC"),
      ("XXXX", "XL"),
      ("VIIII", "IX"),
      ("IIII", "IV"),
    ]
      .iter()
      .map(|&(x, y)| (x.into(), y.into()))
      .collect()
  }
}

impl From<usize> for Roman {
  fn from(n: usize) -> Roman {
    Roman { n: n }
  }
}

impl ToString for Roman {
  fn to_string(&self) -> String {
    let mut current = self.n.clone();
    let mut original = Self::original_mapping()
      .iter()
      .map(|&(i, c)| {
        let n = current / i;
        current -= n * i;
        iter::repeat(c).take(n).collect::<String>()
      })
      .collect::<String>();
    for (x, y) in Self::subtractive_replacements() {
      original = original.replace(&x, &y);
    }
    original
  }
}
