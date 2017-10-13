hs.window.animationDuration = 0

-- Window manager
function bindKey(key, fn)
  hs.hotkey.bind({"alt", "cmd"}, key, fn)
end

positions = {
  {key="h", pos=hs.layout.left50},              -- left
  {key="u", pos={x=0, y=0, w=0.5, h=0.5}},      -- upper left
  {key="k", pos={x=0, y=0, w=1, h=0.5}},        -- up
  {key="o", pos={x=0.5, y=0, w=0.5, h=0.5}},    -- upper right
  {key="l", pos=hs.layout.right50},             -- right
  {key=".", pos={x=0.5, y=0.5, w=0.5, h=0.5}},  -- lower right
  {key="j", pos={x=0, y=0.5, w=1, h=0.5}},      -- down
  {key="m", pos={x=0, y=0.5, w=0.5, h=0.5}},    -- lower left
  {key="f", pos=hs.layout.maximized}            -- maximized
}

hs.fnutils.each(positions, function(entry)
  bindKey(entry.key, function()
    hs.window.focusedWindow():moveToUnit(entry.pos)
  end)
end)
--
--
