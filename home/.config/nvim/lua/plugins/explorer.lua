vim.api.nvim_create_autocmd("VimEnter", {
  callback = function(data)
    -- directories are already handled by snacks' replace_netrw
    if vim.fn.isdirectory(data.file) == 0 then
      Snacks.explorer()
    end
  end,
})

return {
  { import = "lazyvim.plugins.extras.editor.snacks_explorer" },
}
