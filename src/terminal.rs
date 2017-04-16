extern crate libc;

use std::io;
use std::io::prelude::*;
use std::mem;

use libc::*;

use errors::*;

pub fn key_presses() -> Result<KeyPresses> {
    let mut termios;
    unsafe {
        termios = mem::zeroed();
        if tcgetattr(STDIN_FILENO, &mut termios) == -1 {
            bail!(Error::with_chain(io::Error::last_os_error(), "tcgetattr"));
        }

        let mut raw = termios;
        raw.c_iflag &= !(BRKINT | ICRNL | INPCK | ISTRIP | IXON);
        raw.c_oflag &= !OPOST;
        raw.c_cflag |= CS8;
        raw.c_lflag &= !(ECHO | ICANON | IEXTEN | ISIG);
        raw.c_cc[VMIN] = 0;
        raw.c_cc[VTIME] = 1;

        if tcsetattr(STDIN_FILENO, TCSAFLUSH, &raw) == -1 {
            bail!(Error::with_chain(io::Error::last_os_error(), "tcsetattr"));
        }
    }

    let stdin = io::stdin();
    Ok(KeyPresses { stdin, termios })
}

pub fn window_size() -> Result<(usize, usize)> {
    let mut ws: winsize;
    unsafe {
        ws = mem::zeroed();

        if ioctl(STDOUT_FILENO, TIOCGWINSZ, &mut ws) == -1 {
            bail!(Error::with_chain(io::Error::last_os_error(), "window_size"));
        }

        if ws.ws_col == 0 {
            bail!("window_size");
        }
    }

    Ok((ws.ws_col as usize, ws.ws_row as usize))
}

pub struct KeyPresses {
    stdin: io::Stdin,
    termios: termios,
}

impl Drop for KeyPresses {
    fn drop(&mut self) {
        unsafe {
            tcsetattr(STDIN_FILENO, TCSAFLUSH, &self.termios);
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
