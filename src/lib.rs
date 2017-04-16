#![recursion_limit = "1024"]

#[macro_use]
extern crate error_chain;
extern crate libc;

use std::io;
use std::io::prelude::*;
use std::mem;

pub mod errors;
use errors::*;

pub struct KeyPresses {
    stdin: io::Stdin,
    termios: libc::termios,
}

impl KeyPresses {
    pub fn new() -> Result<Self> {
        let mut termios;
        unsafe {
            termios = mem::zeroed();
            if libc::tcgetattr(libc::STDIN_FILENO, &mut termios) == -1 {
                bail!(Error::with_chain(io::Error::last_os_error(), "tcgetattr"));
            }

            let mut raw = termios;
            raw.c_iflag &= !(libc::BRKINT | libc::ICRNL | libc::INPCK | libc::ISTRIP | libc::IXON);
            raw.c_oflag &= !libc::OPOST;
            raw.c_cflag |= libc::CS8;
            raw.c_lflag &= !(libc::ECHO | libc::ICANON | libc::IEXTEN | libc::ISIG);
            raw.c_cc[libc::VMIN] = 0;
            raw.c_cc[libc::VTIME] = 1;

            if libc::tcsetattr(libc::STDIN_FILENO, libc::TCSAFLUSH, &raw) == -1 {
                bail!(Error::with_chain(io::Error::last_os_error(), "tcsetattr"));
            }
        }

        let stdin = io::stdin();
        Ok(Self { stdin, termios })
    }
}

impl Drop for KeyPresses {
    fn drop(&mut self) {
        unsafe {
            libc::tcsetattr(libc::STDIN_FILENO, libc::TCSAFLUSH, &self.termios);
        }
    }
}

impl Iterator for KeyPresses {
    type Item = char;

    fn next(&mut self) -> Option<char> {
        let mut buf: [u8; 1] = [0];
        loop {
            match self.stdin.read_exact(&mut buf) {
                Ok(_) => return Some(buf[0] as char),
                Err(ref e) if e.kind() != io::ErrorKind::UnexpectedEof => return None,
                _ => return Some(0 as char),
            }
        }
    }
}
