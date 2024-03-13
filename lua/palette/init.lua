local colorscheme = require("palette.colorscheme")
local config = require("palette.config")

local M = {}

M.setup = function(opts)
  config.set_options(opts)
end

M.export_colorscheme = function()
  local base_colors = colorscheme.get_base_colors(
    config.options.base_colors.range[1],
    config.options.base_colors.range[2],
    config.options.error_on_nil
  )

  local special_colors = colorscheme.get_special_colors(
    config.options.special_colors
  )

  -- TODO: save colors to a file
  return {
    base_colors,
    special_colors
  }
end

print(vim.inspect(M.export_colorscheme()))

return M
