return {
  "folke/tokyonight.nvim",
  opts = {
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
    on_highlights = function(hl)
      hl.DiagnosticUnnecessary = {
        fg = "#636da6",
      }
    end,
  },
}
