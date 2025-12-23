return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function ()
        local languages = {
              "bash",
              "css",
              "html",
              "javascript",
              "json",
              "lua",
              "markdown",
              "markdown_inline",
              "python",
              "svelte",
              "tsx",
              "typescript",
        }

        require("nvim-treesitter").install(languages)

        vim.api.nvim_create_autocmd('FileType', {
          pattern = languages,
          callback = function() vim.treesitter.start() end,
        })

        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
}
