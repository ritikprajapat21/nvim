return {
  "folke/tokyonight.nvim",
  opts = {
    transparent = true,
    on_highlights = function(hl)
      hl.DiagnosticUnnecessary = {
        fg = "#636da6",
      }
    end,
  },
}
