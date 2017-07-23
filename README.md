# Vim Lean

This repository is a Pathogen/Vundle/Plug plugin for the [Lean Theorem Prover][1]. The files `ftdetect/lean.vim` and `syntax/lean.vim` are taken directly from the [official lean.vim plugin][2].

## Install

Set up [vim-plug][3], and then add the following to your `.vimrc`:

```vim
Plug 'mk12/vim-lean', { 'for': 'lean' }
```

## Usage

Why use this instead of the official plugin? Because it provides two useful commands:

- `:LeanReplace`: Replace `forall`, `Pi`, `->`, etc., with Unicode characters.
- `:LeanCheck`: Run lean on the file and show the output in a split (if there is any).

Put `let g:lean_auto_replace = 1` in your `vimrc` if you want to run `:LeanReplace` automatically on every save.

## License

The Lean Theorem Prover is available under the Apache License 2.0; see [LICENSE](LICENSE) for details.

[1]: https://github.com/leanprover/lean
[2]: https://github.com/leanprover/lean.vim
[3]: https://github.com/junegunn/vim-plug
