use std::collections::HashMap;

pub fn word_count(s: &str) -> HashMap<String, u32> {
    let mut result = HashMap::new();
    for word in String::from(s)
                    .split(char::is_not_alphanumeric)
                    .filter(|x| !x.is_empty()) {
        let count = result.entry(word.to_lowercase()).or_insert(0);
        *count += 1;
    }
    result
}

trait WordCount {
    fn is_not_alphanumeric(self) -> bool;
}

impl WordCount for char {
    fn is_not_alphanumeric(self) -> bool {
        !self.is_alphanumeric()
    }
}
