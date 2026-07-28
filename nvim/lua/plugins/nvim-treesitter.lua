require("nvim-treesitter.config").setup()

-- Ensure parsers are installed (idempotent - skips if already present)
require("nvim-treesitter").install {
    "svelte",
    "typescript",
}

-- In Neovim 0.12, treesitter highlight is managed natively
-- Enable it for all buffers with an available parser
vim.api.nvim_create_autocmd("FileType", {
    callback = function(ev)
        local ok = pcall(vim.treesitter.start, ev.buf)
        if not ok then
            return
        end
    end,
})
