local base = require "plugins.configs.lspconfig"
local on_attach = base.on_attach
local capabilities = base.capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        ununsedparams = true,
      },
    },
  },
}

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
end

lspconfig.ts_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
  },
}

lspconfig.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          "@?class\\(([^]*)\\)",
          "'([^']*)'",
        },
      },
    },
  },
}

lspconfig.eslint.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.intelephense.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "php", "blade" },
  settings = {
    intelephense = {
      filetypes = { "php", "blade" },
      files = {
        associations = { "*.php", "*.blade.php" }, -- Associating .blade.php files as well
        maxSize = 5000000,
      },
    },
  },
}
