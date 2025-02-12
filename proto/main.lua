-- Some ideas for later:
function toLua()
  -- returns a table with the resulting color mappings
end

function toJSON()
  -- returns a JSON string
end

function toStdout()
  -- print to stdout to allow for stuff like:
  -- `nvim --headless -c "require('palette').get_colors().toStdout()" | jq ...`
end

local idea_for_input = {
  output = {
    {
      path = "~/.config/kitty/colors.conf",
      formatter = "conf"
    },
    {
      path = "~/.config/alacritty/colors.toml",
      formatter = "toml",
      mappings = {
        -- map the definitions at `colors` to something that will be written
        -- directly to the output file by the formatter
        ["foreground"] = "colors.special.Normal.fg"
      }
    },
    {
      path = "~/.config/something-else/colors.custom",
      formatter = function(color_to_key_mapping) end
    }
  },
  colors = {
    special = {
      ["Normal"] = { fg = "#abcdef", bg = "@fedcba" }
    }
  }
}

local input = {
  special = {
    { group = "Normal",     type = "fg", key_name = "foreground" },
    { group = "Normal",     type = "bg", key_name = "background" },
    { group = "Cursor",     type = "bg", key_name = "cursor" },
    { group = "CurSearch",  type = "fg", key_name = "selection_foreground" },
    { group = "CurSearch",  type = "bg", key_name = "selection_background" },
    { group = "TermCursor", type = "bg", key_name = "test_linked" },
    { group = "VisualNC",   type = "fg", key_name = "test_cleared" },
    { group = "DiffText",   type = "fg", key_name = "test_reverse" },
  },
  terminal = {
    key_prefix = "color",
    range = { 0, 15 }
  }
}

local colors = { special = {}, terminal = {} }

for _, hl in pairs(input.special) do
  local color_decimal = vim.api.nvim_get_hl(0, { name = hl.group })
  local highlight = vim.api.nvim_get_hl(0, { name = hl.group })

  local color_decimal
  if highlight["link"] then
    local linked_hl = vim.api.nvim_get_hl(0, { name = highlight["link"] })
    color_decimal = linked_hl[hl.type]
  elseif highlight["reverse"] then
    local reverse_type = (hl.type == "fg" and "fg" or "bg")
    color_decimal = highlight[reverse_type]
  elseif next(highlight) == nil then
    local normal_group = vim.api.nvim_get_hl(0, { name = "Normal" })
    color_decimal = normal_group[hl.type]
  else
    color_decimal = highlight[hl.type]
  end

  local color_hex = string.format("#%06x", color_decimal)
  colors.special[hl.key_name] = color_hex
end

local key_prefix = input.terminal.key_prefix
for i = input.terminal.range[1], input.terminal.range[2] do
  colors.terminal[key_prefix .. i] = string.lower(vim.g["terminal_color_" .. i])
end

vim.print(colors)
