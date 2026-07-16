local icons = require "config.icons"

require("blink.cmp").setup {
    appearance = {
        kind_icons = icons,
    },

    cmdline = {
        keymap = {
            preset = "inherit",
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-k>"] = { "select_prev", "fallback" },
        },
    },

    keymap = {
        preset = "default",
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<CR>"] = { "select_and_accept", "fallback" },
    },

    fuzzy = {
        implementation = "prefer_rust_with_warning",
        sorts = { "exact", "score", "sort_text" },
    },

    completion = {
        documentation = { auto_show = false },
        list = {
            selection = { preselect = false, auto_insert = false },
        },
    },

    sources = {
        default = { "lsp", "path" },
    },
}
