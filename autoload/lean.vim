function! lean#replace()
	execute '%s/\<Pi\>/Π/ge'
	execute '%s/\<fun\>/λ/ge'
	execute '%s/\<forall\>/∀/ge'
	execute '%s/\<exists\>/∃/ge'
	execute '%s/<->/↔/ge'
	execute '%s/->/→/ge'
	execute '%s/\~/¬/ge'
	execute '%s/\/\\/∧/ge'
	execute '%s/\\\//∨/ge'
endfunction

function! lean#check()
	if &filetype == "lean-output"
		return
	endif
	silent execute "below new | 0read !lean #"
	if line("$") == 1 && getline(1) == ""
		bdel
	else
		setlocal buftype=nofile
		setlocal bufhidden=hide
		setlocal noswapfile
		setlocal filetype=lean-output
	endif
endfunction
