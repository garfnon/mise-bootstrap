return {
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- leave Normal's background unset so kitty's background (and its opacity) shows through
      transparent = true,
      -- match kitty's near-black background override instead of the theme's blue one;
      -- base04/03/02 are the background tones used directly by menus, statusline, cursorline
      on_colors = function(colors)
        colors.base04 = "#090c0d"
        colors.base03 = "#121617"
        colors.base02 = "#1b2022"
        colors.bg = "#090c0d"
        colors.bg_popup = "#090c0d"
        colors.bg_float = "#090c0d"
        colors.bg_sidebar = "#090c0d"
        colors.bg_statusline = "#121617"
      end,
    },
  },
  { "LazyVim/LazyVim", opts = { colorscheme = "solarized-osaka" } },
}
