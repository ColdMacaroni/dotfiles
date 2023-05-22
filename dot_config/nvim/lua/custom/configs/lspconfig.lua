local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "pyright", "jdtls", "phpactor", "sqlls" }

for _, lsp in ipairs(servers) do
  -- Fix encoding offset errors
  -- https://github.com/neovim/neovim/pull/16694#issuecomment-996947306
  if lsp == "clangd" then
    capabilities.offsetEncoding = { "utf-16" }
  end
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

