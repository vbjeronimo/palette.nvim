local colorscheme = require("palette.colorscheme")
local config = require("palette.config")

local M = {}

M.setup = function(opts)
  config.set_options(opts)
end

M.export_colorscheme = function()
  local colors = colorscheme.get_colors(config.options)

  -- TODO: save colors to a file
  return colors
end

print(vim.inspect(M.export_colorscheme()))

return M
