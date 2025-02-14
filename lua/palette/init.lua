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

function get_special_color(group_name, attr_type)
  local color_decimal = get_color_decimal_value(group_name, attr_type)
  return decimal_to_hex(color_decimal)
end

function get_color_decimal_value(group_name, attr_type)
  local highlight = vim.api.nvim_get_hl(GLOBAL_NAMESPACE_ID, { name = group_name })

  local color_decimal
  if highlight[attr_type] then
    color_decimal = highlight[attr_type]
  elseif highlight["link"] then
    color_decimal = get_color_decimal_value(highlight["link"], attr_type)
  elseif highlight["reverse"] then
    local reverse_attr
    if attr_type == "fg" then
      reverse_attr = "bg"
    else
      reverse_attr = "fg"
    end
    color_decimal = highlight[reverse_attr]
  elseif next(highlight) == nil then
    color_decimal = get_color_decimal_value("Normal", attr_type)
  end

  return color_decimal
end

function decimal_to_hex(value)
  return string.lower(string.format("#%06x", value))
end

M.get_special_color = get_special_color

return M
