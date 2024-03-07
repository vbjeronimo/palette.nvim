local M = {}

local defaults = {
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
    -- TODO: delete these test configs
    pmenukindsel = {
      group = "PmenuKindSel",
      attr = "fg"
    },
    pmenusel = {
      group = "PmenuSel",
      attr = "fg"
    },
    normalnc = {
      group = "NormalNc",
      attr = "bg"
    },
    -- test = {
    --   group = "VertSplit",
    --   attr = "bcg"
    -- },
    -- TODO END
  },
  default_format = "json",
  default_output_path = "~/palette.json",
}

M.setup = function(opts)
  M.config = vim.tbl_deep_extend("force", defaults, opts or {})
end

M.setup()

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

-- TODO: delete this call
M.export_colorscheme()

return M
