#![feature(associated_consts)]

#[derive(Clone, Copy, Debug, PartialEq)]
pub enum Allergen {
    Cats,
    Chocolate,
    Eggs,
    Peanuts,
    Pollen,
    Shellfish,
    Strawberries,
    Tomatoes,
}

#[derive(Debug)]
pub struct Allergies {
    allergies: Vec<Allergen>,
}

impl Allergies {
    const ALLERGY_MAP: [Allergen; 8] = [Allergen::Eggs,
                                        Allergen::Peanuts,
                                        Allergen::Shellfish,
                                        Allergen::Strawberries,
                                        Allergen::Tomatoes,
                                        Allergen::Chocolate,
                                        Allergen::Pollen,
                                        Allergen::Cats];

    pub fn new(n: usize) -> Allergies {
        let allergy_map = Self::ALLERGY_MAP;
        let allergies = allergy_map.iter()
                                   .enumerate()
                                   .filter(|&(i, _)| {
                                       n & 2usize.pow(i as u32) > 0
                                   })
                                   .map(|(_, a)| a.clone())
                                   .collect::<Vec<Allergen>>();
        Allergies { allergies: allergies }
    }

    pub fn allergies(&self) -> Vec<Allergen> {
        self.allergies.clone()
    }

    pub fn is_allergic_to(&self, a: &Allergen) -> bool {
        self.allergies.contains(a)
    }
}
