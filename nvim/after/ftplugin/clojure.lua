vim.g["conjure#mapping#doc_word"] = false
{{#if (eq dotter.os "windows")}}
vim.api.nvim_create_user_command("Lein", function(_)
    local command =
    [[lein update-in :dependencies conj "[refactor-nrepl/refactor-nrepl \"3.6.0\"]" -- update-in :repl-options:nrepl-middleware conj refactor-nrepl.middleware/wrap-refactor -- update-in :plugins conj "[cider/cider-nrepl \"0.30.0\"]" -- repl]]
    vim.cmd.tabnew()
    vim.cmd.term(command)
    vim.cmd.tabprevious()
end, {})
{{/if}}
