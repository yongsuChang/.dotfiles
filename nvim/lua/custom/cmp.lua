local cmp = require("cmp")

cmp.setup({
  -- coplilot 설정
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item() -- nvim-cmp의 suggestion 이동
      elseif require("copilot.suggestion").is_visible() then
        require("copilot.suggestion").accept() -- Copilot 제안 수락
      else
        fallback() -- 기본 Tab 동작
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item() -- nvim-cmp의 suggestion 이전 항목
      else
        fallback() -- 기본 Shift+Tab 동작
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = "copilot", group_index = 2 },
    { name = "nvim_lsp" },
    { name = "buffer" },
  },
})

