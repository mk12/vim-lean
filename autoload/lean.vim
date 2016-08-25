function! lean#replace()
	let user_gdefault = &gdefault
	try
		set nogdefault

		" ASCII keywords
		%s/\<not\>\.\@!/¬/ge
		%s/\<forall\>/∀/ge
		%s/\<exists\>\.\@!/∃/ge
		%s/\<fun\>/λ/ge
		%s/\<Pi\>/Π/ge
		%s/\<Sigma\>/∑/ge

		" ASCII symbols
		%s/\/\\/∧/ge
		%s/\\\//∨/ge
		%s/<->/↔/ge
		%s/->/→/ge
		%s/<=/≤/ge
		%s/>=/≥/ge
		%s/\~=/≠/ge

		" Escape sequences
		%s/\\S\>/Σ/ge
		%s/\\x\>/×/ge
		%s/\\u+/⊎/ge
		%s/\\N\>/ℕ/ge
		%s/\\Z\>/ℤ/ge
		%s/\\Q\>/ℚ/ge
		%s/\\R\>/ℝ/ge
		%s/\\-1\>/⁻¹/ge
		%s/\\tr\>/⬝/ge
		%s/\\t\>/▸/ge
		%s/\\in\>/∈/ge
		%s/\\nin\>/∉/ge
		%s/\\i\>/∩/ge
		%s/\\un\>/∪/ge
		%s/\\subeq\>/⊆/ge
		%s/\\comp\>/∘/ge
	finally
		let &gdefault = user_gdefault
	endtry
endfunction

function! lean#check()
	" Do nothing if we're in the output window.
	if &filetype == "lean-output"
		return
	endif

	" Find the output window for this buffer.
	let num = bufnr("%")
	let name = fnameescape(bufname("%"))
	let found = 0
	for i in range(1, winnr("$"))
		if getwinvar(i, "lean_check_num", -1) == num
			silent execute i . "wincmd w | %d"
			if &filetype != "lean-output"
				unlet w:lean_check_num
				break
			endif
			let found = 1
			break
		endif
	endfor

	" Create a new output window if there wasn't one.
	if !found
		below new
		let w:lean_check_num = num
	endif

	" Run lean and read in its output.
	silent execute "0read !lean " . name
	if line("$") == 1 && getline(1) == ""
		call append(line("^"), "No output")
	endif

	" Set options (do it every time just in case).
	setlocal buftype=nofile
	setlocal bufhidden=delete
	setlocal noswapfile
	setlocal filetype=lean-output

	" Return to the previous window.
	silent wincmd p
endfunction
