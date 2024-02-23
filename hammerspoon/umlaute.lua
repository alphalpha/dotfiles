hs.hotkey.bind({'option'}, 'u', function ()
  hs.eventtap.keyStrokes('ü')
end)

hs.hotkey.bind({'shift', 'option'}, 'u', function ()
  hs.eventtap.keyStrokes('Ü')
end)

hs.hotkey.bind({'option'}, 'a', function ()
  hs.eventtap.keyStrokes(' ä')
end)

hs.hotkey.bind({'shift', 'option'}, 'a', function ()
  hs.eventtap.keyStrokes(' Ä')
end)

hs.hotkey.bind({'option'}, 'o', function ()
  hs.eventtap.keyStrokes('ö')
end)

hs.hotkey.bind({'shift', 'option'}, 'o', function ()
  hs.eventtap.keyStrokes('Ö')
end)

hs.hotkey.bind({'option'}, 's', function ()
  hs.eventtap.keyStrokes('ß')
end)

hs.hotkey.bind({'alt'}, 'e', function ()
  hs.eventtap.keyStrokes('€')
end)
