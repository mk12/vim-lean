function! lean#symbolize()
	silent execute "%!sed 's/forall/∀/;'"
endfunction

function! lean#check()
	new | execute "!lean " . bufname("%")
	setlocal buftype=nofile
	setlocal bufhidden=hide
	setlocal noswapfile
	setlocal filetype=lean-output
endfunction
