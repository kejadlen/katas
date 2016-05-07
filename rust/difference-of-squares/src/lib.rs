#![feature(inclusive_range_syntax)]

pub fn difference(i: usize) -> usize {
    square_of_sum(i) - sum_of_squares(i)
}

pub fn square_of_sum(i: usize) -> usize {
    (1...i).fold(0, |acc, x| acc + x).pow(2)
}

pub fn sum_of_squares(i: usize) -> usize {
    (1...i).fold(0, |acc, x| acc + x.pow(2))
}
