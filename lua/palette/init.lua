local M = {}

local GLOBAL_NAMESPACE_ID = 0

local default_config = {
  special = {
    -- ["foreground"] = { group = "Normal", type = "fg-by-default" }
    { group = "Normal",    type = "fg", key_name = "foreground" },
    { group = "Normal",    type = "bg", key_name = "background" },
    { group = "Cursor",    type = "bg", key_name = "cursor" },
    { group = "CurSearch", type = "fg", key_name = "selection_foreground" },
    { group = "CurSearch", type = "bg", key_name = "selection_background" },
  },
  terminal = {
    key_prefix = "color",
    range = { 0, 15 }
  }
}

local config = {}

M.setup = function(opts)
  config = vim.tbl_deep_extend("force", default_config, opts or {})
end

function get_terminal_color(color_num)
  local color_hex = vim.g["terminal_color_" .. color_num]

  if color_hex == nil then
    error("Error: terminal color " .. color_num .. " is nil")
  end

  return string.lower(color_hex)
end

function get_special_color(group_name, attr_type)
  local color_decimal = get_color_decimal_value(group_name, attr_type)
  return decimal_to_hex(color_decimal)
end

function get_color_decimal_value(group_name, attr_type)
  local highlight = vim.api.nvim_get_hl(GLOBAL_NAMESPACE_ID, { name = group_name })

  local color_decimal
  if highlight["link"] then
    color_decimal = get_color_decimal_value(highlight["link"], attr_type)
  elseif highlight["reverse"] then
    local reverse_attr
    if attr_type == "fg" then
      reverse_attr = "bg"
    else
      reverse_attr = "fg"
    end
    color_decimal = highlight[reverse_attr]
  elseif highlight[attr_type] then
    color_decimal = highlight[attr_type]
  elseif next(highlight) == nil then
    -- The highlight group is not defined
    color_decimal = get_color_decimal_value("Normal", attr_type)
  end

  if color_decimal == nil then
    -- The highlight group exists, but the attribute is not defined
    error(
      "Error: Could not get color value for attribute '" .. attr_type ..
      "' on highlight group '" .. group_name .. "', as it is not defined:\n" ..
      "[\"" .. group_name .. "\"] = " .. vim.inspect(highlight)
    )
  end

  return color_decimal
end

function decimal_to_hex(value)
  return string.lower(string.format("#%06x", value))
end

M.get_special_color = get_special_color
M.get_terminal_color = get_terminal_color

return M
