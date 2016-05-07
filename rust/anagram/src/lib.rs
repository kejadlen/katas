#[derive(Debug)]
struct Anagram {
    word: String,
}

impl Anagram {
    fn new(s: &str) -> Anagram {
        Anagram { word: s.into() }
    }

    fn sorted_chars(s: &str) -> Vec<char> {
        let mut sorted_chars: Vec<_> = s.to_lowercase().chars().collect();
        sorted_chars.sort();
        sorted_chars
    }
}

impl PartialEq for Anagram {
    fn eq(&self, other: &Anagram) -> bool {
        self.word.to_lowercase() != other.word.to_lowercase() &&
        Self::sorted_chars(&self.word) == Self::sorted_chars(&other.word)
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
