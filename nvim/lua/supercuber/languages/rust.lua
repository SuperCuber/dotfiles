vim.cmd [[
augroup SupercuberRust
  au!
  au BufReadPost *.rs call SetRustMappings()
  au BufEnter *.rs call SetRustMappings()
augroup END

command! -nargs=* Cargo :Dispatch cargo <args>
function SetRustMappings()
  nnoremap <buffer> <silent> ,m :Cargo clippy<cr>
  nnoremap <buffer> <silent> ,t :Cargo test<cr>
  execute "nnoremap <silent> ,r :FloatermNew cargo run -- "
endfunction
]]
