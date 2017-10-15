hs.window.animationDuration = 0

function bindKey(key, fn)
  hs.hotkey.bind({"alt", "cmd"}, key, fn)
end

positions = {
  {key="h", unit=hs.layout.left50},              -- left
  {key="u", unit={x=0, y=0, w=0.5, h=0.5}},      -- upper left
  {key="k", unit={x=0, y=0, w=1, h=0.5}},        -- up
  {key="o", unit={x=0.5, y=0, w=0.5, h=0.5}},    -- upper right
  {key="l", unit=hs.layout.right50},             -- right
  {key=".", unit={x=0.5, y=0.5, w=0.5, h=0.5}},  -- lower right
  {key="j", unit={x=0, y=0.5, w=1, h=0.5}},      -- down
  {key="m", unit={x=0, y=0.5, w=0.5, h=0.5}},    -- lower left
  {key="f", unit=hs.layout.maximized}            -- maximized
}

hs.fnutils.each(positions, function(entry)
  bindKey(entry.key, function()
    hs.window.focusedWindow():moveToUnit(entry.unit)
  end)
end)
