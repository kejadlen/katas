#[derive(Debug)]
struct Anagram {
    word: String,
}

impl Anagram {
    fn new(s: &str) -> Anagram {
        Anagram { word: s.into() }
    }
}

impl PartialEq for Anagram {
    fn eq(&self, other: &Anagram) -> bool {
        let lhs = self.word.to_lowercase();
        let rhs = other.word.to_lowercase();

        lhs != rhs && lhs.sorted_chars() == rhs.sorted_chars()
    }
}

trait SortedChars {
    fn sorted_chars(&self) -> Vec<char>;
}

impl SortedChars for String {
    fn sorted_chars(&self) -> Vec<char> {
        let mut sorted_chars: Vec<_> = self.chars().collect();
        sorted_chars.sort();
        sorted_chars
    }
}

#[test]
fn anagram_equality() {
    assert!(Anagram::new("") != Anagram::new(""));
    assert_eq!(Anagram::new("omg"), Anagram::new("mog"));
}

pub fn anagrams_for<'a>(word: &str, candidates: &[&'a str]) -> Vec<&'a str> {
    let anagram = Anagram::new(word);

    candidates.iter()
              .map(|&x| x)
              .filter(|&x| Anagram { word: x.into() } == anagram)
              .collect::<Vec<_>>()
}
