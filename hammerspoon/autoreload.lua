-- Returns path, filename, and extension
function splitFilename(filename)
	if hs.fs.attributes(filename, "mode") == "directory" then
		local path = filename:gsub("[\\/]$","")
		return path.."\\","",""
	end
	return filename:match("(.-)([^\\/]-([^\\/%.]+))$")
end

-- Reload config if a lua file changed
function contentChanged(files)
  local isLuaFile = false
  for key, value in pairs(files) do
    if value:match("%.lua$") then
      isLuaFile = true
    end
  end
  if isLuaFile then
    hs.reload()
    print("\tReload config!")
  end
end

-- Add entry to table if it does not exist
function addEntry(t, entry)
  if next(t) == nil then
    table.insert(t, entry)
    return
  end

  for key, value in pairs(t) do
    if value == entry then
      return
    end
  end
  table.insert(t, entry)
end

-- Gather all paths containing config lua files
local paths = {}
-- Add standard path
table.insert(paths, hs.configdir)
-- Add paths according to symbolic links
for file in hs.fs.dir(hs.configdir) do
  if file ~= "." and file ~= ".." and file~=nil and file:match("%.lua") then
    local f = hs.configdir .. "/" .. file
    -- If symbolic link get filepath to source
    if hs.fs.symlinkAttributes(f).mode == "link" then
      f = hs.execute("readlink " .. f)
      addEntry(paths, splitFilename(f))
    end
  end
end

-- Set up watchers for the config paths
watchers = {}
for key, value in pairs(paths) do
  hs.printf("Add watcher for path: %s\n", value)
  table.insert(watchers, hs.pathwatcher.new(value, contentChanged))
  watchers[#watchers]:start()
end
