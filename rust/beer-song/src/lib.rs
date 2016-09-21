pub fn sing(start: usize, end: usize) -> String {
  "".into()
}

pub fn verse(bottles: usize) -> String {
  let mut verse = match bottles {
    0 => {
      "No more bottles of beer on the wall, no more bottles of beer.
Go to the store and buy some more, 99 bottles of beer on the wall."
        .into()
    }
    1 => {
      "1 bottle of beer on the wall, 1 bottle of beer.
Take it down and pass it around, no more bottles of beer on the wall."
        .into()
    }
    2 => {
      "2 bottles of beer on the wall, 2 bottles of beer.
Take one down and pass it around, 1 bottle of beer on the wall."
        .into()
    }
    _ => {
      format!("{} bottles of beer on the wall, {} bottles of beer.
Take one down and pass it around, {} bottles of beer on the wall.",
              bottles,
              bottles,
              bottles - 1)
    }
  };
  verse.push('\n');
  verse
}
