function! lean#replace()
	let user_gdefault = &gdefault
	try
		set nogdefault

		" standard
		%s/\~=/≠/ge
		%s/\~/¬/ge
		%s/\/\\/∧/ge
		%s/\\\//∨/ge
		%s/<->/↔/ge
		%s/->/→/ge
		%s/<=/≤/ge
		%s/>=/≥/ge
		%s/\<forall\>/∀/ge
		%s/\<exists\>\.\@!/∃/ge
		%s/\<fun\>/λ/ge
		%s/\<Pi\>/Π/ge
		%s/\<Sigma\>/∑/ge

		" nonstandard
		%s/|>/▸/ge
		%s/\^-1/⁻¹/ge
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
