vim.cmd [[
au BufReadPost *.py call SetPythonMappings()
au BufEnter *.py call SetPythonMappings()

function SetPythonMappings()
  execute "nnoremap <leader>r :!python3 % -- "
endfunction
]]
