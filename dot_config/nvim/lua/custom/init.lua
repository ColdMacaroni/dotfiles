local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

-- Open nvim-tree if folder is an arg
-- By griff-rees on GitHub
-- From https://github.com/NvChad/NvChad/discussions/1670#discussioncomment-5831471
-- Modified to *not* show nvim-tree if the buffer is [No Name]
local function open_nvim_tree(data)
  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  if directory then
    -- change to the directory
    vim.cmd.cd(data.file)
  end

  -- open the tree
  require("nvim-tree.api").tree.open()
end

autocmd({ "VimEnter" }, { callback = open_nvim_tree })

----

-- Set default tabs to 4 spaces
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- Bring up last edited line on file
vim.api.nvim_create_autocmd({ "BufRead" }, {
  callback = function()
    -- Only move to that mark if the buffer is long enough and not a commit

    local line_len = vim.fn.line "$"
    local mark_line = vim.fn.getpos("'\"")[2]

    local ft = vim.o.ft

    if mark_line <= line_len and ft ~= "gitcommit" then
      vim.cmd 'normal g`"'
      vim.cmd "normal zz"
    end
  end,
})

-- Disable autocompletion for markdown, enable spell check
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "markdown",
  callback = function()
    -- How do write
    vim.opt.spell = true

    -- Bye completion
    local cmp = require "cmp"
    cmp.setup { enabled = false }
  end,
})

local conf_dir = vim.env.XDG_CONFIG_HOME or vim.env.HOME .. "/.config"

local nvim_conf_dir = conf_dir .. "/nvim"

-- TODO! This doesn't work
vim.g.vscode_snippets_path = nvim_conf_dir .. "/mysnippets"

-- Be silly
print 'I loved when she said "it\'s nvim time" and nvimmed all over them'
