extern crate kilo;

#[macro_use]
extern crate error_chain;
extern crate libc;

use kilo::*;
use kilo::errors::*;

quick_main!(|| -> Result<()> {
    cleanup_after(|| {
        let key_presses = terminal::key_presses()?;
        for c in key_presses {
            refresh_screen();
            match c {
                c if c == ctrl_key('q') => return Ok(()),
                _ => {}
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
    for _ in 0..24 {
        println!("~\r");
    }
}

fn ctrl_key(c: char) -> char {
    ((c as u8) & 0x1f) as char
}
