pub fn anagrams_for<'a>(word: &str, candidates: &'a [&str]) -> Vec<&'a str> {
    let fingerprint = fingerprint(word);

    println!("{:?}",
             candidates.iter()
                       .filter(|x| fingerprint(x) == fingerprint)
                       .collect());
    vec![]
}

fn fingerprint(s: &str) -> Vec<char> {
    let mut fingerprint: Vec<_> = s.chars().collect();
    fingerprint.sort();
    fingerprint
}
