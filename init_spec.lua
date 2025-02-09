-- colors taken from the default theme at 'https://terminal.sexy'
local test_colors = {
  normal_fg = "#c5c8c6",
  normal_bg = "#1d1f21",
  cursor_bg = "#fdbd41",

  color_0 = "#282a2e",
  color_1 = "#a54242",
  color_2 = "#8c9440",
  color_3 = "#de935f",
  color_4 = "#5f819d",
  color_5 = "#85678f",
  color_6 = "#5e8d87",
  color_7 = "#707880",
  color_8 = "#373b41",
  color_9 = "#cc6666",
  color_10 = "#b5bd68",
  color_11 = "#f0c674",
  color_12 = "#81a2be",
  color_13 = "#b294bb",
  color_14 = "#8abeb7",
  color_15 = "#c5c8c6",
}

local test_hls = {
  Normal = { fg = test_colors.normal_fg, bg = test_colors.normal_bg },
  Cursor = { fg = test_colors.normal_bg, bg = test_colors.cursor_bg },
  TestReversed = { fg = test_colors.color2, reverse = true },
  TestLinked = { link = "Cursor" },
  TestCleared = {},
}

function set_test_colorscheme()
  vim.cmd("highlight clear")

  for group_name, hl_def in pairs(test_hls) do
    vim.api.nvim_set_hl(0, group_name, hl_def)
  end

  for i = 0, 15 do
    vim.g["terminal_color_" .. i] = test_colors["color" .. i]
  end
end
