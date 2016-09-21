pub struct PascalsTriangle {
  row: u32,
}

impl PascalsTriangle {
  pub fn new(row: u32) -> Self {
    PascalsTriangle { row: row }
  }

  pub fn rows(&self) -> Vec<Vec<u32>> {
    match self.row {
      0 => Vec::new(),
      1 => vec![vec![1]],
      _ => Vec::new(),
    }
  }
}
