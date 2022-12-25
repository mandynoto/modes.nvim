# modes.nvim

> Prismatic line decorations for the adventurous vim user, an experimental version of mvllow/modes.nvim

## Usage

```lua
use({
	'mandynoto/modes.nvim',
	config = function()
		require('modes').setup()
	end
})
```

![modes.nvim](https://user-images.githubusercontent.com/1474821/127896095-6da221cf-3327-4eed-82be-ce419bdf647c.gif)

## Options

```lua
require('modes').setup({
	colors = {
		change = '#008080',
		copy   = "#f5c359",
		delete = "#c75c6a",
		insert = "#78ccc5",
		visual = "#9745be",
	},

	-- Set opacity for cursorline and number background
	line_opacity = 0.15,

	-- Enable cursor highlights
	set_cursor = true,

	-- Enable cursorline initially, and disable cursorline for inactive windows
	-- or ignored filetypes
	set_cursorline = true,

	-- Enable line number highlights to match cursorline
	set_number = true,

	-- Disable modes highlights in specified filetypes
	-- Please PR commonly ignored filetypes
	ignore_filetypes = { 'NvimTree', 'TelescopePrompt' }
})
```

## Themes

| Highlight group | Default value   |
| --------------- | --------------- |
| `ModesChange`   | `guibg=#008080` |
| `ModesCopy`     | `guibg=#f5c359` |
| `ModesDelete`   | `guibg=#c75c6a` |
| `ModesInsert`   | `guibg=#78ccc5` |
| `ModesVisual`   | `guibg=#9745be` |

## Known issues

- Some _Which Key_ presets conflict with this plugin. For example, `d` and `y` operators will not apply highlights if `operators = true` because _Which Key_ takes priority

_Workaround:_

```lua
require('which-key').setup({
	plugins = {
		presets = {
			operators = false,
		},
	},
})
```
- Some nvim-surround presets will not trigger initial modes. For example, typing and entering `d` will not change cursor color because `ds` takes priorty for deleting a surround in normal mode. A fix is to change nvim-surround mappings by prefacing them with leader key so to not start with any of the modes in normal mode like: c, d, and y.

_Workaround:_

```lua
require('nvim-surround').setup({
    move_cursor = false,
    keymaps = {
      insert = "<C-g>s",
      insert_line = "<C-g>S",
      normal = "<Leader>s",
      normal_cur = "<Leader>ss",
      normal_line = "<Leader>ads",
      normal_cur_line = "<Leader>adhs",
      visual = "S",
      visual_line = "gS",
      delete = "<Leader>sd",
      change = "<Leader>sc",
    },
)}
```
