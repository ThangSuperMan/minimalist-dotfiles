return function()
  local home = vim.fn.expand('~')
  local nvim_lsp = require('lspconfig')
  local protocol = require('vim.lsp.protocol')
  local util = require("lspconfig.util")

  local function organize_imports()
    local params = {
      command = "_typescript.organizeImports",
      arguments = {vim.api.nvim_buf_get_name(0)},
      title = ""
    }

    vim.lsp.buf.execute_command(params)
end

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    -- require "lsp_signature".on_attach()  -- Note: add in lsp client on-attach

    -- require("twoslash-queries").attach(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Mappings.
    local opts = { noremap = true, silent = true }
  end

  --Enable (broadcasting) snippet capability for completion
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  nvim_lsp.cssls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "css", "scss" }
  }

  nvim_lsp.lua_ls.setup {
    on_attach = on_attach,
    settings = {
      Lua = {
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
          disable = { 'trailing-space' }
        },

        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false
        },
      },
    },
  }

  -- Dart
  -- Cmd for install: brew tap dart-lang/dart
  -- And: brew install dart
  nvim_lsp.dartls.setup {
    on_attach = on_attach,
  }

  nvim_lsp.clangd.setup{
    on_attach = on_attach,
  }

  -- npm install -g @prisma/language-server
  require 'lspconfig'.prismals.setup {
    on_attach = on_attach,
    capabilities = capabilities
  }

  -- Setup html
  nvim_lsp.html.setup {
    on_attach = on_attach,
    filetypes = { "html", "jsp",  "ejs", "eruby" },
    capabilities = capabilities,
  }
  -- Setup html

  -- Error handling for solidity to slow
  -- require 'lspconfig'.solang.setup {}

  -- Solidity
  -- cmd: sudo npm install -g solidity-language-server
  -- local lspconfig = require 'lspconfig'
  -- nvim_lsp.solidity_ls.setup {
  --   on_attach = on_attach,
  --   capabilities = capabilities,
  --   default_config = {
  --     cmd = { 'solidity-ls', '--stdio' },
  --     filetypes = { 'solidity' },
  --     root_dir = lspconfig.util.root_pattern('package.json', '.git'),
  --   },
  -- }

  nvim_lsp.tailwindcss.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  -- nvim_lsp.pyright.setup {
  --  on_attach = on_attach,
  --  capability = capabilities
  -- }

  -- Bash
  -- brew install shellcheck -> for linting(diagnostics)
  nvim_lsp.bashls.setup {
    on_attach = on_attach,
  }

  -- Golang
  nvim_lsp.gopls.setup {
    on_attach = on_attach,
    cmd = { "gopls", "serve" },
    settings = {
      analyses = {
        unusedparams = true
      },
      staticcheck = true
    }
  }

----------------------------------------------------------------------
--                               YAML                               --
----------------------------------------------------------------------
-- Website for get json schemas
-- https://www.schemastore.org/json/

-- nvim_lsp.yamlls.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = { "yml", "yaml", "yaml.docker-compose", "config" },
--   settings =  {
--     yaml = {
--       format = { enable = true },
--       editor = { formatOnType = true },
--       validate = true,
--       schemaDownload = { enable = true },
--       completion = true,
--       hover = true,
--       schemas = {
--         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
--         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
--         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
--         ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
--         ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
--         -- Load the ansible json (dictionay for codecompletion) for yamls use
--         ["file://" .. home .. "/.config/nvim/json-schema/ansible/inventory.yml.json"] = "*inventory*.{yml,yaml}",
--         ["file://" .. home .. "/.config/nvim/json-schema/ansible/playbook.yml.json"] = "*play*.{yml,yaml}",
--         ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
--         ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
--         ["file://" .. home .. "/.config/nvim/json-schema/gitlab.yml.json"] = "*gitlab-ci*.{yml,yaml}",
--         ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
--         ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose.{yml,yaml}",
--         ["https://raw.githubusercontent.com/robbyki/schemas/1f05c98df4ca8398f502f554734ff5e87acfcc4c/openshift/all.json"] = "/*.yaml",
--         kubernetes = { "/*.yaml" },
--       },
--     },
--   },
-- })
        
-- nvim_lsp.ansiblels.setup{
--   on_attach = on_attach,
--   ansible = {
--     ansible = {
--       path = "ansible"
--     },
--     executionEnvironment = {
--       enabled = false
--     },
--     python = {
--       interpreterPath = "python"
--     },
--     validation = {
--       enabled = true,
--       lint = {
--         enabled = true,
--         path = "ansible-lint"
--       }
--   }
-- }
-- }

----------------------------------------------------------------------
--                               Terraform                          --
----------------------------------------------------------------------

  -- nvim_lsp.tflint.setup{
  --   on_attach = on_attach
  -- }

  nvim_lsp.terraformls.setup{
    on_attach = on_attach
  }

  -- nvim_lsp.lua_ls.setup {
  --   on_attach = on_attach
  -- }
  
  -- nvim_lsp.yamlls.setup {
  --   on_attach = on_attach,
  --   capability = capabilities,
  --   settings = {
  --     yaml = {
  --       schemas = {
  --         ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
  --         ["../path/relative/to/file.yml"] = "/.github/workflows/*",
  --         ["/path/from/root/of/project"] = "/.github/workflows/*",
  --       },
  --   }
  -- }}

  -- Dockerfile
  nvim_lsp.dockerls.setup {
    on_attach = on_attach,
  }

  nvim_lsp.eslint.setup({
     on_attach = function(client, bufnr)
       vim.api.nvim_create_autocmd("BufWritePre", {
         buffer = bufnr,
         command = "EslintFixAll",
       })
     end,
  })

  -- nvim_lsp.jsonls.setup {
  --   on_attach = on_attach
  -- }
 
  -- nvim_lsp.angularls.setup {
  --   on_attach = on_attach
  -- }

  nvim_lsp.ruby_lsp.setup {
    on_attach = on_attach,
    init_options = { formatter = "auto" },
  }

  nvim_lsp.rubocop.setup {
    on_attach = on_attach
  }
  
  -- nvim_lsp.solargraph.setup {
  --   on_attach = on_attach,
  -- }

  -- nvim_lsp.sorbet.setup {
  --   on_attach = on_attach,
  -- }
  
  nvim_lsp.tsserver.setup {
    on_attach = on_attach,
    root_dir = nvim_lsp.util.root_pattern("package.json"),
    filetypes = { "typescript", "typescriptreact", "typescript.tsx", "typescript.jsx", "javascript", "javascriptreact" },
    diagnostics = {
      disable = { 'trailing-space' }
    },
    commands = {
      OrganizeImports = {
      organize_imports,
      description = "Organize Imports"
    }
    },
  }

  -- Diagnostic symbols in the sign column (gutter)
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  -- Hanle disappear the lspconfig when using the insertmode
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
    update_in_insert = true,
    -- This sets the spacing and the prefix, obviously.
    -- virtual_text = false
    virtual_text = {
      spacing = 4,
      prefix = '●'
    },
  }
  )

  -- vim.keymap.set('n', '<leader>o', '<cmd>OrganizeImports <cr>')
  -- vim.keymap.set('n', '<leader>a', '<cmd>TypescriptAddMissingImports<cr>')
end
