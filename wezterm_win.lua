local w = require 'wezterm'
local c = w.config_builder()
local a = w.action

c.front_end = 'WebGpu'

-- ===== Appearance =====
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
c.colors = { visual_bell = '#200000' }
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
c.window_padding = { left='9px', right='9px', top='3px', bottom='3px' }

-- ===== WSL 기본 도메인 자동 선택 =====
local function pick_wsl_domain(prefer)
  local domains = w.default_wsl_domains()
  local by_name = {}
  for _, d in ipairs(domains) do by_name[d.name] = d end
  for _, name in ipairs(prefer or {}) do
    if by_name["WSL:" .. name] then return "WSL:" .. name end
  end
  if #domains > 0 then return domains[1].name end
  return nil
end

local preferred = {"Arch", "Ubuntu-24.04", "Ubuntu"}  -- 선호순서 수정 가능
local chosen = pick_wsl_domain(preferred)
if chosen then
  c.default_domain = chosen
end

-- ===== 키 바인딩 =====
c.keys = {}

-- Alt 또는 AltGr(=ALT|CTRL) + 방향키 → Pane 이동
table.insert(c.keys, {mods='ALT',       key='LeftArrow',  action=a.ActivatePaneDirection('Left')})
table.insert(c.keys, {mods='ALT',       key='RightArrow', action=a.ActivatePaneDirection('Right')})
table.insert(c.keys, {mods='ALT',       key='UpArrow',    action=a.ActivatePaneDirection('Up')})
table.insert(c.keys, {mods='ALT',       key='DownArrow',  action=a.ActivatePaneDirection('Down')})
table.insert(c.keys, {mods='ALT|CTRL',  key='LeftArrow',  action=a.ActivatePaneDirection('Left')})
table.insert(c.keys, {mods='ALT|CTRL',  key='RightArrow', action=a.ActivatePaneDirection('Right')})
table.insert(c.keys, {mods='ALT|CTRL',  key='UpArrow',    action=a.ActivatePaneDirection('Up')})
table.insert(c.keys, {mods='ALT|CTRL',  key='DownArrow',  action=a.ActivatePaneDirection('Down')})

-- 창 분할 / 닫기
table.insert(c.keys, {mods='ALT',       key='m', action=a.SplitVertical})
table.insert(c.keys, {mods='ALT',       key='l', action=a.SplitHorizontal})
table.insert(c.keys, {mods='ALT',       key='w', action=a.CloseCurrentPane { confirm=false }})
table.insert(c.keys, {mods='ALT|CTRL',  key='m', action=a.SplitVertical})
table.insert(c.keys, {mods='ALT|CTRL',  key='l', action=a.SplitHorizontal})
table.insert(c.keys, {mods='ALT|CTRL',  key='w', action=a.CloseCurrentPane { confirm=false }})

-- 탭 전환: Ctrl+1~9
for i = 1, 9 do
  table.insert(c.keys, {mods='CTRL', key=tostring(i), action=a.ActivateTab(i-1)})
end

-- 새 탭: Ctrl+Shift+T (현재 도메인 유지)
table.insert(c.keys, {mods='CTRL|SHIFT', key='T', action=a{SpawnTab='CurrentPaneDomain'}})

-- 전체 화면 토글: Alt+Enter
table.insert(c.keys, {mods='ALT',      key='Enter', action=a.ToggleFullScreen})
table.insert(c.keys, {mods='ALT|CTRL', key='Enter', action=a.ToggleFullScreen})

-- ===== 디버그 / Alt 문제 방지 =====
c.debug_key_events = true
c.send_composed_key_when_left_alt_is_pressed  = false
c.send_composed_key_when_right_alt_is_pressed = false
-- 필요 시 악센트 데드키 비활성화
-- c.use_dead_keys = false

return c

