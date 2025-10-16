vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- Font
vim.opt.guifont = "CaskaydiaCove Nerd Font:h16"
-- Color
vim.opt.termguicolors = true
-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

-- netrw무시, vim-tmux-navigator 사용
vim.g.tmux_navigator_disable_netrw_workaround = 1

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  { import = "plugins" },
}, {
  -- Lazy.nvim 설정 추가
  install = {
    ssh = true, -- SSH 강제 사용
  },
  performance = lazy_config.performance,
})

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- Safe cross-platform clipboard setup for Neovim
local function has(cmd) return vim.fn.executable(cmd) == 1 end
local function set_clip(name, copy_cmd, paste_cmd)
  vim.g.clipboard = {
    name = name,
    copy = { ["+"] = copy_cmd, ["*"] = copy_cmd },
    paste = { ["+"] = paste_cmd, ["*"] = paste_cmd },
    cache_enabled = 0,
  }
  vim.opt.clipboard = "unnamedplus"
end

-- Detect platforms
local is_wsl = (vim.fn.has("wsl") == 1)
local is_mac = (vim.fn.has("mac") == 1)
local is_unix = (vim.fn.has("unix") == 1)

if is_wsl then
  -- Prefer win32yank
  if has("win32yank.exe") then
    set_clip(
      "win32yank",
      "win32yank.exe -i --crlf",
      "win32yank.exe -o --lf"
    )
  -- Fallback: Windows built-ins
  elseif has("clip.exe") and has("powershell.exe") then
    set_clip(
      "WslClipboard",
      "clip.exe",
      [[powershell.exe -NoProfile -Command Get-Clipboard | tr -d '\r']]
    )
  end

elseif is_mac then
  if has("pbcopy") and has("pbpaste") then
    set_clip("macOS", "pbcopy", "pbpaste")
  end

elseif is_unix then
  -- Wayland first
  if os.getenv("WAYLAND_DISPLAY") and has("wl-copy") and has("wl-paste") then
    set_clip("Wayland", "wl-copy", "wl-paste -n")
  -- X11: xclip or xsel
  elseif has("xclip") then
    set_clip("xclip", "xclip -selection clipboard", "xclip -selection clipboard -o")
  elseif has("xsel") then
    set_clip("xsel", "xsel --clipboard --input", "xsel --clipboard --output")
  end
end

-- (선택) 공급자를 못 찾았으면 unnamedplus를 강제로 켜지지 않게 함
if vim.g.clipboard == nil then
  -- 공급자가 없을 때 health 경고만 나오고 동작은 파일 내 레지스터로 제한됩니다.
  -- vim.opt.clipboard = ""  -- 필요하면 완전히 끄기
end
