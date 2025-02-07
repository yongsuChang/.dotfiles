local plugins = {
  -- Find and replace
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("live_grep_args")
    end,
  },
  -- Find and replace
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("spectre").setup()
    end,
  },
  -- Colorizer 플러그인 추가
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
  -- nvim-colorizer 플러그인 추가(더 빠른 색상 미리보기)
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = { -- set to setup table
    },
  },
  -- Markdown 미리보기 플러그인 추가
  {
    "iamcco/markdown-preview.nvim",
    lazy = false, -- 항상 로드
    build = "cd app && npm install", -- 설치 후 npm 의존성 설치
    ft = { "markdown" }, -- Markdown 파일에서만 활성화
    config = function()
      vim.g.mkdp_auto_start = 1 -- Markdown 파일 열 때 자동으로 미리보기 시작
      vim.g.mkdp_browser = "" -- 시스템 기본 브라우저 사용
      vim.g.mkdp_auto_close = 1       -- Neovim에서 Markdown 파일을 닫으면 미리보기 종료
      vim.g.mkdp_refresh_slow = 0     -- 내용 변경 시 즉시 새로고침
      vim.g.mkdp_port = 8000          -- 미리보기를 제공할 포트 (설정값: 8000)
    end,
  },
  -- 이모지 및 아이콘 표시 플러그인 추가
  {
    "kyazdani42/nvim-web-devicons", -- 이모지 및 아이콘 표시
    lazy = false, -- 항상 로드
    config = function()
      require("nvim-web-devicons").setup {
        default = true, -- 기본 이모지 설정 활성화
      }
    end,
  },
  -- 이모지 자동완성 플러그인 추가
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        sources = {
          { name = "emoji" }, -- 이모지 자동완성 소스
        },
      })
    end,
  }
}

return plugins

