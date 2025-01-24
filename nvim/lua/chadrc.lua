-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

-- vim 독립 클립보드 사용
vim.opt.clipboard = "unnamedplus"

M.header = {
  "Welcome to NVChad!",
  "Make your Neovim powerful",
}

M.base46 = {
	theme = "tokyodark",

	 hl_override = {
      Comment = { italic = true },
	   ["@comment"] = { italic = true },
	 },
}

M.plugins = {
    status = {
    nvimtree = true, -- Nvim-tree 활성화
  },
}

M.nvdash = { load_on_startup = true }
M.ui = {
  tabufline = {
    enabled = true,
    lazyload =false,
  },
  nvimtree = {
    git_hl = true, -- Git 상태 하이라이트 활성화
    show_icons = {
      git = true,
      folders = true,
      files = true,
    },
  },
}

return M
