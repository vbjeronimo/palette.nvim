local M = {}

local GLOBAL_NAMESPACE_ID = 0

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

M.get_special_colors = function(color_defs)
  local special_colors = {}
  local normal_highlight = vim.api.nvim_get_hl(GLOBAL_NAMESPACE_ID, {name="Normal"})

  for key, value in pairs(color_defs) do
    local highlight = vim.api.nvim_get_hl(GLOBAL_NAMESPACE_ID, {name=value.group, link=false})
    local color = nil

    if highlight[value.attr] then
      color = highlight[value.attr]

    elseif highlight["reverse"] then
      local reverse_highlight = {
        fg = highlight["bg"] or normal_highlight["bg"],
        bg = highlight["fg"] or normal_highlight["fg"],
      }

      color = reverse_highlight[value.attr]

    elseif next(highlight) == nil then
      local cleared_attr = normal_highlight[value.attr]
      color = cleared_attr

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

    -- 'vim.api.nvim_get_hl(...)' returns the color value as a decimal number,
    -- so we need to format it to hex first, and then prepend it with "#"
    special_colors[key] = string.format("#%6x", color)
  end

  return special_colors
end

return M
