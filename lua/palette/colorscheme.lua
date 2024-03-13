local M = {}

M.get_base_colors = function(r_start, r_end, error_on_nil)
  error_on_nil = error_on_nil or false
  local base_colors = {}

  for i = r_start, r_end do
    local color = vim.g["terminal_color_"..i]

    if not color and error_on_nil then
      error("Error: color"..i.." is nil")
    end

    base_colors["color"..i] = color
  end

  return base_colors
end

M.get_colors = function(config)
  local base_colors = {}
  local special_colors = {}

  local r_start = config.base_colors.range[1]
  local r_end = config.base_colors.range[2]
  local error_on_nil = config.error_on_nil
  base_colors = M.get_base_colors(r_start, r_end, error_on_nil)

  local GLOBAL_NAMESPACE = 0
  local normal_highlight = vim.api.nvim_get_hl(GLOBAL_NAMESPACE, {name="Normal"})

  for key, value in pairs(config.special_colors) do
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
