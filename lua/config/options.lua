-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- 4格tap
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
-- 不要高亮所在行
vim.opt.cursorline = false
-- 光标在行首尾时<Left><Right>可以跳到下一行
vim.opt.whichwrap = "<,>,[,]"
-- 边输入边搜索
vim.opt.incsearch = true

if vim.fn.exists("$SSH_TTY") == 1 and vim.env.TMUX == nil then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
elseif vim.fn.has("wsl") == 1 then
  ---@diagnostic disable-next-line: param-type-mismatch
  local script_folder = vim.fs.joinpath(vim.fn.stdpath("config"), "scripts")

  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      -- WARN: clip.exe might produce garbled text under certain conditions
      -- ['+'] = 'clip.exe',
      -- ['*'] = 'clip.exe',
      ["+"] = "win32yank.exe -i",
      ["*"] = "win32yank.exe -i",
    },
    paste = {
      -- -- ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      -- -- ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      -- ['+'] = 'win32yank.exe --1f',
      -- ['*'] = 'win32yank.exe --1f',
      ["+"] = vim.fs.joinpath(script_folder, "wsl-paste.sh"),
      ["*"] = vim.fs.joinpath(script_folder, "wsl-paste.sh"),
    },
    cache_enabled = true,
  }
end
