function! lean#replace()
	let user_gdefault = &gdefault
	try
		set nogdefault

		" ASCII
		%s/\/\\/∧/ge
		%s/\\\//∨/ge
		%s/<->/↔/ge
		%s/->/→/ge
		%s/<=/≤/ge
		%s/>=/≥/ge
		%s/\~=/≠/ge
		%s/\<not\>\.\@!/¬/ge
		%s/\<forall\>/∀/ge
		%s/\<exists\>\.\@!/∃/ge
		%s/\<fun\>/λ/ge
		%s/\<Pi\>/Π/ge
		%s/\<Sigma\>/∑/ge

		" Escape sequences
		%s/\\S\>/Σ/ge
		%s/\\x\>/×/ge
		%s/\\N\>/ℕ/ge
		%s/\\Z\>/ℤ/ge
		%s/\\Q\>/ℚ/ge
		%s/\\R\>/ℝ/ge
		%s/\\-1\>/⁻¹/ge
		%s/\\tr\>/⬝/ge
		%s/\\t\>/▸/ge
	finally
		let &gdefault = user_gdefault
	endtry
endfunction

" Dictionary that maps lean windows to lean-output windows
let s:dict = {}

function! lean#check()
	if &filetype == "lean-output"
		return
	endif

	let name = fnameescape(bufname("%"))
	let key = bufnr("%")
	if has_key(s:dict, key) && buflisted(s:dict[key][1])
		let nr = s:dict[key][0]
		silent execute nr . "wincmd w | %d | 0read !lean " . name
	else
		silent execute "below new | 0read !lean " . name
		let s:dict[key] = [winnr(), bufnr("%")]
	endif

	if line("$") == 1 && getline(1) == ""
		call append(line("^"), "No output")
	endif
	setlocal buftype=nofile
	setlocal bufhidden=delete
	setlocal noswapfile
	setlocal filetype=lean-output
	silent execute "wincmd p"
endfunction
