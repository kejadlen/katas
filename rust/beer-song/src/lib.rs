pub fn sing(start: usize, end: usize) -> String {
  "".into()
}

pub fn verse(bottles: usize) -> String {
  if bottles > 0 {
      "1 bottle of beer on the wall, 1 bottle of beer.
Take it down and pass it around, no more bottles of beer on the wall.
"
    } else {
      "No more bottles of beer on the wall, no more bottles of beer.
Go to the store and buy some more, 99 bottles of beer on the wall.
"
    }
    .into()
}
