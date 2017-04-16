extern crate kilo;

#[macro_use]
extern crate error_chain;

use std::io::{self, Write};

use kilo::*;
use kilo::errors::*;

quick_main!(|| -> Result<()> {
    cleanup_after(|| {
        let key_presses = KeyPresses::new()?;
        for c in key_presses {
            refresh_screen();
            match c {
                c if c == ctrl_key('q') => return Ok(()),
                c => { println!("{} {}", c as usize, c); }
            }
        }

        Ok(())
    })
});

fn cleanup_after<F>(f: F) -> Result<()>
    where F: Fn() -> Result<()>
{
    let result = f();
    clear_screen();
    result
}


fn clear_screen() {
    print!("\x1b[2J");
    print!("\x1b[H");
}

fn refresh_screen() {
    clear_screen();
    draw_rows();
    print!("\x1b[H");
}

fn draw_rows() {
}

fn ctrl_key(c: char) -> char {
    ((c as u8) & 0x1f) as char
}
