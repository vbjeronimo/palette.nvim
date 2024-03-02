local M = {}

M.export_colorscheme = function()
	print("Not Implemented")
end

local _get_colors = function()
	local base_colors	= {}
	local special_colors = {}

	-- get base16 colors
	for i = 0, 15 do
		base_colors["color"..i] = vim.g["terminal_color_"..i]
	end

	-- get special colors
	special_colors["fg"] = vim.api.nvim_get_hl(0, {name="normal"})["fg"]
	special_colors["bg"] = vim.api.nvim_get_hl(0, {name="normal"})["bg"]
	special_colors["cursor"] = vim.api.nvim_get_hl(0, {name="cursor"})

	-- TODO: handle 'reverse=true'
	-- TODO: handle 'fg' and 'bg' keys
	-- TODO: handle 'Link <hl_name>'


	print("base colors:")
	print(vim.inspect(base_colors))

	print("special colors:")
	print(vim.inspect(special_colors))
		
end

_get_colors()

local defaults = {}

M.setup = function(opts)
	M.config = vim.tbl_deep_extend("force", defaults, opts or {})
end

return M
