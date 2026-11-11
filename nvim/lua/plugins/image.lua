return {
    {
        -- inline image rendering in markdown buffers
        "3rd/image.nvim",
        build = false,
        opts = {
            processor = "magick_cli",
            max_width = 100,
            max_height = 12,
            max_height_window_percentage = math.huge,
            max_width_window_percentage = math.huge,
            window_overlap_clear_enabled = true,
            window_overlap_clear_ft_ignore = { "" },
        },
    },
}
