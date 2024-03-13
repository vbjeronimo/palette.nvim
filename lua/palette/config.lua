local M = {}

M.defaults = {
  error_on_nil = false,
  base_colors = {
    range = {0, 15}
  },
  special_colors = {
    foreground = {
      group = "Normal",
      attr = "fg"
    },
    background = {
      group = "Normal",
      attr = "bg"
    },
    cursor = {
      group = "Cursor",
      attr = "bg"
    },
  },
  default_format = "json",
  default_output_path = "~/palette.json",
}

M.options = {}

M.set_options = function(opts)
  M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

M.set_options()

return M
