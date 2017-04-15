extern crate kilo;

#[macro_use]
extern crate error_chain;

use kilo::*;
use kilo::errors::*;

quick_main!(|| -> Result<()> {
    println!("Hello, world!");
    let key_presses = KeyPresses::new()?;
    for c in key_presses {
        match c {
            c if c == ctrl_key('q') => { return Ok(()) },
            c => {
                if c.is_control() {
                    println!("{}\r", c as u8);
                } else {
                    println!("{} {}\r", c as u8, c);
                }
            }
        }
    }

    Ok(())
});

fn ctrl_key(c: char) -> char {
    ((c as u8) & 0x1f) as char
}
