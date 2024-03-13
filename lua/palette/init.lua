local config = require("palette.config")

local M = {}

M.setup = function(opts)
  config.set_options(opts)
end

M.export_colorscheme = function()
  local base_colors = {}
  local special_colors = {}

  local r_start = M.config.base_colors.range[1]
  local r_end = M.config.base_colors.range[2]

  for i = r_start, r_end do
    base_colors["color"..i] = vim.g["terminal_color_"..i]
  end

  local GLOBAL_NAMESPACE = 0
  local normal_highlight = vim.api.nvim_get_hl(GLOBAL_NAMESPACE, {name="Normal"})

  for key, value in pairs(M.config.special_colors) do
    local highlight = vim.api.nvim_get_hl(GLOBAL_NAMESPACE, {name=value.group, link=false})
    local color = nil

    if highlight[value.attr] then
      color = string.format("#%6x", highlight[value.attr])

    elseif highlight["reverse"] then
      local reverse_highlight = {
        fg = highlight["bg"] or normal_highlight["bg"],
        bg = highlight["fg"] or normal_highlight["fg"],
      }

      color = string.format("#%6x", reverse_highlight[value.attr])

    elseif next(highlight) == nil then
      local cleared_attr = normal_highlight[value.attr]
      color = string.format("#%6x", cleared_attr)

    else
      error(
        "Error: highlight '"..value.group.."' does not have attribute '"..value.attr.."'\n"..
        value.group..":\n"
        ..vim.inspect(highlight).."\n"..
        "\n"..
        "config:".."\n"..
        key.." = "..vim.inspect(value)
      )
    end

    special_colors[key] = color
  end

  return {
    base_colors,
    special_colors,
  }
end

return M
