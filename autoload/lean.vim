function! lean#symbolize()
	execute '%s/\<->\>/→/ge'
	execute '%s/\<Pi\>/Π/ge'
	execute '%s/\<fun\>/λ/ge'
	execute '%s/\<\~\>/¬/ge'
	execute '%s/\<\/\\\>/∧/ge'
	execute '%s/\<\\\/\>/∨/ge'
	execute '%s/\<<->\>/↔/ge'
	execute '%s/\<forall\>/∀/ge'
	execute '%s/\<exists\>/∃/ge'
endfunction

function! lean#check()
	if &filetype == "lean-output"
		return
	endif
	silent execute "below new | 0read !lean #"
	setlocal buftype=nofile
	setlocal bufhidden=hide
	setlocal noswapfile
	setlocal filetype=lean-output
endfunction

