return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local treesitter = require "nvim-treesitter"
        treesitter.setup {
            -- enable syntax highlighting
            highlight = {
                enable = true,
                -- disable highlighting for large files
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats =
                        pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
            },
            -- enable indentation
            indent = { enable = false },
        }
        treesitter.install {
            "json",
            "javascript",
            "typescript",
            "tsx",
            "html",
            "css",
            "markdown",
            "markdown_inline",
            "svelte",
            "bash",
            "lua",
            "vim",
            "gitignore",
            "python",
        }
    end,
}
