-- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
return {
  "jsongerber/nvim-px-to-rem",
  -- config = true,
  --If you need to set some options replace the line above with:
  config = function()
    require("nvim-px-to-rem").setup({
      root_font_size = 16,
      decimal_count = 4,
      show_virtual_text = true,
      add_cmp_source = false,
      filetypes = {
        "css",
        "scss",
        "sass",
      },
    })
    -- Convert px to rem under cursor
    vim.api.nvim_set_keymap("n", "<leader>pxx", ":PxToRemCursor<CR>", { noremap = true })
    -- Convert px to rem on the whole line
    vim.api.nvim_set_keymap("n", "<leader>pxl", ":PxToRemLine<CR>", { noremap = true })
    -- Convert px to rem on all the selected lines
    vim.api.nvim_set_keymap("v", "<leader>px", ":PxToRemLine<CR>", { noremap = true })
  end,
}
