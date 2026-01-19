return {
  -- Find and replace with args
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("live_grep_args")
    end,
  },
  -- telescope-lsp-handlers
  {
    "gbrlsnchs/telescope-lsp-handlers.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      local telescope = require("telescope")
      local themes = require("telescope.themes")
      -- Telescope의 기존 설정을 건드리지 않고 확장 옵션만 추가하는 방법입니다.
      telescope.setup({
        extensions = {
          lsp_handlers = {
            disable = {},
            location = {
              telescope = {},
              no_results_message = 'No references found',
            },
            symbol = {
              telescope = {},
              no_results_message = 'No symbols found',
            },
            call_hierarchy = {
              telescope = {},
              no_results_message = 'No calls found',
            },
            code_action = {
              telescope = themes.get_dropdown({}),
              no_results_message = 'No code actions available',
              prefix = '',
            },
          },
        },
      })
      telescope.load_extension("lsp_handlers")
    end,
  },
}
