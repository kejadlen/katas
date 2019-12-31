#[derive(Debug, PartialEq)]
enum Nucleotide {
    Adenine,
    Cytosine,
    Guanine,
    Thymine,
    Uracil,
}

fn nucleotides_from_string(s: &str) -> Vec<Nucleotide> {
    s.chars()
     .map(|c| match c {
         'A' => Nucleotide::Adenine,
         'C' => Nucleotide::Cytosine,
         'G' => Nucleotide::Guanine,
         'T' => Nucleotide::Thymine,
         'U' => Nucleotide::Uracil,
         _ => unreachable!(),
     })
     .collect()
}

#[derive(Debug)]
pub struct DeoxyribonucleicAcid {
    dna: Vec<Nucleotide>,
}

impl DeoxyribonucleicAcid {
    pub fn new(s: &str) -> DeoxyribonucleicAcid {
        DeoxyribonucleicAcid { dna: nucleotides_from_string(s) }
    }

    pub fn to_rna(&self) -> RibonucleicAcid {
        RibonucleicAcid {
            rna: self.dna
                     .iter()
                     .map(|x| match *x {
                         Nucleotide::Guanine => Nucleotide::Cytosine,
                         Nucleotide::Cytosine => Nucleotide::Guanine,
                         Nucleotide::Thymine => Nucleotide::Adenine,
                         Nucleotide::Adenine => Nucleotide::Uracil,
                         _ => unreachable!(),
                     })
                     .collect(),
        }
    }
}

#[derive(Debug, PartialEq)]
pub struct RibonucleicAcid {
    rna: Vec<Nucleotide>,
}

impl RibonucleicAcid {
    pub fn new(s: &str) -> RibonucleicAcid {
        RibonucleicAcid { rna: nucleotides_from_string(s) }
    }
}
