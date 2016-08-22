function! lean#replace()
	let user_gdefault = &gdefault
	try
		set nogdefault
		%s/\<Pi\>/Π/ge
		%s/\<fun\>/λ/ge
		%s/\<forall\>/∀/ge
		%s/\<exists\>/∃/ge
		%s/<->/↔/ge
		%s/->/→/ge
		%s/\~/¬/ge
		%s/\/\\/∧/ge
		%s/\\\//∨/ge
	finally    
		let &gdefault = user_gdefault
	endtry
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
		setlocal bufhidden=delete
		setlocal noswapfile
		setlocal filetype=lean-output
	endif
endfunction
