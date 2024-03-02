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
	local GLOBAL_NAMESPACE = 0

	special_colors["fg"] = vim.api.nvim_get_hl(GLOBAL_NAMESPACE, {name="normal"})["fg"]
	special_colors["bg"] = vim.api.nvim_get_hl(GLOBAL_NAMESPACE, {name="normal"})["bg"]
	special_colors["vert_split"] = vim.api.nvim_get_hl(GLOBAL_NAMESPACE, {name="vertsplit"})
	special_colors["cursor"] = vim.api.nvim_get_hl(GLOBAL_NAMESPACE, {name="cursor"})

	-- TODO: handle 'reverse=true'
	-- TODO: handle 'fg' and 'bg' keys
	-- TODO: handle 'Link <hl_name>'
	-- NOTE: I think I might not need to handle any 'cterm*' args or 'guisp'

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
