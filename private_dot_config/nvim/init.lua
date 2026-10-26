-- Core config
local ok, _

-- Load core options
ok, _ = pcall(require, "core.options")
if not ok then
	vim.notify("Failed to load core.options", vim.log.levels.ERROR)
end

-- Load keymaps
ok, _ = pcall(require, "core.keymaps")
if not ok then
	vim.notify("Failed to load core.keymaps", vim.log.levels.ERROR)
end

-- Load autocommands
ok, _ = pcall(require, "core.autocmds")
if not ok then
	vim.notify("Failed to load core.autocmds", vim.log.levels.ERROR)
end

-- Load lazy plugin manager
ok, _ = pcall(require, "core.lazy")
if not ok then
	vim.notify("Failed to load core.lazy", vim.log.levels.ERROR)
end
