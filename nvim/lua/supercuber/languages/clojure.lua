vim.cmd [[
augroup SupercuberClojure
  au!
  au BufReadPost *.clj call SetClojureMappings()
  au BufEnter *.clj call SetClojureMappings()
augroup END

function SetClojureMappings()
  nnoremap <buffer> <silent> ,t :Dispatch lein test<cr>
endfunction
]]
