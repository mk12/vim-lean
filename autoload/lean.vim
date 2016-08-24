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

" Dictionary that maps lean windows to lean-output windows
let s:dict = {}

function! lean#check()
	if &filetype == "lean-output"
		return
	endif

	let name = fnameescape(bufname("%"))
	let key = tabpagenr() . "," . winnr()
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
