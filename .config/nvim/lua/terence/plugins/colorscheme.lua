return {
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("everforest").setup({
				-- config here
				-- background = "light",
				transparent_background_level = 1
			})
			vim.cmd([[colorscheme everforest]])
		end,
	}
}
