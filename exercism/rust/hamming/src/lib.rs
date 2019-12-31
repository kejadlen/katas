pub fn hamming_distance<'a>(a: &str, b: &str) -> Result<usize, &'a str> {
    if a.len() != b.len() {
        return Err("inputs of different length");
    }

    Ok(a.chars().zip(b.chars()).filter(|&(a, b)| a != b).count())
}
