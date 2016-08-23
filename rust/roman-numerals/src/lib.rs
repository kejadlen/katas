pub struct Roman {
    n: usize,
}

impl From<usize> for Roman {
    fn from(n: usize) -> Roman {
        Roman { n: n }
    }
}

impl ToString for Roman {
    fn to_string(&self) -> String {
        "I".into()
    }
}
