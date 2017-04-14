#![feature(io)]

extern crate libc;

use std::io;
use std::io::prelude::*;
use std::mem;

fn main() {
    println!("Hello, world!");
    setup_terminal(|| {
                       let stdin = io::stdin();
                       let chars = stdin.chars().flat_map(|x| x).take_while(|c| *c != 'q');
                       for c in chars {
                           println!("{}", c);
                       }
                   });
}

fn setup_terminal<F>(f: F)
    where F: Fn() -> ()
{
    let mut original_termios: libc::termios;
    unsafe {
        original_termios = mem::zeroed();
        libc::tcgetattr(libc::STDIN_FILENO, &mut original_termios);

        let mut raw = original_termios.clone();
        raw.c_lflag &= !libc::ECHO;
        libc::tcsetattr(libc::STDIN_FILENO, libc::TCSAFLUSH, &raw);
    }

    f();

    unsafe {
        libc::tcsetattr(libc::STDIN_FILENO, libc::TCSAFLUSH, &original_termios);
    }
}
