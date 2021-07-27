local utils = require("modes.utils")
local cmd = vim.cmd
local fn = vim.fn

local M = {}

function M.get_termcode(key)
	return vim.api.nvim_replace_termcodes(key, true, true, true)
end

function M.set_highlights(style)
	if style == "reset" then
		-- TODO: These should reset to the active colorscheme's defaults
		cmd("hi Visual guibg=#2a2837")
		cmd("hi CursorLine guibg=#211f2d")
		cmd("hi CursorLineNr guifg=#e0def4")
		cmd("hi ModeMsg guifg=None")
		return
	end

	if style == "delete" then
		cmd("hi CursorLine guibg=#2C1F2B")
		cmd("hi CursorLineNr guifg=#C75C6A")
		cmd("hi ModeMsg guifg=#C75C6A")
	end

	if style == "insert" then
		cmd("hi CursorLine guibg=#232933")
		cmd("hi CursorLineNr guifg=#78CCC5")
		cmd("hi ModeMsg guifg=#78CCC5")
	end

	if style == "visual" then
		cmd("hi Visual guibg=#2A1F39")
		cmd("hi CursorLine guibg=#2A1F39")
		cmd("hi CursorLineNr guifg=#9745BE")
		cmd("hi ModeMsg guifg=#9745BE")
	end
end

function M.setup()
	local last_mode = ""

	vim.register_keystroke_callback(function(key)
		local current_mode = fn.mode()

		if
			(key == M.get_termcode("<esc>"))
			or (current_mode == "c")
			or (last_mode == "V" and not current_mode == "V")
		then
			M.set_highlights("reset")
			return
		end

		if fn.mode() == "n" then
			if key == "d" then
				M.set_highlights("delete")
			end
			if key == "v" or key == "V" then
				M.set_highlights("visual")
			end
		end

		last_mode = current_mode
	end)

	utils.define_augroups({
		_modes = {
			{
				"InsertEnter",
				"*",
				'lua require("modes").set_highlights("insert")',
			},
			{
				"CmdlineLeave,InsertLeave",
				"*",
				'lua require("modes").set_highlights("reset")',
			},
		},
	})
end

return M