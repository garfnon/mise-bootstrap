return {
  {
    "UtkarshVerma/molokai.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      vim.o.background = "dark"
    end,
  },
  { "LazyVim/LazyVim", opts = { colorscheme = "molokai" } },
}
