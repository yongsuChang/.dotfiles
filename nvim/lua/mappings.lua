require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local builtin = require("telescope.builtin")

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<C-p>", ":Telescope find_files<CR>", { desc = "Find files" })

---- Theme switcher
map("n", "<C-t>", function()
  require("nvchad.themes").open {style = "compact"}
end, {})

-- F4: 전체 경로 검색
map("n", "<F4>", function()
  builtin.find_files()
end, { desc = "Find files with path" })

-- F5: 파일명만 검색
map("n", "<F5>", function()
  builtin.find_files {
    find_command = { "find", ".", "-type", "f", "-printf", "%f\n" }
  }
end, { desc = "Find files by name" })

---- Tabufline
-- F7: 이전 버퍼로 이동
map("n", "<F7>", function()
  require("nvchad.tabufline").prev()
end, { desc = "Tabufline Previous buffer" })

-- F8: 다음 버퍼로 이동
map("n", "<F8>", function()
  require("nvchad.tabufline").next()
end, { desc = "Tabufline Next buffer" })

-- F9: 버퍼 닫기
map("n", "<F9>", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "Tabufline Close buffer" })

-- Alt + 1~9로 1번 ~ 9번 버퍼로 이동
for i = 1, 9, 1 do
 vim.keymap.set("n", string.format("<A-%s>", i), function()
   vim.api.nvim_set_current_buf(vim.t.bufs[i])
 end)
end

---- NvimTree
-- F2: NvimTree 열기/닫기
map("n", "<F2>", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

-- F3: NvimTree 새 창 열기
map("n", "<F3>", ":NvimTreeFocus<CR>", { desc = "Focus NvimTree" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
