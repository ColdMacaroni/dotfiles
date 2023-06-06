local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "pyright", "jdtls", "phpactor", "sqlls", "cmake", "rust_analyzer", "bashls", "texlab"}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

---- clangd config
-- Fix encoding offset errors
-- https://github.com/neovim/neovim/pull/16694#issuecomment-996947306
local clangd_caps = capabilities
clangd_caps.offsetEncoding = { "utf-16" }

-- Reset to default
capabilities = require("plugins.configs.lspconfig").capabilities

lspconfig["clangd"].setup {
  on_attach = on_attach,
  capabilities = clangd_caps,
}

---- sqlls config
lspconfig["sqlls"].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "sql", "mysql", "sqlite" },
}
