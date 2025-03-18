local lspconfig = require("lspconfig")
local nvlsp = require("nvchad.configs.lspconfig")

-- List of LSP servers
local servers = { "html", "cssls", "ts_ls", "lua_ls", "tailwindcss", "eslint", "jdtls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end
