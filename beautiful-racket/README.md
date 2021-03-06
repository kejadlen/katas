# Beautiful Racket

## Getting Started

```sh
$ brew install minimal-racket

$ raco pkg install --auto readline
$ raco pkg install --auto beautiful-racket
```

## Vim Plugins

- [vim-racket](https://github.com/wlangstroth/vim-racket)
- [vim-sexp](https://github.com/guns/vim-sexp)
- [~~rainbow_parentheses.vim~~](https://github.com/kien/rainbow_parentheses.vim)
- [rainbow](https://github.com/luochen1990/rainbow)
- [scribble.vim](https://github.com/vim-scripts/scribble.vim)

In .vim/after/ftplugin/racket.vim:

```vim
au BufEnter * RainbowToggleOn
setlocal lispwords+=define-macro,with-handlers,with-pattern
```

In `.vim/ftdetect/scribble.vim`:

```vim
au BufRead,BufNewFile *.scrbl set filetype=scribble
```

In `.vim/after/ftplugin/scribble.vim`:

```vim
set makeprg=scribble\ --dest\ scribble\ %
```

### Annoyances

- Escaped parentheses break (`|(|` and `|)|`) break syntax
  highlighting/indentation.

## Staying Updated

```sh
$ raco pkg update --update-deps beautiful-racket
```

## Packages

```sh
$ raco pkg install
$ raco pkg uninstall
```

## REPL

```sh
$ racket
Welcome to Racket v6.10.
> ,enter tokenizer.rkt
```
