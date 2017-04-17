extern crate kilo;

#[macro_use]
extern crate error_chain;
extern crate libc;

use kilo::*;
use kilo::errors::*;

quick_main!(|| -> Result<()> {
    let display = terminal::Display::new()?;
    let key_presses = terminal::key_presses()?;
    for c in key_presses {
        display.refresh();
        match c {
            c if c == ctrl_key('q') => return Ok(()),
            _ => {}
        }
    }

    Ok(())
});

fn ctrl_key(c: char) -> char {
    ((c as u8) & 0x1f) as char
}
