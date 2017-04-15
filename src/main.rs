extern crate libc;

use std::io;
use std::io::prelude::*;
use std::mem;

fn main() {
    println!("Hello, world!");
    let keystrokes = Keystrokes::new();
    for c in keystrokes.take_while(|c| *c != 'q') {
        if c.is_control() {
            println!("{}\r", c as u8);
        } else {
            println!("{} {}\r", c as u8, c);
        }
    }
}

struct Keystrokes {
    stdin: io::Stdin,
    termios: libc::termios,
}

impl Keystrokes {
    fn new() -> Self {
        let mut termios;
        unsafe {
            termios = mem::zeroed();
            libc::tcgetattr(libc::STDIN_FILENO, &mut termios);

            let mut raw = termios;
            raw.c_iflag &= !(libc::BRKINT | libc::ICRNL | libc::INPCK | libc::ISTRIP | libc::IXON);
            raw.c_oflag &= !libc::OPOST;
            raw.c_cflag |= libc::CS8;
            raw.c_lflag &= !(libc::ECHO | libc::ICANON | libc::IEXTEN | libc::ISIG);
            raw.c_cc[libc::VMIN] = 0;
            raw.c_cc[libc::VTIME] = 1;

            libc::tcsetattr(libc::STDIN_FILENO, libc::TCSAFLUSH, &raw);
        }

        let stdin = io::stdin();
        Self { stdin, termios }
    }
}

impl Drop for Keystrokes {
    fn drop(&mut self) {
        unsafe {
            libc::tcsetattr(libc::STDIN_FILENO, libc::TCSAFLUSH, &self.termios);
        }
    }
}

impl Iterator for Keystrokes {
    type Item = char;

    fn next(&mut self) -> Option<char> {
        let mut buf: [u8; 1] = [0];
        loop {
            if self.stdin.read_exact(&mut buf).is_ok() {
                return Some(buf[0] as char);
            }
        }
    }
}
