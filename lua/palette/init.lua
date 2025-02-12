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
  local color_decimal = _get_color_decimal_value(group_name, attr_type)
  return _decimal_to_hex(color_decimal)
end

function _get_color_decimal_value(group_name, attr_type)
  local highlight = vim.api.nvim_get_hl(GLOBAL_NAMESPACE_ID, { name = group_name })

  local color_decimal
  if highlight[attr_type] then
    color_decimal = highlight[attr_type]
  elseif highlight["link"] then
    color_decimal = _get_color_decimal_value(highlight["link"], attr_type)
  elseif next(highlight) == nil then
    color_decimal = _get_color_decimal_value("Normal", attr_type)
  end

  return color_decimal
end

function _decimal_to_hex(value)
  return string.lower(string.format("#%06x", value))
end

M.get_special_color = get_special_color

return M
