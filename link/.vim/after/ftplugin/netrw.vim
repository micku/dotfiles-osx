if !exists("g:customized_netrw")
  let g:customized_netrw = 1
  execute "nnoremap <buffer> l " . maparg("<CR>", "n")
  execute "nnoremap <buffer> h " . maparg("-", "n")
  "nnoremap <buffer> <CR> :
endif

