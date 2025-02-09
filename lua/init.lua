local M = {}

local default_config = {
  special = {
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

return M
