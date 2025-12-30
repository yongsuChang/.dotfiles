return {
  "barrett-ruth/live-server.nvim",
  build = "npm install -g live-server",
  cmd = { "LiveServerStart", "LiveServerStop" },
  config = true,
  git = {
    url_format = "git@github.com:%s.git",
  },
  keys = {
    { "<leader>ls", "<cmd>LiveServerStart<cr>", desc = "Start Live Server" },
    { "<leader>lx", "<cmd>LiveServerStop<cr>", desc = "Stop Live Server" },
  },
}
