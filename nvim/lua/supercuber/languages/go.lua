vim.cmd [[
augroup SupercuberGo
  au!
  au BufReadPost *.go call SetGoMappings()
  au BufEnter *.go call SetGoMappings()
augroup END

function SetGoMappings()
  nnoremap <buffer> <silent> ,m :Dispatch go build<cr>
  nnoremap <buffer> <silent> ,t :Dispatch go test<cr>
  nnoremap <buffer> <silent> ,r :FloatermNew go run .; read<left><left><left><left><left><left>
endfunction
]]
