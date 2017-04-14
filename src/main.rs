extern crate libc;

use std::io;
use std::io::prelude::*;
use std::mem;

fn main() {
    println!("Hello, world!");
    setup_terminal(|| {
        let mut stdin = io::stdin();
        let mut buf: [u8; 1] = [0];
        loop {
            stdin.read_exact(&mut buf);
            let c = buf[0] as char;
            if c.is_control() {
                println!("{}\r", c as u8);
            } else {
                println!("{} {}\r", c as u8, c);
            }
            if c == 'q' {
                return;
            }
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

        let mut raw = original_termios;
        raw.c_iflag &= !(libc::BRKINT | libc::ICRNL | libc::INPCK | libc::ISTRIP | libc::IXON);
        raw.c_oflag &= !libc::OPOST;
        raw.c_cflag |= libc::CS8;
        raw.c_lflag &= !(libc::ECHO | libc::ICANON | libc::IEXTEN | libc::ISIG);
        raw.c_cc[libc::VMIN] = 0;
        raw.c_cc[libc::VTIME] = 1;

        libc::tcsetattr(libc::STDIN_FILENO, libc::TCSAFLUSH, &raw);
    }

    f();

    unsafe {
        libc::tcsetattr(libc::STDIN_FILENO, libc::TCSAFLUSH, &original_termios);
    }
}
