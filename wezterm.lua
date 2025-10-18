local w = require 'wezterm'
local c = w.config_builder()
local a = w.action

c.front_end = 'WebGpu'

-- Appearance
c.color_scheme = 'iTerm2 Dark Background'
c.font = w.font('CaskaydiaCove Nerd Font')
c.font_size = 18
c.audible_bell = 'Disabled'
c.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 1,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 200,
}
c.colors = {
  visual_bell = '#200000',
}
c.adjust_window_size_when_changing_font_size = false
c.send_composed_key_when_right_alt_is_pressed = false
c.show_new_tab_button_in_tab_bar = false
c.show_tab_index_in_tab_bar = false
c.hide_tab_bar_if_only_one_tab = true
c.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
c.window_frame = {
  border_left_width = '2px',
  border_right_width = '2px',
  border_bottom_height = '2px',
  border_top_height = '2px',
  border_left_color = '#333',
  border_right_color = '#333',
  border_bottom_color = '#333',
  border_top_color = '#333',
}
c.window_padding = {
  left = '9px',
  right = '9px',
  top = '3px',
  bottom = '3px',
}

c.keys = {
  {mods = 'CMD', key = 'Enter', action = a.ToggleFullScreen},
  {mods = 'CMD', key = '[', action = a.ActivatePaneDirection('Prev')},
  {mods = 'CMD', key = ']', action = a.ActivatePaneDirection('Next')},
}

-- ===== Helper: pick default WSL domain if available =====
local function pick_wsl_domain(prefer)
  -- prefer: {"Arch","Ubuntu-24.04","Ubuntu"} 처럼 선호순서 배열
  local domains = w.default_wsl_domains()
  local by_name = {}
  for _, d in ipairs(domains) do
    by_name[d.name] = d
  end
  -- 정확히 일치하는 도메인을 먼저 탐색
  for _, name in ipairs(prefer or {}) do
    if by_name["WSL:" .. name] then
      return "WSL:" .. name
    end
  end
  -- 없으면 첫 번째 WSL 도메인
  if #domains > 0 then
    return domains[1].name
  end
  return nil
end

if w.target_triple == 'aarch64-apple-darwin' or w.target_triple == 'x86_64-apple-darwin' then
  -- macOS specific settings
  c.native_macos_fullscreen_mode = true
  c.window_decorations = 'MACOS_FORCE_ENABLE_SHADOW|RESIZE'

  table.insert(c.keys, {mods = 'CMD', key = 'w', action = a.CloseCurrentPane { confirm = false }})
  table.insert(c.keys, {mods = 'CMD', key = 'm', action = a.SplitVertical})
  table.insert(c.keys, {mods = 'CMD', key = 'l', action = a.SplitHorizontal})

elseif w.target_triple == 'x86_64-pc-windows-msvc' or w.target_triple == 'aarch64-pc-windows-msvc' then
  -- Windows specific settings

  -- 1) 선호하는 WSL 배포판 이름을 순서대로 나열 (수정해서 쓰세요)
  local preferred = {"Arch", "Ubuntu-24.04", "Ubuntu"}
  local chosen = pick_wsl_domain(preferred)

  -- 2) 기본 도메인(Wsl)으로 바로 진입
  if chosen then
    c.default_domain = chosen
  else
    -- 혹시 WSL이 없으면 PowerShell로라도 열리도록 두세요 (옵션)
    -- c.default_prog = {"powershell.exe"}
  end

  -- 3) Windows에선 SUPER(윈도우키) 사용 권장
  table.insert(c.keys, {mods = 'SUPER', key = '-', action = a.SplitVertical})
  table.insert(c.keys, {mods = 'SUPER', key = '\\', action = a.SplitHorizontal})

  table.insert(c.keys, {mods = 'CTRL', key = '1', action = a.ActivateTab(0)})
  table.insert(c.keys, {mods = 'CTRL', key = '2', action = a.ActivateTab(1)})
  table.insert(c.keys, {mods = 'CTRL', key = '3', action = a.ActivateTab(2)})
  table.insert(c.keys, {mods = 'CTRL', key = '4', action = a.ActivateTab(3)})
  table.insert(c.keys, {mods = 'CTRL', key = '5', action = a.ActivateTab(4)})
  table.insert(c.keys, {mods = 'CTRL', key = '6', action = a.ActivateTab(5)})
  table.insert(c.keys, {mods = 'CTRL', key = '7', action = a.ActivateTab(6)})
  table.insert(c.keys, {mods = 'CTRL', key = '8', action = a.ActivateTab(7)})
  table.insert(c.keys, {mods = 'CTRL', key = '9', action = a.ActivateTab(8)})

  -- (선택) Launch Menu: WSL 홈/PowerShell 빠른 실행
  c.launch_menu = {
    chosen and { label = chosen .. " Home", domain = { DomainName = chosen }, cwd = "/home/$USER" } or nil,
    { label = "Windows PowerShell", args = {"powershell.exe"} },
  }

  -- (선택) 새 탭 시 현재 도메인 유지(WSL에서 WSL 탭 추가)
  table.insert(c.keys, {mods = 'CTRL|SHIFT', key = 'T', action = a{ SpawnTab = 'CurrentPaneDomain' }})
end

return c

