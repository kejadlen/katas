#![feature(io)]

extern crate libc;

use std::io;
use std::io::prelude::*;
use std::mem;

fn main() {
    enable_raw_mode();

    println!("Hello, world!");

    let stdin = io::stdin();
    let chars = stdin.chars().flat_map(|x| x).take_while(|c| *c != 'q');
    for c in chars {
        println!("{}", c);
    }
}

fn enable_raw_mode() {
    unsafe {
        let mut raw: libc::termios = mem::zeroed();
        libc::tcgetattr(libc::STDIN_FILENO, &mut raw);
        raw.c_lflag &= !libc::ECHO;
        libc::tcsetattr(libc::STDIN_FILENO, libc::TCSAFLUSH, &raw);
    }
}
