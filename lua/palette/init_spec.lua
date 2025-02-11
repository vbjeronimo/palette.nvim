local palette = require('palette')

local GLOBAL_NAMESPACE_ID = 0

describe("Retrieving color values:", function()
  before_each(function()
    vim.cmd("highlight clear")
  end)

  describe("get_special_color", function()
    it("returns a valid color value when the highlight group is set", function()
      local test_cases = {
        ["Normal"] = { fg = "#a6accd", bg = "#0f111a" },
        ["Cursor"] = { fg = "#0f111a", bg = "#ffcc00" },
        ["Search"] = { fg = "#0f111a", bg = "#eeffff" },
      }

      for group_name, group_def in pairs(test_cases) do
        vim.api.nvim_set_hl(GLOBAL_NAMESPACE_ID, group_name, group_def)

        local result_fg = palette.get_special_color(group_name, "fg")
        assert.are.equal(result_fg, group_def.fg)

        local result_bg = palette.get_special_color(group_name, "bg")
        assert.are.equal(result_bg, group_def.bg)
      end
    end)

    it("handles multiple levels of linked highlight groups", function()
      local highlights = {
        ["Title"] = { fg = "#89ddff" },
        ["FloatTitle"] = { link = "Title" },
        ["FloatFooter"] = { link = "FloatTitle" },
      }

      for group_name, group_def in pairs(highlights) do
        vim.api.nvim_set_hl(GLOBAL_NAMESPACE_ID, group_name, group_def)
      end

      local result_fg = palette.get_special_color("FloatFooter", "fg")
      assert.are.equal(result_fg, highlights["Title"].fg)
    end)
  end)
end)
