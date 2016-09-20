use std::iter;

pub struct Roman {
  n: usize,
}

impl Roman {
  fn mapping() -> Vec<(usize, char)> {
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
}

impl From<usize> for Roman {
  fn from(n: usize) -> Roman {
    Roman { n: n }
  }
}

impl ToString for Roman {
  fn to_string(&self) -> String {
    let mut current = self.n.clone();
    Self::mapping()
      .iter()
      .map(|&(i, c)| {
        let n = current / i;
        current -= n * i;
        iter::repeat(c).take(n).collect::<String>()
      })
      .collect::<String>()
      .replace("DCCCC", "CM")
      .replace("CCCC", "CD")
      .replace("LXXXX", "XC")
      .replace("XXXX", "XL")
      .replace("VIIII", "IX")
      .replace("IIII", "IV")
  }
}
