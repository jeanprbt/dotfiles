local selected = "#faf4ed"
local visible = "#f2e9e1"
if vim.o.background == "dark" then
    selected = "#232136"
    visible = "#393552"
end
return {
    {
        "akinsho/bufferline.nvim",
        event = "ColorScheme",
        keys = function()
            return {
                { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
                { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
            }
        end,
        opts = {
            highlights = {
                fill = {
                    bg = selected,
                },
                background = {
                    bg = visible,
                },
                close_button_selected = {
                    bg = selected,
                },
                close_button_visible = {
                    bg = visible,
                },
                close_button = {
                    bg = visible,
                },
                buffer_selected = {
                    bg = selected,
                },
                buffer_visible = {
                    bg = visible,
                },
                modified_selected = {
                    bg = selected,
                },
                modified_visible = {
                    bg = visible,
                },
                modified = {
                    bg = visible,
                },
                separator_selected = {
                    bg = selected,
                },
                separator_visible = {
                    bg = visible,
                },
                separator = {
                    bg = visible,
                },
                indicator_selected = {
                    bg = selected,
                },
                indicator_visible = {
                    bg = visible,
                },
                offset_separator = {
                    bg = visible,
                },
            },
        },
    },
}
