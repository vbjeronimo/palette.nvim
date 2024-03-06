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

M.export_colorscheme = function()
	local base_colors = {}
	local special_colors = {}

	local r_start = M.config.base_colors.range[1]
	local r_end = M.config.base_colors.range[2]

	for i = r_start, r_end do
		base_colors["color"..i] = vim.g["terminal_color_"..i]
	end

	for key, value in pairs(M.config.special_colors) do
		local highlight = vim.api.nvim_get_hl(0, {name=value.group})

		if highlight[value.attr] then
			local color = string.format("#%6x", highlight[value.attr])
			print("color: "..color)
		else
			print("highlight '"..key.."' does not have attribute '"..value.attr.."'")
			-- TODO: check for the "reverse" attr
			-- NOTE: if the attr defined by the user is not on the table, 
			--			 and there's no "reverse" attr on the selected hl group
			--			 raise an error
		end
		-- special_colors[key] = color
	end
end

-- TODO: delete this call
M.export_colorscheme()

return M
