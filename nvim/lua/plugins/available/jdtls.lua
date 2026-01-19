return {
  -- Java: nvim-jdtls
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("configs.jdtls").setup()
    end,
  },
}
