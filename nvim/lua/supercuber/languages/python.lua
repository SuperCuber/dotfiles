vim.cmd [[
augroup SupercuberPython
  au!
  au BufReadPost *.py call SetPythonMappings()
  au BufEnter *.py call SetPythonMappings()
augroup END

function SetPythonMappings()
  execute "nnoremap ,r :!python3 % -- "
endfunction
]]
