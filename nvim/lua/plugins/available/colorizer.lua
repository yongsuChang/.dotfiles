return {
  -- Colorizer 플러그인 (norcalli)
  {
    "norcalli/nvim-colorizer.lua",
    lazy = false,
    config = function()
      require("colorizer").setup({
        filetypes = { "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "html" },
        user_default_options = {
          RGB = true, -- #RGB 형식 지원
          RRGGBB = true, -- #RRGGBB 형식 지원
          names = false, -- 색상 이름 (e.g., "red") 비활성화
          RRGGBBAA = true, -- #RRGGBBAA 형식 지원
          rgb_fn = true, -- rgb()와 rgba() 함수 지원
          hsl_fn = true, -- hsl()과 hsla() 함수 지원
          css = true, -- CSS 색상 지원
          css_fn = true, -- CSS 함수 지원
          tailwind = true, -- TailwindCSS 클래스 색상 미리보기 활성화
        },
      })
    end,
  },
  -- TailwindCSS Colors 플러그인 (수동으로 설치 함)
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    lazy = false,
    config = function()
            require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2, -- 색상 미리보기 사각형의 크기 (옵션)
      })
    end,
  },
  -- nvim-colorizer 플러그인 추가(더 빠른 색상 미리보기, catgoose)
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = { -- set to setup table
    },
  },
}
