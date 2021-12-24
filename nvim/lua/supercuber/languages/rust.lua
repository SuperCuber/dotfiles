vim.cmd [[
au BufReadPost *.rs call SetRustMappings()
au BufEnter *.rs call SetRustMappings()
autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200)

command! -nargs=* Cargo :Dispatch cargo <args>
function SetRustMappings()
  nnoremap <buffer> <silent> <leader>m :Cargo clippy<cr>
  nnoremap <buffer> <silent> <leader>t :Cargo test<cr>
  execute "nnoremap <silent> <leader>r :FloatermNew cargo run -- "
endfunction
]]
