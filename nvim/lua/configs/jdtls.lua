-- vim.notify 오버라이드: Gradle 보안 경고 차단
local original_notify = vim.notify
vim.notify = function(msg, level, opts)
  -- 메시지 내용 검사
  if msg and (string.find(msg, "Security Warning") or string.find(msg, "gradle wrapper") or string.find(msg, "checksums")) then
    -- 특정 메시지는 무시하고 리턴
    return
  end
  -- 그 외 메시지는 원래 notify 함수로 전달
  original_notify(msg, level, opts)
end

local M = {}

M.setup = function()
  local jdtls_ok, jdtls = pcall(require, "jdtls")
  if not jdtls_ok then return end

  local home = os.getenv("HOME")
  local mason_path = home .. "/.local/share/nvim/mason/packages/jdtls"
  local launcher_jar = vim.fn.glob(mason_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
  local lombok_path = mason_path .. "/lombok.jar"
  local config_path = mason_path .. "/config_linux"

  local function get_config()
    local root_markers = { "gradlew", "mvnw", "pom.xml", "build.gradle", ".git" }
    local root_dir = jdtls.setup.find_root(root_markers)
    if root_dir == "" then return nil end

    local project_name = vim.fn.fnamemodify(root_dir, ":t")
    local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

    local checksum_data = {
      {
        sha256 = "b5173cbc1029dbe2212de0ff1c6331940f1c841bb26a0685b7189615802bf365",
        allowed = true,
      },
    }

    return {
      cmd = {
        "/usr/lib/jvm/java-21-openjdk-amd64/bin/java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens=java.base/java.util=ALL-UNNAMED",
        "--add-opens=java.base/java.lang=ALL-UNNAMED",
        "-javaagent:" .. lombok_path,
        "-jar", launcher_jar,
        "-configuration", config_path,
        "-data", workspace_dir,
      },
      root_dir = root_dir,

      settings = {
        java = {
          import = { gradle = { wrapper = { checksums = checksum_data } } },
          imports = { gradle = { wrapper = { checksums = checksum_data } } },
        }
      },

      init_options = {
        bundles = {},
        settings = {
          java = {
            import = { gradle = { wrapper = { checksums = checksum_data } } },
            imports = { gradle = { wrapper = { checksums = checksum_data } } },
          }
        }
      },

      -- LSP 핸들러도 유지 (이중 방어)
      handlers = {
        ["window/showMessage"] = function(err, result, ctx, config)
           return vim.NIL
        end,
        ["window/showMessageRequest"] = function(err, result, ctx, config)
           return vim.NIL
        end,
      },
    }
  end

  local jdtls_group = vim.api.nvim_create_augroup("jdtls_config", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    group = jdtls_group,
    callback = function()
      local config = get_config()
      if config then jdtls.start_or_attach(config) end
    end,
  })

  if vim.bo.filetype == "java" then
    local config = get_config()
    if config then jdtls.start_or_attach(config) end
  end
end

return M