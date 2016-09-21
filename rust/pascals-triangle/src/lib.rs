pub struct PascalsTriangle {
  row: u32,
}

impl PascalsTriangle {
  pub fn new(row: u32) -> Self {
    PascalsTriangle { row: row }
  }

  pub fn rows(&self) -> Vec<Vec<u32>> {
    if self.row == 0 {
      return Vec::new();
    }

    let last_rows = PascalsTriangle { row: self.row - 1 }.rows();
    let last_row = last_rows.last();
    let next_row = last_row.map(|row| {
        Some(0)
          .iter()
          .chain(row.iter())
          .chain(Some(0).iter())
          .collect::<Vec<_>>()
          .windows(2)
          .map(|pair| pair.iter().map(|&x| x).sum())
          .collect()
      })
      .unwrap_or(vec![1]);

    let mut rows = last_rows.clone();
    rows.push(next_row);
    rows
  }
}
