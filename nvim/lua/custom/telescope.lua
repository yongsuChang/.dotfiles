local telescope = require("telescope")

telescope.setup {
  defaults = {
    prompt_prefix = "🔍 ",
    sorting_strategy = "ascending",
    layout_config = {
      prompt_position = "top",
    },
  },
  pickers = {
    find_files = {
      hidden = true,
      no_ignore = true,
    },
  },
}

