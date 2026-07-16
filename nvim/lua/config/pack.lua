-- PackChanged hooks must be defined BEFORE vim.pack.add()
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name = ev.data.spec.name
        local kind = ev.data.kind

        -- Run TSUpdate after treesitter install/update
        if
            name == "nvim-treesitter"
            and (kind == "install" or kind == "update")
        then
            if not ev.data.active then
                vim.cmd.packadd "nvim-treesitter"
            end
            vim.cmd "TSUpdate"
        end
    end,
})

local gh = function(x)
    return "https://github.com/" .. x
end

vim.pack.add {
    gh "nvim-tree/nvim-web-devicons",
    { src = gh "saghen/blink.cmp", version = vim.version.range "1.x" },
    gh "saghen/blink.indent",
    gh "rafamadriz/friendly-snippets",
    gh "nvim-treesitter/nvim-treesitter",
    gh "folke/ts-comments.nvim",
    gh "windwp/nvim-autopairs",
    gh "lewis6991/gitsigns.nvim",
    gh "rafamadriz/friendly-snippets",
    gh "nvim-neo-tree/neo-tree.nvim",
    gh "nvim-lua/plenary.nvim",
    gh "MunifTanjim/nui.nvim",

    gh "neovim/nvim-lspconfig",

    -- Colorscheme
    gh "metalelf0/jellybeans-nvim",
    gh "rktjmp/lush.nvim",
}

-- :PackUpdate — update all plugins without confirmation
vim.api.nvim_create_user_command("PackUpdate", function()
    vim.pack.update(nil, { force = true })
end, { desc = "Update all vim.pack plugins (no confirmation)" })

-- :PackClean — remove plugins that are installed but no longer in vim.pack.add()
vim.api.nvim_create_user_command("PackClean", function()
    local installed = vim.pack.get()
    local orphans = {}
    for _, plugin in ipairs(installed) do
        if not plugin.active then
            table.insert(orphans, plugin.spec.name)
        end
    end

    if #orphans == 0 then
        vim.notify("No unused plugins found", vim.log.levels.INFO)
        return
    end

    vim.ui.select(
        { "Yes", "No" },
        {
            prompt = "Remove "
                .. #orphans
                .. " unused plugin(s): "
                .. table.concat(orphans, ", ")
                .. "?",
        },
        function(choice)
            if choice == "Yes" then
                vim.pack.del(orphans)
                vim.notify(
                    "Removed " .. #orphans .. " plugin(s)",
                    vim.log.levels.INFO
                )
            end
        end
    )
end, { desc = "Remove unused vim.pack plugins" })

-- Auto-load all plugin configurations from lua/plugins/
local config_path = vim.fn.stdpath "config" .. "/lua/plugins"
for _, file in ipairs(vim.fn.glob(config_path .. "/*.lua", false, true)) do
    local module = file:match("lua/(.+)%.lua$"):gsub("/", ".")
    local ok, err = pcall(require, module)
    if not ok then
        vim.notify(
            "Error loading " .. module .. ": " .. err,
            vim.log.levels.WARN
        )
    end
end
