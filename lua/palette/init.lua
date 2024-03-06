local M = {}

local defaults = {
	base_colors = {
		range = {0, 15}
	},
	special_colors = {
		foreground = {
			group = "Normal",
			attr = "fg"
		},
		background = {
			group = "Normal",
			attr = "bg"
		},
		cursor = {
			group = "Cursor",
			attr = "bg"
		},
	},
	default_format = "json",
	default_output_path = "~/palette.json",
}

M.setup = function(opts)
	M.config = vim.tbl_deep_extend("force", defaults, opts or {})
end

M.setup()

return M
