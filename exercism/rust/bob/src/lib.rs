pub fn reply(s: &str) -> String {
  match Input::from(s) {
      Input::Asking => "Sure.",
      Input::Shouting => "Whoa, chill out!",
      Input::Silent => "Fine. Be that way!", 
      _ => "Whatever.",
    }
    .into()
}

enum Input {
  Asking,
  Shouting,
  Silent,
  AnythingElse,
}

impl<'a> From<&'a str> for Input {
  fn from(s: &str) -> Self {
    if s.is_empty() {
      return Input::Silent;
    }

    if s.chars().last() == Some('?') {
      return Input::Asking;
    }

    if s.chars().filter(|c| c.is_alphabetic()).all(|c| c.is_uppercase()) {
      return Input::Shouting;
    }

    Input::AnythingElse
  }
}
