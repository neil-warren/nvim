require("rose-pine").setup({
    variant = "main",
    disable_background = true,
    extend_background_behind_borders = true,

    styles = {
        bold = true,
        italic = true,
        transparency = true,
    },

    highlight_groups = {
        CursorLineNr = { fg = "foam", bold = true },
    },
})

function SetupColors(color)
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
end

require("lualine").setup {
    options = {
        theme = "rose-pine"
    }
}

SetupColors()
