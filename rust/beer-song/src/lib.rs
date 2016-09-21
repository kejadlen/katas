#![feature(range_contains)]

use std::fmt;

pub fn sing(start: usize, end: usize) -> String {
  Verse::new(start + 1)
    .iter()
    .take_while(|v| (end..start + 1).contains(v.count))
    .map(|v| v.to_string())
    .collect::<Vec<_>>()
    .join("\n")
}

pub fn verse(bottles: usize) -> String {
  Verse::new(bottles).to_string()
}

struct Verse {
  count: usize,
  noun_phrase: String,
  instruction: String,
}

impl Verse {
  fn new(count: usize) -> Self {
    let mut noun_phrase = if count == 0 {
      "no more".into()
    } else {
      count.to_string()
    };
    noun_phrase.push(' ');
    noun_phrase.push_str(if count == 1 { "bottle" } else { "bottles" });

    let instruction = match count {
      0 => "Go to the store and buy some more",
      1 => "Take it down and pass it around",
      _ => "Take one down and pass it around",
    };

    Verse {
      count: count,
      noun_phrase: noun_phrase.into(),
      instruction: instruction.into(),
    }
  }

  fn iter(&self) -> Verses {
    Verses { count: self.count }
  }
}

struct Verses {
  count: usize,
}

impl Iterator for Verses {
  type Item = Verse;

  fn next(&mut self) -> Option<Verse> {
    self.count = if self.count > 0 { self.count - 1 } else { 99 };
    Some(Verse::new(self.count))
  }
}

impl fmt::Display for Verse {
  fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
    let next = self.iter().next().unwrap();
    write!(f,
           "{capitalized_noun_phrase} of beer on the wall, {noun_phrase} of \
            beer.\n{instruction}, {next_noun_phrase} of beer on the wall.\n",
           capitalized_noun_phrase = capitalize(&self.noun_phrase),
           noun_phrase = self.noun_phrase,
           instruction = self.instruction,
           next_noun_phrase = next.noun_phrase)
  }
}

fn capitalize(s: &str) -> String {
  let mut c = s.chars();
  match c.next() {
    None => String::new(),
    Some(f) => f.to_uppercase().collect::<String>() + c.as_str(),
  }
}

#[test]
fn test_capitalize() {
  assert_eq!(capitalize(""), "");
  assert_eq!(capitalize("foo"), "Foo");
  assert_eq!(capitalize("Foo"), "Foo");
  assert_eq!(capitalize("FOO"), "FOO");
}
