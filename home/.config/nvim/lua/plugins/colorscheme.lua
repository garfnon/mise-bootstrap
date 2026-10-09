return {
  {
    "maxmx03/solarized.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      vim.o.background = "dark"
    end,
    opts = {
      -- Black background instead of Solarized's blue-teal base03/base04;
      -- base02 (cursorline, selection) becomes a neutral dark grey to match.
      -- base0 (default text) is lightened to #a3aeae to match Ghostty's foreground.
      on_colors = function()
        return { base03 = "#000000", base04 = "#000000", base02 = "#1c1c1c", base0 = "#a3aeae" }
      end,
    },
  },
  { "LazyVim/LazyVim", opts = { colorscheme = "solarized" } },
}
