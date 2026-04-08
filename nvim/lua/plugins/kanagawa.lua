return {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        commentStyle = { italic = false },
        keywordStyle = { italic = false },
        theme = "dragon", -- Load "wave" theme
        background = { -- map the value of 'background' option to a theme
            dark = "dragon", -- try "dragon" !
            light = "lotus",
        },
    },
}
