" local status_ok = pcall(require, "blame")
" if not status_ok then
" 	return
" end

let g:gitblame_date_format = '%r'
let g:gitblame_message_when_not_committed = '  Uncommitted changes'
let g:gitblame_delay = 250 "0.25 second"
