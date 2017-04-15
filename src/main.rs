extern crate kilo;

#[macro_use]
extern crate error_chain;

use kilo::*;
use kilo::errors::*;

quick_main!(|| -> Result<()> {
    run(|| {
        let key_presses = KeyPresses::new()?;
        for c in key_presses {
            refresh_screen();
            match c {
                c if c == ctrl_key('q') => return Ok(()),
                c => {}
            }
        }

        Ok(())
    })
});

fn run<F>(f: F) -> Result<()>
    where F: Fn() -> Result<()>
{
    clear_screen();
    let result = f();
    clear_screen();
    result
}


fn clear_screen() {
    println!("\x1b[2J");
    println!("\x1b[H");
}

fn refresh_screen() {
    clear_screen();
}

fn ctrl_key(c: char) -> char {
    ((c as u8) & 0x1f) as char
}
