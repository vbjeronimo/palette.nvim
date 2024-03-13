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

