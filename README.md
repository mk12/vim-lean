# Vim Lean

This repository is a Pathogen/Vundle/Plug plugin for the [Lean Theorem Prover][1]. The files `ftdetect/lean.vim` and `syntax/lean.vim` are taken directly from the [official repository][2].

## Install

Set up [vim-plug][3], and then add the following to your `.vimrc`:

```vim
Plug 'mk12/vim-lean', { 'for': 'lean' }
```

## Usage

To use syntax highlighting, open a file with the `.lean` extension. To replace ASCII strings such as `forall`, `Pi`, and `->` with Unicode symbols, use the command `:LeanSymbolize`.

## License

The Lean Theorem Prover is available under the Apache License 2.0; see [LICENSE](LICENSE) for details.

[1]: https://github.com/leanprover/lean
[2]: https://github.com/leanprover/lean/tree/a8db8bc61a0b00379b3d0be8ecaf0d0858dc82ee/src/vim
[3]: https://github.com/junegunn/vim-plug