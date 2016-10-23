function! lean#replace()
	let user_gdefault = &gdefault
	try
		set nogdefault

		" ASCII keywords
		%s/\C\%(prefix\s\+\)\@<!\<not\>\.\@!/¬/ge
		%s/\C\<forall\>/∀/ge
		%s/\C\<exists\>\.\@!/∃/ge
		%s/\C\<fun\>/λ/ge
		%s/\C\<Pi\>/Π/ge
		%s/\C\<Sigma\>/Σ/ge

		" ASCII symbols
		%s/\/\\/∧/ge
		%s/\\\//∨/ge
		%s/<->/↔/ge
		%s/->/→/ge
		%s/<=/≤/ge
		%s/>=/≥/ge
		%s/\~=/≠/ge

		" Escape sequences
		" ₀₁₂₃₄₅₆₇₈₉
		%s/\C\\_\?0\>/₀/ge
		%s/\C\\_\?1\>/₁/ge
		%s/\C\\_\?2\>/₂/ge
		%s/\C\\_\?3\>/₃/ge
		%s/\C\\_\?4\>/₄/ge
		%s/\C\\_\?5\>/₅/ge
		%s/\C\\_\?6\>/₆/ge
		%s/\C\\_\?7\>/₇/ge
		%s/\C\\_\?8\>/₈/ge
		%s/\C\\_\?9\>/₉/ge
		%s/\C\\S\>/Σ/ge
		%s/\C\\x\>/×/ge
		%s/\C\\u+/⊎/ge
		%s/\C\\N\>/ℕ/ge
		%s/\C\\Z\>/ℤ/ge
		%s/\C\\Q\>/ℚ/ge
		%s/\C\\R\>/ℝ/ge
		%s/\C\\-1\>/⁻¹/ge
		%s/\C\\tr\>/⬝/ge
		%s/\C\\t\>/▸/ge
		%s/\C\\in\>/∈/ge
		%s/\C\\nin\>/∉/ge
		%s/\C\\i\>/∩/ge
		%s/\C\\un\>/∪/ge
		%s/\C\\sub\>/⊂/ge
		%s/\C\\subeq\>/⊆/ge
		%s/\C\\comp\>/∘/ge
		%s/\C\\empty\>/∅/ge
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
