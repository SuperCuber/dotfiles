vim.cmd [[
au BufReadPost *.py call SetPythonMappings()
au BufEnter *.py call SetPythonMappings()

function SetPythonMappings()
  execute "nnoremap ,r :!python3 % -- "
endfunction
]]
