use std::collections::HashMap;

pub fn word_count(s: &str) -> HashMap<String, u32> {
    let mut result = HashMap::new();
    for word in String::from(s).alphanumeric_tokens() {
        let count = result.entry(word.to_lowercase()).or_insert(0);
        *count += 1;
    }
    result
}

trait AlphaNumericSplitter {
    fn alphanumeric_tokens(&self) -> Vec<String>;
}

impl AlphaNumericSplitter for String {
    fn alphanumeric_tokens(&self) -> Vec<String> {
        let mut result = Vec::new();
        let mut current = String::new();
        for c in self.chars() {
            if c.is_alphanumeric() {
                current.push(c);
            } else if !current.is_empty() {
                result.push(current);
                current = String::new();
            }
        }
        if !current.is_empty() {
            result.push(current);
        }
        result
    }
}
