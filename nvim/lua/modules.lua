local M = {}

local cmds = { "nu!", "nonu!" }
local current_index = 1

M.toggle_numbering = function()
	current_index = current_index % #cmds + 1
	vim.cmd("set " .. cmds[current_index])
	local signcolumn_setting = "auto"
	if cmds[current_index] == "nonu!" then
		signcolumn_setting = "yes:4"
	end
	vim.opt.signcolumn = signcolumn_setting
end

M.cowboy = function()
	---@type table?
	local ok = true
	for _, key in ipairs({ "h", "j", "k", "l", "+", "-" }) do
		local count = 0
		local timer = assert(vim.uv.new_timer())
		local map = key
		vim.keymap.set("n", key, function()
			if vim.v.count > 0 then
				count = 0
			end
			if count >= 10 and vim.bo.buftype ~= "nofile" then
				ok = pcall(vim.notify, "Hold it Cowboy!", vim.log.levels.WARN, {
					icon = "🤠",
					id = "cowboy",
					keep = function()
						return count >= 10
					end,
				})
				if not ok then
					return map
				end
			else
				count = count + 1
				timer:start(2000, 0, function()
					count = 0
				end)
				return map
			end
		end, { expr = true, silent = true })
	end
end

return M
