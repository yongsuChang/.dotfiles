return {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
          -- 화살표 키 추가 매핑
      { "<c-Left>",  "<cmd>TmuxNavigateLeft<cr>" },
      { "<c-Down>",  "<cmd>TmuxNavigateDown<cr>" },
      { "<c-Up>",    "<cmd>TmuxNavigateUp<cr>" },
      { "<c-Right>", "<cmd>TmuxNavigateRight<cr>" },
    },
  }
}
