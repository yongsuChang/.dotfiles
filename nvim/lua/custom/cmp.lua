local cmp = require("cmp")

cmp.setup({
  -- Copilot과 nvim-cmp 설정
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item() -- nvim-cmp suggestion 이동
      elseif require("copilot.suggestion").is_visible() then
        require("copilot.suggestion").accept() -- Copilot suggestion 수락
      else
        fallback() -- 기본 Tab 동작
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item() -- nvim-cmp suggestion 이전 항목
      else
        fallback() -- 기본 Shift+Tab 동작
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = "copilot", group_index = 2 }, -- Copilot 제안 우선순위
    { name = "nvim_lsp" },
    { name = "buffer" },
  },
  formatting = {
    -- TailwindCSS Colorizer CMP 통합
    format = require("tailwindcss-colorizer-cmp").formatter, -- TailwindCSS 색상 미리보기
  },
})

