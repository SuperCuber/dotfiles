vim.api.nvim_create_user_command("NS", function(opts)
    local namespace = opts.fargs[1]
    local rw = opts.fargs[2]
    if rw == "w" then
        vim.cmd("w !http put 'http://n8s-api-default.euw1.n8s.appsflyer.engineering:8080/v2/namespaces/" ..
        namespace .. "'")
    elseif rw == "r" then
        vim.cmd("%d")
        vim.cmd("r !http get 'http://n8s-api-default.euw1.n8s.appsflyer.engineering:8080/v2/namespaces/" ..
        namespace .. "' | jq .")
    else
        vim.api.nvim_echo({ {"Invalid command '" .. rw .. "'"} }, true, { err = true })
    end
end, { nargs = "*", force = true })

vim.api.nvim_create_user_command("Json", function(_)
    vim.o.filetype = "json"
    vim.cmd("%!jq .")
end, { nargs = 0, force = true })
