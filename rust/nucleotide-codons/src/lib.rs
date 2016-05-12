use std::collections::HashMap;

pub fn parse(pairs: Vec<(&str, &str)>) -> Codons {
    Codons { pairs: pairs.iter().map(|&(c, n)| (c.into(), n.into())).collect() }
}

pub struct Codons {
    pairs: HashMap<String, String>,
}

impl Codons {
    pub fn name_for(&self, shorthand: &str) -> Result<&str, ()> {
        self.pairs
            .iter()
            .find(|&(c, _)| c == shorthand)
            .map(|(_, n)| n)
            .ok_or(())
    }
}
