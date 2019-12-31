pub fn parse<'a>(pairs: Vec<(&'a str, &'a str)>) -> Codons<'a> {
    Codons { pairs: pairs.iter().map(|x| Codon::new(x)).collect() }
}

pub struct Codons<'a> {
    pairs: Vec<Codon<'a>>,
}

impl<'a> Codons<'a> {
    pub fn name_for(&self, shorthand: &str) -> Result<&str, ()> {
        if shorthand.is_empty() {
            return Err(());
        }

        self.pairs
            .iter()
            .find(|ref x| x.matches(shorthand))
            .map(|ref x| x.name)
            .ok_or(())
    }
}

struct Codon<'a> {
    codon: &'a str,
    name: &'a str,
}

impl<'a> Codon<'a> {
    fn new(raw: &(&'a str, &'a str)) -> Codon<'a> {
        Codon {
            codon: raw.0,
            name: raw.1,
        }
    }

    fn matches(&self, shorthand: &str) -> bool {
        shorthand.chars().zip(self.codon.chars()).all(|(a, b)| {
            match a {
                'H' => vec!['A', 'C', 'T'],
                'M' => vec!['A', 'C'],
                'N' => vec!['A', 'C', 'G', 'T'],
                'R' => vec!['A', 'G'],
                'Y' => vec!['C', 'T'],
                _ => vec![a],
            }
            .contains(&b)
        })
    }
}
