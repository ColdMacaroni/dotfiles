--@type MappingsTable

local M = {}

M.general = {
  v = {
    ["<leader>y"] = { [["+y]], "system clipboard yank", opts = { nowait = true } },
  },
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>y"] = { [["+y]], "system clipboard yank", opts = { nowait = true } },
    ["<leader>gg"] = { ":G<CR>", "Open fugitive", opts = { nowait = true } },
    -- Harpoon
    ["<leader>ha"] = {
      function()
        require("harpoon.mark").add_file()
      end,
      "Add harpoon mark",
      opts = { nowait = true },
    },
    ["<leader>hm"] = {
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
      "Open harpoon menu",
      opts = { nowait = true },
    },
    ["<leader>hn"] = {
      function()
        require("harpoon.ui").nav_next()
      end,
      "Go to next harpoon file",
      opts = { nowait = true },
    },
    ["<leader>hp"] = {
      function()
        require("harpoon.ui").nav_prev()
      end,
      "Go to previous harpoon file",
      opts = { nowait = true },
    },
    -- TS Context
    ["<leader>tt"] = {
      function()
        vim.cmd.TSContextToggle()
      end,
      "Toggle TreeSitter context",
      opts = { nowait = true },
    },
    ["<leader>tg"] = {
      function()
        require("treesitter-context").go_to_context()
      end,
      "Go to TreeSitter context",
      opts = { nowait = true },
    },
    -- Spelling
    ["<leader>fs"] = {
      "1z=",
      "Change to first spelling suggestion",
      opts = { nowait = true },
    },

    -- Bring up the cool menu
    ["<leader>tf"] = {
      "<cmd>TroubleToggle<cr>",
      "Toggle trouble window",
      opts = { silent = true },
    },
  },
}

-- more keybinds!

return M
