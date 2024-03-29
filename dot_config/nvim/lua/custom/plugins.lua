local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
    keys = {
      {
        "<leader>ll",
        function()
          local val = vim.diagnostic.config().virtual_text
          vim.diagnostic.config { virtual_lines = val, virtual_text = not val }
        end,
        "Toggle LSP line diagnostics",
      },
    },
  },

  {
    "lervag/vimtex",
    lazy = false,

    config = function()
      require "custom.configs.vimtex"
    end,
  },
  {
    "tpope/vim-fugitive",
    lazy = false,
  },
  {
    "chrisbra/NrrwRgn",
    cmd = { "NR" },
    keys = { "<leader>n" },
  },

  {
    "ThePrimeagen/harpoon",
    dependencies = {
      {
        "nvim-lua/plenary.nvim",
      },
    },
    keys = { "<leader>h" },
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
      },
    },
    config = function()
      require "custom.configs.treesitter-context"
    end,
    lazy = false,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "folke/trouble.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      highlight = {
        keyword = "fg",
      },
    },
    lazy = false,
  },

  {
    "sophacles/vim-processing",
    ft = { "processing" },
  },

  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n" },
      { "gc", mode = "v" },
      { "gbc", mode = "n" },
      { "gb", mode = "v" },
    },
    init = function()
      require("core.utils").load_mappings "comment"
    end,
    config = function(_, opts)
      require("Comment").setup(opts)
      -- Add custom comment strings
      require("Comment.ft").set("processing", { "// %s", "/* %s */" })
    end,
  },

  {
    "elkowar/yuck.vim",
    ft = "yuck",
  },

  {
    "eraserhd/parinfer-rust",
    ft = "yuck",
    build = "cargo build --release",
  },

  {
    "mbbill/undotree",
    lazy = false,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "InsertEnter",
    config = function()
      require "custom.configs/nvim-treesitter-textobjects"
    end,
    -- TODO: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    enabled = false,
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  -- Very good! LSP support for nvim's lua api
  -- { "folke/neodev.nvim", opts = {} },

  -- Better wildmenu, very good readme
  {
    "gelguy/wilder.nvim",
    config = function()
      local wilder = require "wilder"
      wilder.setup { modes = { ":", "/", "?" } }

      wilder.set_option(
        "renderer",
        wilder.popupmenu_renderer {
          highlighter = wilder.basic_highlighter(),
          highlights = {
            accent = wilder.make_hl(
              'WilderAccent', 'Pmenu', {{a = 1}, {a = 1}, {foreground = '#f4468f'}}),
          },
        })
    end,
    keys = { ":", "/", "?" },
  },
  -- {
  --     "glacambre/firenvim",
  --     cond = not not vim.g.started_by_firenvim,
  --     lazy = false,
  --     build = function()
  --         require("lazy").load({ plugins = "firenvim", wait = true })
  --         vim.fn["firenvim#install"](0)
  --     end,
  -- }
  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
