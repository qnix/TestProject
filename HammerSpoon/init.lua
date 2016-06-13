
-- For doc, see here: http://www.hammerspoon.org/docs/index.html
-- This config script is Lua

-- init grid
hs.grid.MARGINX = 4
hs.grid.MARGINY = 4
hs.grid.GRIDWIDTH  = 24
hs.grid.GRIDHEIGHT = 16

-- disable animation
hs.window.animationDuration = 0

-- hotkey mash
local mash       = {"ctrl", "alt"}
local mash_app 	 = {"cmd", "alt", "ctrl"}
local mash_shift = {"ctrl", "alt", "shift"}
local cmd_ctrl   = {"cmd", "ctrl"}

--------------------------------------------------------------------------------
-- Setup App shortcuts
--------------------------------------------------------------------------------
appCuts = {
  D = 'Dictionary',
  C = 'Google Chrome',
  F = 'Firefox',
  U = 'iTerm.app',
  X = 'Terminal.app',
  Y = 'Emacs.app'
}

-- Launch applications
for key, app in pairs(appCuts) do
  hs.hotkey.bind(mash_app, key,
                 function ()
                   hs.application.launchOrFocus(app)
                   -- Some app, like iTerm, only show up on the second event
                   -- so this is just a work around.
                   hs.application.launchOrFocus(app)
                   hs.alert.show(app, 1)
                 end
  )
end

--------------------------------------------------------------------------------

-- bind the key to perform the given func on the focused window
function bind_on_fw(hotkey, key, perform_func)
  hs.hotkey.bind(hotkey, key, function()
                   local win = hs.window.focusedWindow()
                   perform_func(win)
  end)
end

-- global operations
bind_on_fw(mash_app, ';', hs.grid.snap)

bind_on_fw(mash_app, 'M', hs.grid.maximizeWindow)

-- multi monitor
bind_on_fw(mash_app, '=', hs.grid.pushWindowNextScreen)
bind_on_fw(mash_app, '-', hs.grid.pushWindowPrevScreen)

-- move windows
bind_on_fw(mash_app, 'H', hs.grid.pushWindowLeft)
bind_on_fw(mash_app, 'J', hs.grid.pushWindowDown)
bind_on_fw(mash_app, 'K', hs.grid.pushWindowUp)
bind_on_fw(mash_app, 'L', hs.grid.pushWindowRight)

bind_on_fw(cmd_ctrl, 'Left', hs.grid.pushWindowLeft)
bind_on_fw(cmd_ctrl, 'Down', hs.grid.pushWindowDown)
bind_on_fw(cmd_ctrl, 'Up', hs.grid.pushWindowUp)
bind_on_fw(cmd_ctrl, 'Right', hs.grid.pushWindowRight)

-- resize windows
bind_on_fw(mash_app, '[', hs.grid.resizeWindowThinner)
bind_on_fw(mash_app, ']', hs.grid.resizeWindowWider)
bind_on_fw(mash_app, 'O', hs.grid.resizeWindowShorter)
bind_on_fw(mash_app, 'I', hs.grid.resizeWindowTaller)

function debug_info(scr_fr, win_fr)
  print('scr: ' .. scr_fr.w .. ', ' .. scr_fr.h)
  print('win: (' .. win_fr.w .. ', ' .. win_fr.h .. ') loc: (' .. win_fr.x .. ', ' .. win_fr.y .. ')')
end

function bind_hotkey(key, func)
  hs.hotkey.bind(mash_app, key, func)
end

function launch_KeePassX()
  hs.application.launchOrFocus('KeePassX')
end

function snap_window_left()
  local win = hs.window.focusedWindow()
  local win_fr = win:frame()

  local screen = win:screen()
  local screen_fr = screen:frame()

  debug_info(screen_fr, win_fr)

  win_fr.x = 0
  win:setFrame(win_fr)
  hs.grid.snap(win)
end

function snap_window_right()
  local win = hs.window.focusedWindow()
  local win_fr = win:frame()

  local screen = win:screen()
  local screen_fr = screen:frame()

  debug_info(screen_fr, win_fr)

  win_fr.x = screen_fr.w - win_fr.w
  win:setFrame(win_fr)
  hs.grid.snap(win)
end

function snap_window_up()
  local win = hs.window.focusedWindow()
  local win_fr = win:frame()
  -- local screen = win:screen()
  -- local screen_fr = screen:frame()
  win_fr.y = 0
  win:setFrame(win_fr)
  hs.grid.snap(win)
end

function snap_window_down()
  local win = hs.window.focusedWindow()
  local win_fr = win:frame()
  local screen = win:screen()
  local screen_fr = screen:frame()
  win_fr.y = screen_fr.h - win_fr.h
  win:setFrame(win_fr)
  hs.grid.snap(win)
end

function zoom_window_in()
  local win = hs.window.focusedWindow()
  local win_fr = win:frame()

  local screen = win:screen()
  local screen_fr = screen:frame()

  debug_info(screen_fr, win_fr)

  local zoom_factor = 1.05
  win_fr.w = win_fr.w * zoom_factor
  win_fr.h = win_fr.h * (zoom_factor + 0.10)

  win:setFrame(win_fr)
end


bind_hotkey('A', launch_KeePassX)
bind_hotkey(',', snap_window_left)
bind_hotkey('.', snap_window_right)
bind_hotkey('N', zoom_window_in)



bind_hotkey('space',
            function()
              hs.alert.show("Run Emacs now!", 3)
              hs.application.launchOrFocus('KeePassX')
end)

-- Mac shortcut <cmd-alt-ctrl S>: convert text to Traditional Chinese character
-- Mac shortcut <cmd-alt-shift S>: convert text to Simplified Chinese character
-- bind_hotkey('S', function() hs.alert.show("Test Key!", 1) end)

bind_hotkey('/', function() hs.alert.show("Test Key!", 1) end)

-- Mac shortcut: select next input source
-- bind_hotkey('\\', function() hs.alert.show("Test Key!", 1) end)
bind_hotkey('\'', function() hs.alert.show("Test Key!", 1) end)

bind_hotkey('return', function() hs.alert.show("Test Key return!", 1) end)
bind_hotkey('tab', function() hs.alert.show("Test Key tab!", 1) end)
bind_hotkey('space', function() hs.alert.show("Test Key space!", 1) end)
bind_hotkey('delete', function() hs.alert.show("Test Key delete!", 1) end)
bind_hotkey('escape', function() hs.alert.show("Test Key escape!", 1) end)
bind_hotkey('help', function() hs.alert.show("Test Key help!", 1) end)
bind_hotkey('home', function() hs.alert.show("Test Key home!", 1) end)
bind_hotkey('pageup', function() hs.alert.show("Test Key pageup!", 1) end)
bind_hotkey('pagedown', function() hs.alert.show("Test Key pagedown!", 1) end)
bind_hotkey('forwarddelete', function() hs.alert.show("Test Key forwarddelete!", 1) end)

-- bind_hotkey('Left', function() hs.alert.show("Test Key LEFT!", 1) end)
-- bind_hotkey('Right', function() hs.alert.show("Test Key RIGHT!", 1) end)
-- bind_hotkey('Down', function() hs.alert.show("Test Key DOWN!", 1) end)
-- bind_hotkey('Up', function() hs.alert.show("Test Key UP!", 1) end)

-- Function Keys F1 -> F12
bind_hotkey('f1',  function() hs.alert.show("Test Key f1!", 1) end)
bind_hotkey('f2',  function() hs.alert.show("Test Key f2!", 1) end)
bind_hotkey('f3',  function() hs.alert.show("Test Key f3!", 1) end)
bind_hotkey('f4',  function() hs.alert.show("Test Key f4!", 1) end)
bind_hotkey('f5',  function() hs.alert.show("Test Key f5!", 1) end)
bind_hotkey('f6',  function() hs.alert.show("Test Key f6!", 1) end)
bind_hotkey('f7',  function() hs.alert.show("Test Key f7!", 1) end)
bind_hotkey('f8',  function() hs.alert.show("Test Key f8!", 1) end)
bind_hotkey('f9',  function() hs.alert.show("Test Key f9!", 1) end)
bind_hotkey('f10', function() hs.alert.show("Test Key f10!", 1) end)
bind_hotkey('f11', function() hs.alert.show("Test Key f11!", 1) end)
bind_hotkey('f12', function() hs.alert.show("Test Key f12!", 1) end)

-- Global settings
min_height = 100



-- -- Toggle the window Maximized/Minimized from BOTTOM
-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "N", function()
--   local win = hs.window.focusedWindow()
--   local win_fr = win:frame()

--   local screen = win:screen()
--   local screen_fr = screen:frame()

--   print("win_fr.h: " .. win_fr.h)

--   if win_fr.h <= (min_height + 2) then
--     win_fr.y = 0
--     win_fr.h = screen_fr.h
--   else
--     win_fr.y = screen_fr.h - min_height
--     win_fr.h = min_height
--   end

--   win:setFrame(win_fr)
-- end)


-- function diff_within(a, b, delta)
--   return (math.abs(a - b) <= delta)
-- end

-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:frame()

--   if f.x == max.x and diff_within(f.w, (max.w / 2), 10) then
--     f.w = max.w / 2
--     if f.h < (max.h / 2) then
--       f.h = max.h / 2
--     else
--       local max_score = math.abs(max.h - f.h) / f.h
--       local mid_score = math.abs((max.h / 2) - f.h) / f.h
--       if max_score > mid_score then
--         f.h = max.h
--       else
--         f.h = max.h / 2
--       end
--     end
--   else
--     if f.x > 0 then
--       f.x = max.x
--     end
--     if not diff_within(f.w, (max.w / 2), 10) then
--       f.w = max.w / 2
--     end
--   end

--   win:setFrame(f)
-- end)


-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:frame()

--   -- new x location
--   local loc_x = max.x + (max.w / 2)
--   if f.x == loc_x and diff_within(f.w, (max.w / 2), 10) then
--     f.w = max.w / 2
--     if f.h < (max.h / 2) then
--       f.h = max.h / 2
--     else
--       local max_score = math.abs(max.h - f.h) / f.h
--       local mid_score = math.abs((max.h / 2) - f.h) / f.h
--       if max_score > mid_score then
--         f.h = max.h
--       else
--         f.h = max.h / 2
--       end
--     end
--   else
--     f.x = loc_x
--     if not diff_within(f.w, (max.w / 2), 10) then
--       f.w = max.w / 2
--     end
--   end

--   win:setFrame(f)
-- end)

-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:frame()

--   if f.x < (max.w / 2) then
--     f.x = max.x
--   else
--     f.x = max.x + (max.w / 2)
--   end
--   f.y = max.y
--   f.w = max.w / 2
--   if f.h < (max.h / 2) then
--     f.h = max.h / 2
--   else
--     f.h = max.h
--   end
--   win:setFrame(f)
-- end)

-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Down", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:frame()

--   if f.x < (max.w / 2) then
--     f.x = max.x
--   else
--     f.x = max.x + (max.w / 2)
--   end
--   f.y = max.y + (max.h / 2)
--   f.w = max.w / 2
--   f.h = max.h / 2
--   win:setFrame(f)
-- end)

-------------------------------------------------------------------------------
-- Three columns
-- 1, 2, 3 : to move to 1st, 2nd, or 3rd column
-- (T)op and (B)ottom : to move to TOP or BOTTOM half of screen
-------------------------------------------------------------------------------

-- Toggle the window Maximized/Minimized from TOP
hs.hotkey.bind({"cmd", "alt", "ctrl"}, '1', function()
  print('hotkey 1')
  local win = hs.window.focusedWindow()
  local win_fr = win:frame()

  local screen = win:screen()
  local screen_fr = screen:frame()

  debug_info(screen_fr, win_fr)

  win_fr.x = screen_fr.x
  win_fr.w = screen_fr.w / 3

  debug_info(screen_fr, win_fr)

  win:setFrame(win_fr)
  hs.grid.snap(win)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, '2', function()
  print('hotkey 2')
  local win = hs.window.focusedWindow()
  local win_fr = win:frame()

  local screen = win:screen()
  local screen_fr = screen:frame()

  debug_info(screen_fr, win_fr)

  win_fr.w = screen_fr.w / 3
  win_fr.x = screen_fr.x + win_fr.w

  debug_info(screen_fr, win_fr)

  win:setFrame(win_fr)
  hs.grid.snap(win)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, '3', function()
  print('hotkey 3')
  local win = hs.window.focusedWindow()
  local win_fr = win:frame()

  local screen = win:screen()
  local screen_fr = screen:frame()

  debug_info(screen_fr, win_fr)

  win_fr.w = screen_fr.w / 3
  win_fr.x = screen_fr.x + 2 * win_fr.w

  debug_info(screen_fr, win_fr)

  win:setFrame(win_fr)
  hs.grid.snap(win)
end)

-- two columns - LEFT of screen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, '4', function()
  local win = hs.window.focusedWindow()
  local win_fr = win:frame()

  local screen = win:screen()
  local screen_fr = screen:frame()

  win_fr.w = (screen_fr.w / 5) * 3
  win_fr.x = screen_fr.x

  win:setFrame(win_fr)
  hs.grid.snap(win)
end)

-- two columns - RIGHT of screen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, '5', function()
  local win = hs.window.focusedWindow()
  local win_fr = win:frame()

  local screen = win:screen()
  local screen_fr = screen:frame()

  win_fr.w = (screen_fr.w / 5) * 3
  win_fr.x = screen_fr.x + (screen_fr.w / 3)

  win:setFrame(win_fr)
  hs.grid.snap(win)
end)

-- four/seventh of screen - LEFT of screen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, '6', function()
  local win = hs.window.focusedWindow()
  local win_fr = win:frame()

  local screen = win:screen()
  local screen_fr = screen:frame()

  win_fr.w = (screen_fr.w / 7) * 4
  win_fr.x = screen_fr.x

  win:setFrame(win_fr)
  hs.grid.snap(win)
end)

-- four/seventh of screen - CENTER of screen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, '7', function()
  local win = hs.window.focusedWindow()
  local win_fr = win:frame()

  local screen = win:screen()
  local screen_fr = screen:frame()

  win_fr.w = (screen_fr.w / 7) * 4
  win_fr.x = screen_fr.x + (screen_fr.w / 7) * 1.5

  win:setFrame(win_fr)
  hs.grid.snap(win)
end)

-- four/seventh of screen - RIGHT of screen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, '8', function()
  local win = hs.window.focusedWindow()
  local win_fr = win:frame()

  local screen = win:screen()
  local screen_fr = screen:frame()

  win_fr.w = (screen_fr.w / 7) * 4
  win_fr.x = screen_fr.x + (screen_fr.w / 7) * 3

  win:setFrame(win_fr)
  hs.grid.snap(win)
end)

-- Move to TOP-HALF
hs.hotkey.bind({"cmd", "alt", "ctrl"}, 'T', function()
  local win = hs.window.focusedWindow()
  local win_fr = win:frame()

  local screen = win:screen()
  local screen_fr = screen:frame()

  win_fr.y = screen_fr.y
  win_fr.h = screen_fr.h / 2

  win:setFrame(win_fr)
  hs.grid.snap(win)
end)

-- Move to BOTTOM-HALF
hs.hotkey.bind({"cmd", "alt", "ctrl"}, 'B', function()
  local win = hs.window.focusedWindow()
  local win_fr = win:frame()

  local screen = win:screen()
  local screen_fr = screen:frame()

  win_fr.h = screen_fr.h / 2
  win_fr.y = screen_fr.h - win_fr.h + 23

  win:setFrame(win_fr)
  hs.grid.snap(win)
end)

-------------------------------------------------------------------------------
-- Two columns
-------------------------------------------------------------------------------
hs.hotkey.bind({"cmd", "alt", "ctrl"}, 'W', function()
  local win = hs.window.focusedWindow()
  local win_fr = win:frame()

  local screen = win:screen()
  local screen_fr = screen:frame()

  win_fr.x = screen_fr.x
  win_fr.w = screen_fr.w / 2

  win:setFrame(win_fr)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, 'E', function()
  local win = hs.window.focusedWindow()
  local win_fr = win:frame()

  local screen = win:screen()
  local screen_fr = screen:frame()

  win_fr.w = screen_fr.w / 2
  win_fr.x = screen_fr.x + win_fr.w

  win:setFrame(win_fr)
end)

-------------------------------------------------------------------------------
-- Window sizes
-------------------------------------------------------------------------------
-- FULL HEIGHT
hs.hotkey.bind({"cmd", "alt", "ctrl"}, ';', function()
  local win = hs.window.focusedWindow()
  local win_fr = win:frame()

  local screen = win:screen()
  local screen_fr = screen:frame()

  win_fr.y = screen_fr.y
  win_fr.h = screen_fr.h

  win:setFrame(win_fr)
  hs.grid.snap(win)
end)

-- Golden ratio
hs.hotkey.bind({"cmd", "alt", "ctrl"}, 'G', function()
  local win = hs.window.focusedWindow()
  local win_fr = win:frame()

  local screen = win:screen()
  local screen_fr = screen:frame()

  debug_info(screen_fr, win_fr)

  local ratio = 1.6

  win_fr.w = (screen_fr.w - 16) / 21 * 10
  win_fr.h = win_fr.w / ratio

  debug_info(screen_fr, win_fr)

  win:setFrame(win_fr)
  hs.grid.snap(win)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, 'P', function()
  local win = hs.window.focusedWindow()
  local win_fr = win:frame()

  local screen = win:screen()
  local screen_fr = screen:frame()

  debug_info(screen_fr, win_fr)

  local ratio = 1.2

  win_fr.h = (screen_fr.h - 16) / 15 * 12
  win_fr.w = win_fr.h / ratio

  debug_info(screen_fr, win_fr)

  win:setFrame(win_fr)
  hs.grid.snap(win)
end)

-------------------------------------------------------------------------------
-- Machine control : sleep and hibernation
-------------------------------------------------------------------------------
hs.hotkey.bind({"cmd", "alt", "ctrl"}, 'Q', function()
    hs.caffeinate.lockScreen()
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, 'end', function()
    hs.caffeinate.systemSleep()
end)

-------------------------------------------------------------------------------
-- Application control
-------------------------------------------------------------------------------
-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "f8", function()
--   local app = hs.application.open("Preview.app")
-- end)

-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "f9", function()
--   local app = hs.application.open("Emacs.app")
-- end)

-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "f10", function()
--   local app = hs.application.open("MacVim.app")
-- end)

-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "f11", function()
--   local app = hs.application.open("FireFox.app")
-- end)

-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "f12", function()
--   local app = hs.application.open("iTerm.app")
-- end)

-------------------------------------------------------------------------------
-- Sending keystrokes for the pasteboard contents
-------------------------------------------------------------------------------
hs.hotkey.bind({"cmd", "alt", "ctrl"}, 'V', function()
    hs.eventtap.keyStrokes(hs.pasteboard.getContents())
    hs.pasteboard.clearContents()
end)


-------------------------------------------------------------------------------
-- Auto reload config changes
-------------------------------------------------------------------------------

hs.hotkey.bind({"cmd", "alt", "ctrl"}, 'R', function()
  hs.reload()
end)

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/init.lua", reloadConfig):start()
hs.alert.show("Config loaded")


-------------------------------------------------------------------------------
-- Window movement modal mode Cmd+Ctrl+M
-------------------------------------------------------------------------------
function golden_ratio()
  local win = hs.window.focusedWindow()
  local win_fr = win:frame()
  local screen = win:screen()
  local screen_fr = screen:frame()

  debug_info(screen_fr, win_fr)

  local ratio = 1.6

  win_fr.w = screen_fr.w / hs.grid.GRIDWIDTH * 10
  win_fr.h = win_fr.w / ratio
  win_fr.x = (screen_fr.w - (win_fr.w + hs.grid.MARGINX))
  win_fr.y = (screen_fr.h - (win_fr.h + hs.grid.MARGINY))

  debug_info(screen_fr, win_fr)

  win:setFrame(win_fr)
  -- hs.grid.snap(win)
end

function golden_ratio_vertical()
  local win = hs.window.focusedWindow()
  local win_fr = win:frame()
  local screen = win:screen()
  local screen_fr = screen:frame()

  debug_info(screen_fr, win_fr)

  local ratio = 1.6

  win_fr.w = screen_fr.w / hs.grid.GRIDWIDTH * 10
  win_fr.h = screen_fr.h
  win_fr.x = (screen_fr.w - (win_fr.w + hs.grid.MARGINX))
  win_fr.y = (screen_fr.h - (win_fr.h + hs.grid.MARGINY))

  debug_info(screen_fr, win_fr)

  win:setFrame(win_fr)
  hs.grid.snap(win)
end

wm = hs.hotkey.modal.new({"ctrl"}, 'return', 'Window Movement')
-- function wm:entered() hs.alert('Enter Win-Mov Mode') end
-- function wm:exited() hs.alert('Exit Win-Mov Mode') end
wm:bind('', 'escape', function() wm:exit() end)
wm:bind('', 'return', function() wm:exit() end)
wm:bind('', 'H', 'Left',  hs.grid.pushWindowLeft)
wm:bind('', 'J', 'Down',  hs.grid.pushWindowDown)
wm:bind('', 'K', 'Up',    hs.grid.pushWindowUp)
wm:bind('', 'L', 'Right', hs.grid.pushWindowRight)
wm:bind('', 'I', 'Taller', hs.grid.resizeWindowTaller)
wm:bind('', 'O', 'Shorter', hs.grid.resizeWindowShorter)
wm:bind('', '[', 'Thinner', hs.grid.resizeWindowThinner)
wm:bind('', ']', 'Wider', hs.grid.resizeWindowWider)
wm:bind('', 'M', 'Maximized', function()
          hs.grid.maximizeWindow()
          wm:exit()
end)
wm:bind('', 'N', 'Next Screen', function()
          hs.grid.pushWindowNextScreen()
          wm:exit()
end)
wm:bind('', 'G', 'Standard Size (H)', function()
          golden_ratio()
          wm:exit()
end)
wm:bind('', '1', 'Standard Size', function()
          golden_ratio()
          snap_window_up()
          snap_window_left()
          wm:exit()
end)
wm:bind('', '2', 'Standard Size', function()
          golden_ratio()
          snap_window_left()
          wm:exit()
end)
wm:bind('', '3', 'Standard Size', function()
          golden_ratio()
          snap_window_up()
          wm:exit()
end)
wm:bind('', '4', 'Standard Size', function()
          golden_ratio()
          snap_window_right()
          snap_window_down()
          wm:exit()
end)
wm:bind('', 'V', 'Standard Size (V)', function()
          golden_ratio_vertical()
          wm:exit()
end)
