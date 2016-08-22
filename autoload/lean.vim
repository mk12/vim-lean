function! s:Symbolize()
	silent execute "!sed 's/forall/∀/;' " . bufname("%")
endfunction
