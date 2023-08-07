local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- c/cpp
  b.formatting.clang_format,
  b.diagnostics.clang_check,

  -- Rust
  b.formatting.rustfmt,

  -- Ruby
  b.formatting.rubocop,
  b.diagnostics.rubocop,

  -- bash
  b.formatting.shfmt,
  b.code_actions.shellcheck,

  -- php
  b.formatting.phpcbf,

  -- Python
  b.formatting.black.with { extra_args = { "--line-length", "79" } },

  -- SQL
  b.formatting.sqlfluff,

  -- LaTeX
  -- b.diagnostics.vale,
  b.formatting.latexindent,
  -- Css & stuff
  b.formatting.prettier,
  -- Java
  b.formatting.google_java_format,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
