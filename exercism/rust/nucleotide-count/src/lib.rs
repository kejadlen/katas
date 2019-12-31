use std::collections::HashMap;

pub fn nucleotide_counts(dna: &str) -> HashMap<char, usize> {
    let mut result = HashMap::new();
    for c in vec!['A', 'C', 'G', 'T'] {
        result.insert(c, 0);
    }
    for c in dna.chars() {
        let count = result.entry(c).or_insert(0);
        *count += 1;
    }
    result
}

pub fn count(nucleotide: char, dna: &str) -> usize {
    nucleotide_counts(dna).get(&nucleotide).cloned().unwrap_or(0)
}
