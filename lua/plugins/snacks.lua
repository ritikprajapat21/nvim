return {
    -- HACK: docs @ https://github.com/folke/snacks.nvim/blob/main/docs
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        -- NOTE: Options
        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()
                    -- Setup some globals for debugging (lazy-loaded)
                    _G.dd = function(...)
                        require('snacks').debug.inspect(...)
                    end
                    _G.bt = function()
                        require('snacks').debug.backtrace()
                    end
                    vim.print = _G.dd -- Override print to use snacks for `:=` command

                    -- Create some toggle mappings
                    require('snacks').toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                    require('snacks').toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                    -- require('snacks').toggle.diagnostics():map("<leader>d")
                    require('snacks').toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
                    require('snacks').toggle.treesitter():map("<leader>uT")
                    require('snacks').toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
                    require('snacks').toggle.inlay_hints():map("<leader>uh")
                    require('snacks').toggle.indent():map("<leader>ug")
                    require('snacks').toggle.dim():map("<leader>uD")
                end,
            })
        end,
        opts = {
            -- Styling for each Item of require('snacks')
            styles = {
                input = {
                    keys = {
                        n_esc = { "<C-c>", { "cmp_close", "cancel" }, mode = "n", expr = true },
                        i_esc = { "<C-c>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
                    },
                }
            },
            -- require('snacks') Modules
            input = {
                enabled = true,
            },
            quickfile = {
                enabled = true,
                exclude = { "latex" },
            },
            -- HACK: read picker docs @ https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
            scroll = {
                enabled = true,
            },
            picker = {
                enabled = true,
                matchers = {
                    frecency = true,
                    cwd_bonus = false,
                },
                formatters = {
                    file = {
                        filename_first = false,
                        filename_only = false,
                        icon_width = 2,
                    },
                },
                layout = {
                    -- presets options : "default" , "ivy" , "ivy-split" , "telescope" , "vscode", "select" , "sidebar"
                    -- override picker layout in keymaps function as a param below
                    preset = "telescope", -- defaults to this layout unless overidden
                    cycle = false,
                },
                layouts = {
                    select = {
                        preview = false,
                        layout = {
                            backdrop = false,
                            width = 0.6,
                            min_width = 80,
                            height = 0.4,
                            min_height = 10,
                            box = "vertical",
                            border = "rounded",
                            title = "{title}",
                            title_pos = "center",
                            { win = "input", height = 1, border = "bottom" },
                            { win = "list", border = "none" },
                            { win = "preview", title = "{preview}", width = 0.6, height = 0.4, border = "top" },
                        }
                    },
                    telescope = {
                        reverse = true, -- set to false for search bar to be on top 
                        layout = {
                            box = "horizontal",
                            backdrop = false,
                            width = 0.8,
                            height = 0.9,
                            border = "none",
                            {
                                box = "vertical",
                                { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
                                { win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
                            },
                            {
                                win = "preview",
                                title = "{preview:Preview}",
                                width = 0.50,
                                border = "rounded",
                                title_pos = "center",
                            },
                        },
                    },
                    ivy = {
                        layout = {
                            box = "vertical",
                            backdrop = false,
                            width = 0,
                            height = 0.4,
                            position = "bottom",
                            border = "top",
                            title = " {title} {live} {flags}",
                            title_pos = "left",
                            { win = "input", height = 1, border = "bottom" },
                            {
                                box = "horizontal",
                                { win = "list", border = "none" },
                                { win = "preview", title = "{preview}", width = 0.5, border = "left" },
                            },
                        },
                    },
                    explorer = {
                        layout = {
                            width = 0,
                        }
                    },
                }
            },
            image = {
                enabled = true,
                doc = {
                    float = false,
                    inline = true, -- if you want show image on cursor hover
                    max_width = 50,
                    max_height = 30,
                    wo = {
                        wrap = true,
                    },
                },
                convert = {
                    notify = true,
                    command = "magick"
                },
                img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments","Archives/All-Vault-Images/", "~/Library", "~/Downloads" },
            },
            dashboard = {
                enabled = true,
                sections = {
                    { section = "header" },
                    { section = "keys", gap = 1, padding = 1 },
                    { section = "startup" },
                },
            },
            explorer = {
                replace_netrw = true,
            },
        },
        -- NOTE: Keymaps
        keys = {
            { "<leader>e", function() require("snacks").explorer() end, desc = "Explorer" },
            { "<leader>lg", function() require("snacks").lazygit() end, desc = "Lazygit" },
            { "<leader>gl", function() require("snacks").lazygit.log() end, desc = "Lazygit Logs" },
            { "<leader>rN", function() require("snacks").rename.rename_file() end, desc = "Fast Rename Current File" },
            { "<leader>dB", function() require("snacks").bufdelete() end, desc = "Delete or Close Buffer  (Confirm)" },

            -- require('snacks') Picker
            { "<leader>ff", function() require("snacks").picker.files() end, desc = "Find Files (require('snacks') Picker)" },
            { "<leader>pc", function() require("snacks").picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
            { ";g", function() require("snacks").picker.grep() end, desc = "Grep word" },
            { "<leader>sw", function() require("snacks").picker.grep_word() end, desc = "Search Visual selection or Word", mode = { "n", "x" } },
            { "<leader>wk", function() require("snacks").picker.keymaps({ layout = "ivy" }) end, desc = "Search Keymaps (require('snacks') Picker)" },

            -- Git Stuff
            { "<leader>gbr", function() require("snacks").picker.git_branches({ layout = "select" }) end, desc = "Pick and Switch Git Branches" },

            -- Buffer
            {"<leader>x", function() require("snacks").bufdelete() end, desc = "Close current buffer" },
            {"<leader>X", function() require("snacks").bufdelete.other() end, desc = "Close other buffers except current" },

            -- Other Utils
            { "<leader>th" , function() require("snacks").picker.colorschemes({ layout = "ivy" }) end, desc = "Pick Color Schemes"},
            { ";h", function() require("snacks").picker.help() end, desc = "Help Pages" },
        }
    },
    -- NOTE: todo comments w/ snacks
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPre", "BufNewFile" },
        optional = true,
        keys = {
            { "<leader>pt", function() require("snacks").picker.todo_comments() end, desc = "Todo" },
            { "<leader>pT", function() require("snacks").picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
        },
    }
}
