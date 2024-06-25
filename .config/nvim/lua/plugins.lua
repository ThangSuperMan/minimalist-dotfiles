local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local icons = require 'config/icons'


local logo = [[
 _________  ___  ___  ________  ________   ________          ________  ___  ___  ________  ________      
|\___   ___\\  \|\  \|\   __  \|\   ___  \|\   ____\        |\   __  \|\  \|\  \|\   __  \|\   ___  \    
\|___ \  \_\ \  \\\  \ \  \|\  \ \  \\ \  \ \  \___|        \ \  \|\  \ \  \\\  \ \  \|\  \ \  \\ \  \   
     \ \  \ \ \   __  \ \   __  \ \  \\ \  \ \  \  ___       \ \   ____\ \   __  \ \   __  \ \  \\ \  \  
      \ \  \ \ \  \ \  \ \  \ \  \ \  \\ \  \ \  \|\  \       \ \  \___|\ \  \ \  \ \  \ \  \ \  \\ \  \ 
       \ \__\ \ \__\ \__\ \__\ \__\ \__\\ \__\ \_______\       \ \__\    \ \__\ \__\ \__\ \__\ \__\\ \__\
        \|__|  \|__|\|__|\|__|\|__|\|__| \|__|\|_______|        \|__|     \|__|\|__|\|__|\|__|\|__| \|__|
]]

logo = string.rep("\n", 4) .. logo .. "\n\n"

return require('lazy').setup({
  -- Completion
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-nvim-lsp-signature-help" },
  { "hrsh7th/nvim-cmp", config = require "plugins.cmp" },
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    -- optionally, override the default options:
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end
  },
  -- { 'mfussenegger/nvim-jdtls' },

  -- Debug
  -- { "mfussenegger/nvim-dap", config = require("plugins.dap") },

  -- { "jay-babu/mason-nvim-dap.nvim", config = function()
  --   require("mason-nvim-dap").setup({
  --     ensure_installed = { "node2" }
  --   })
  -- end
  -- },
  -- { "rcarriga/nvim-dap-ui",
  --   event = "VeryLazy",
  --   dependencies = "mfussenegger/nvim-dap",
  --   config = function()
  --     local dap = require("dap")
  --     local dapui = require("dapui")

  --     require("dapui").setup()
  --     dap.listeners.after.event_initialized["dapui_config"] = function()
  --       dapui.open({})
  --     end
  --     dap.listeners.before.event_terminated["dapui_config"] = function()
  --       dapui.close({})
  --     end
  --     dap.listeners.before.event_exited["dapui_config"] = function()
  --       dapui.close({})
  --     end
  --   end
  -- },

  -- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = require("plugins.treesitter"),
	},

  { 
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() 
      vim.g.mkdp_filetypes = { "markdown" } 
    end,
    ft = { "markdown" } 
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {} ,
  },
  {
    "lewis6991/gitsigns.nvim",
      event = "BufReadPre",
      opts = function()
        local icons = require("config.icons")
        --- @type Gitsigns.Config
        local C = {
          -- signs = {
          --   add = { text = icons.git.added },
          --   change = { text = icons.git.changed },
          --   delete = { text = icons.git.deleted },
          --   topdelete = { text = icons.git.deleted },
          --   changedelete = { text = icons.git.changed },
          --   untracked = { text = icons.git.added },
          -- },
          on_attach = function(buffer)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, desc)
              vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
            end

            map({ "n", "v" }, "<leader>gg", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
            map({ "n", "v" }, "<leader>gx", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
            map("n", "<leader>gp", gs.preview_hunk, "Stage Buffer")
            map("n", "<leader>gn", gs.next_hunk, "Stage Buffer")
            map("n", "<leader>gG", gs.stage_buffer, "Stage Buffer")
            map("n", "<leader>gh", gs.preview_hunk, "Preview Hunk")
            map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
            map("n", "<leader>gX", gs.reset_buffer, "Reset Buffer")
            map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
            map("n", "<leader>gb", function()
              gs.blame_line({ full = true })
            end, "Blame Line")
            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
          end,
        }
        return C
      end,
      keys = {
        -- git hunk navigation - previous / next
        { "gh", ":Gitsigns next_hunk<CR>", desc = "Goto next git hunk" },
        { "gH", ":Gitsigns prev_hunk<CR>", desc = "Goto previous git hunk" },
        { "]g", ":Gitsigns next_hunk<CR>", desc = "Goto next git hunk" },
        { "[g", ":Gitsigns prev_hunk<CR>", desc = "Goto previous git hunk" },
      },
  },

  {
    "iamcco/markdown-preview.nvim",
    config = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  {
    "jellydn/hurl.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter"
    },
    ft = "hurl",
    opts = {
      -- Show debugging info
      debug = false,
      -- Show notification on run
      show_notification = false,
      -- Show response in popup or split
      mode = "popup",
      -- Default formatter
      formatters = {
        json = { 'jq' }, -- Make sure you have install jq in your system, e.g: brew install jq
        html = {
          'prettier', -- Make sure you have install prettier in your system, e.g: npm install -g prettier
          '--parser',
          'html',
        },
      },
    },
    keys = {
      -- Run API request
      { "<leader>A", "<cmd>HurlRunner<CR>", desc = "Run All requests" },
      { "<leader>a", "<cmd>HurlRunnerAt<CR>", desc = "Run Api request" },
      { "<leader>te", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to entry" },
      { "<leader>tm", "<cmd>HurlToggleMode<CR>", desc = "Hurl Toggle Mode" },
      { "<leader>tv", "<cmd>HurlVerbose<CR>", desc = "Run Api in verbose mode" },
      -- Run Hurl request in visual mode
      { "<leader>h", ":HurlRunner<CR>", desc = "Hurl Runner", mode = "v" },
    },
  },

  {
		"rest-nvim/rest.nvim",
		dependencies = { { "nvim-lua/plenary.nvim" } },
    config = require 'plugins.rest',
		keys = {
			{
				"<leader>r",
				"Rest run",
				desc = "Test the current file",
			},
		},
	},

  -- { "folke/noice.nvim", config = require 'plugins.noice' },

	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 5000,
			background_colour = "#000000",
			render = "wrapped-compact",
		},
	},

  -- Refactoring
  -- {
		-- "smjonas/inc-rename.nvim",
		-- cmd = "IncRename",
		-- keys = {
			-- {
				-- "<leader>rn",
				-- function()
					-- return ":IncRename " .. vim.fn.expand("<cword>")
				-- end,
				-- desc = "Incremental rename",
				-- mode = "n",
				-- noremap = true,
				-- expr = true,
			-- },
		-- },
		-- config = true,
	-- },

  {
		"ThePrimeagen/refactoring.nvim",
		keys = {
			{
				"<leader>r",
				function()
					require("refactoring").select_refactor({
						show_success_message = true,
					})
				end,
				mode = "v",
				noremap = true,
				silent = true,
				expr = false,
			},
		},
		opts = {},
	},
		
  -- Colorizer
  -- { 'norcalli/nvim-colorizer.lua', config = require 'plugins.colorizer' },

  -- Surround
  { 'tpope/vim-surround' },
  { 'windwp/nvim-ts-autotag' },
  { 'alvan/vim-closetag', config = require 'plugins.closetag' },
  { 'jiangmiao/auto-pairs' },

  { 'terryma/vim-multiple-cursors' },

  -- Comment
  { 'tpope/vim-commentary' },

  -- Snippet
  { 'LazyVim/LazyVim' },
  { 'L3MON4D3/LuaSnip' },
  { 'saadparwaiz1/cmp_luasnip', config = require 'plugins.luasnip' },

  -- AI Assistant
  -- {
		-- "Exafunction/codeium.vim",
		-- lazy = false,
		-- config = function()
			-- vim.keymap.set("i", "<c-g>", function()
				-- return vim.fn["codeium#Accept"]()
			-- end, { expr = true })
			-- vim.keymap.set("i", "<c-;>", function()
				-- return vim.fn["codeium#CycleCompletions"](1)
			-- end, { expr = true })
			-- vim.keymap.set("i", "<c-,>", function()
				-- return vim.fn["codeium#CycleCompletions"](-1)
			-- end, { expr = true })
			-- vim.keymap.set("i", "<c-x>", function()
				-- return vim.fn["codeium#Clear"]()
			-- end, { expr = true })
		-- end,
	-- },

  {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		keys = {
			{
				"<leader>td",
				"<cmd>TroubleToggle<cr>",
				desc = "Trouble",
			},
		},

		config = function()
			require("trouble").setup({})
		end,
	},

  {
		"windwp/nvim-spectre",
		keys = {
			{
				"<leader>sr",
				function()
					require("spectre").open()
				end,
				desc = "Replace in files (Spectre)",
			},
		},
	},

	{ 'psliwka/vim-smoothie' },

  { "sainnhe/everforest", config = require("plugins.theme") },
  
  -- { "sainnhe/gruvbox-material", config = require("plugins.theme") },
  -- { "neanias/everforest-nvim", config = require("plugins.theme") },
  -- { "rose-pine/neovim", name = "rose-pine", config = require("plugins.theme") },
  -- { "neanias/everforest-nvim", config = require("plugins.theme") },
  -- { "/rafamadriz/neon", config = require("plugins.theme") },
  -- { "NLKNguyen/papercolor-theme", config = require("plugins.theme") },
  -- { "ellisonleao/gruvbox.nvim", priority = 1000 , config = require("plugins.theme") },
  
  { 
    "xiyaowong/nvim-transparent", config = function()
      -- Fix error can not have apply transparent for neo-tree
      require('transparent').clear_prefix('NeoTree')

      require("transparent").setup({
        extra_groups = {
          "NeoTreeFileIcon",
          "NeoTreeExpander"
        },
          exclude_grops = {
          }, -- table: groups you don't want to clear
      })
    end
  },

  -- {
  --   "DreamMaoMao/yazi.nvim",
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim",
  --     "nvim-lua/plenary.nvim",
  --   },

  --   keys = {
  --     { "<c-t>", "<cmd>Yazi<CR>", desc = "Toggle Yazi" },
  --   },
  -- },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    config = require("plugins.neotree"),
  },

  {
    "phaazon/hop.nvim",
    branch = "v2",
    config = function()
      require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
      vim.keymap.set("n", "fw", "<cmd>:HopChar2<cr>")
      vim.keymap.set("n", "fe", "<cmd>:HopPattern<cr>")
      vim.keymap.set("n", "<leader>hl", "<cmd>lua require'hop'.hint_lines()<cr>")
    end,
  },

  {
    "max397574/better-escape.nvim", config = function()
      require("better_escape").setup({
        mapping = { "jk" },
        timeout = 200
      })
    end,
  },
  { 'folke/which-key.nvim', config = require 'plugins.which-key' },
  
  {
		"voldikss/vim-floaterm",
		config = function()
			vim.g.floaterm_wintype = "float"
			vim.g.floaterm_position = "center"
			vim.g.floaterm_width = 0.9
			vim.g.floaterm_height = 0.7
			vim.g.floaterm_keymap_toggle = "<C-\\>"
		end,
	},

  -- Barbar, bufferline
  -- { 'romgrk/barbar.nvim', config = require 'plugins.barbar' },
  { 
    "b0o/incline.nvim",
    enabled = true,
    config = require 'plugins.incline'
  },
  {
		"dinhhuy258/git.nvim",
		event = "BufReadPre",
    config = function()
      require('git').setup({
        keymaps = {
          -- Open blame window
          blame = "<Leader>gb",
          -- Open file/folder in git repository
          browse = "<Leader>go",
          -- Diff
          diff = "<Leader>gd",
        },
      })
    end
	},

  {
    "rhysd/git-messenger.vim"
  },

  -- { "ThePrimeagen/harpoon" },

  { 'kyazdani42/nvim-web-devicons' },
  { 'ryanoasis/vim-devicons' },
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   enabled = true,
  --   event = "VeryLazy",
  --   opts = function(plugin)
  --     if plugin.override then
  --       require("lazyvim.util").deprecate("lualine.override", "lualine.opts")
  --     end

  --     local icons = require("config.icons")

  --     local diagnostics = {
  --       "diagnostics",
  --       sources = { "nvim_diagnostic" },
  --       sections = { "error", "warn", "info", "hint" },
  --       symbols = {
  --         error = icons.diagnostics.Error,
  --         hint = icons.diagnostics.Hint,
  --         info = icons.diagnostics.Info,
  --         warn = icons.diagnostics.Warn,
  --       },
  --       colored = true,
  --       update_in_insert = false,
  --       always_visible = false,
  --     }

  --     local diff = {
  --       "diff",
  --       symbols = {
  --         added = icons.git.added .. " ",
  --         untracked = icons.git.added .. " ",
  --         modified = icons.git.changed .. " ",
  --         removed = icons.git.deleted .. " ",
  --       },
  --       colored = true,
  --       always_visible = false,
  --       source = function()
  --         local gitsigns = vim.b.gitsigns_status_dict
  --         if gitsigns then
  --           return {
  --             added = gitsigns.added,
  --             modified = gitsigns.changed,
  --             removed = gitsigns.removed,
  --           }
  --         end
  --       end,
  --     }

  --     return {
  --       options = {
  --         theme = "auto",
  --         globalstatus = true,
  --         component_separators = { left = "", right = "" },
  --         disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
  --       },
  --       sections = {
  --         lualine_a = {},
  --         lualine_b = {},
  --         lualine_c = { diff, diagnostics },
  --         lualine_x = {},
  --         lualine_y = {},
  --         lualine_z = {},
  --       },
  --     }
  --   end,
  -- },
  -- Prettier
  { 'mhartington/formatter.nvim', config = require 'plugins.prettier' },
  { 'neovim/nvim-lspconfig', config = require 'plugins.lsp' },
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup({
        ui = {
          code_action = ''
        },
        symbol_in_winbar = {
          enable = false
        },
      })
    end,
  },

  {
    "Wansmer/symbol-usage.nvim",
    event = "LspAttach",
    opts = {
      vt_position = "end_of_line",
      text_format = function(symbol)
        if symbol.references then
          local usage = symbol.references <= 1 and "usage" or "usages"
          local num = symbol.references == 0 and "no" or symbol.references
          return string.format(" 󰌹 %s %s", num, usage)
        else
          return ""
        end
      end,
    },
  },

  -- { 'RRethy/vim-illuminate', config = require('plugins.illuminate') },

  {
    "kevinhwang91/nvim-ufo",
    enabled = true,
    dependencies = { "kevinhwang91/promise-async" },
    event = "BufRead",
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
      },
      {
        "K",
        function()
          local winid = require("ufo").peekFoldedLinesUnderCursor()
          if not winid then
            vim.lsp.buf.hover()
          end
        end,
      },
    },
    config = function()
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      vim.o.foldcolumn = "0"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 100
      vim.o.foldenable = true
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" 󰁂 %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end

      require("ufo").setup({
        fold_virt_text_handler = handler,
        close_fold_kinds_for_ft = {
          default = { "imports", "comment" },
          json = { "array" },
          c = { "comment", "region" },
        },
      })
    end,
  },

  {
        'stevearc/dressing.nvim',
        lazy = true,
        opts = {
            input = {
                win_options = {
                    -- Use a purple-ish border.
                    winhighlight = 'FloatBorder:LspFloatWinBorder',
                    winblend = 5,
                },
            },
            select = {
                trim_prompt = false,
                get_config = function(opts)
                    if opts.kind == 'codeaction' then
                        -- Cute and compact code action menu.
                        return {
                            backend = 'builtin',
                            builtin = {
                                relative = 'cursor',
                                max_height = 0.33,
                                min_height = 5,
                                max_width = 0.40,
                                mappings = { ['q'] = 'Close' },
                                win_options = {
                                    -- Same UI as the input field.
                                    winhighlight = 'FloatBorder:LspFloatWinBorder,DressingSelectIdx:LspInfoTitle,MatchParen:Ignore',
                                    winblend = 5,
                                },
                            },
                        }
                    end

                    local winopts = { height = 0.6, width = 0.5 }

                    -- Smaller menu for snippet choices.
                    if opts.kind == 'luasnip' then
                        opts.prompt = 'Snippet choice: '
                        winopts = { height = 0.35, width = 0.3 }
                    end

                    -- Fallback to fzf-lua.
                    return {
                        backend = 'fzf_lua',
                        fzf_lua = { winopts = winopts },
                    }
                end,
            },
        },
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require('lazy').load { plugins = { 'dressing.nvim' } }
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require('lazy').load { plugins = { 'dressing.nvim' } }
                return vim.ui.input(...)
            end
        end,
    },

  -- { 'jose-elias-alvarez/typescript.nvim' },
  { 'onsails/lspkind-nvim', config = require 'plugins.kind' },

  -- Ruby on Rails
  -- { 'vim-test/vim-test', config = require 'plugins.rails-test' },
  { 'tpope/vim-rails' },
  { 'tpope/vim-rails' },
  { 'deepredsky/vim-rubocop' },
  -- { 'andrewradev/splitjoin.vim' },

  -- Fzf
  -- { 'ibhagwan/fzf-lua', config = require("plugins.fzf")},
  {
    'ibhagwan/fzf-lua',
    cmd = 'FzfLua',
    keys = {
        { '<leader>f<', '<cmd>FzfLua resume<cr>', desc = 'Resume last command' },
        {
            '<leader>fb',
            function()
                require('fzf-lua').lgrep_curbuf {
                    winopts = {
                        height = 0.6,
                        width = 0.8,
                        preview = { vertical = 'up:70%' },
                    },
                }
            end,
            desc = 'Grep current buffer',
        },
        { '<leader>fc', '<cmd>FzfLua highlights<cr>', desc = 'Highlights' },
        { '<leader>fd', '<cmd>FzfLua lsp_document_diagnostics<cr>', desc = 'Document diagnostics' },
        { '<leader>fD', '<cmd>FzfLua lsp_workspace_diagnostics<cr>', desc = 'Workspace diagnostics' },
        { '<leader>ff', '<cmd>FzfLua files<cr>', desc = 'Find files' },
        { '<leader>fg', '<cmd>FzfLua live_grep_glob<cr>', desc = 'Grep' },
        { '<leader>fs', '<cmd>FzfLua git_status<cr>', desc = 'Find git status files' },
        { '<leader>fg', '<cmd>FzfLua grep_visual<cr>', desc = 'Grep', mode = 'x' },
        { '<leader>fh', '<cmd>FzfLua help_tags<cr>', desc = 'Help' },
        {
            '<leader>fr',
            function()
                -- Read from ShaDa to include files that were already deleted from the buffer list.
                vim.cmd 'rshada!'
                require('fzf-lua').oldfiles()
            end,
            desc = 'Recently opened files',
        },
    },
    opts = function()
        local actions = require 'fzf-lua.actions'

        return {
            -- Make stuff better combine with the editor.
            fzf_colors = {
                bg = { 'bg', 'Normal' },
                gutter = { 'bg', 'Normal' },
                info = { 'fg', 'Conditional' },
                scrollbar = { 'bg', 'Normal' },
                separator = { 'fg', 'Comment' },
            },
            fzf_opts = {
                ['--info'] = 'default',
                ['--layout'] = 'reverse-list',
            },
            keymap = {
                builtin = {
                    ['<C-/>'] = 'toggle-help',
                    ['<C-a>'] = 'toggle-fullscreen',
                    ['<C-i>'] = 'toggle-preview',
                    ['<C-f>'] = 'preview-page-down',
                    ['<C-b>'] = 'preview-page-up',
                },
                fzf = {
                    ['alt-s'] = 'toggle',
                    ['alt-a'] = 'toggle-all',
                },
            },
            winopts = {
                height = 0.7,
                width = 0.8,
                preview = {
                    scrollbar = false,
                    layout = 'vertical',
                    vertical = 'up:40%',
                },
            },
            global_git_icons = false,
            -- Configuration for specific commands.
            files = {
                winopts = {
                    preview = { hidden = 'hidden' },
                },
            },
            grep = {
                header_prefix = icons.misc.search .. ' ',
            },
            helptags = {
                actions = {
                    -- Open help pages in a vertical split.
                    ['default'] = actions.help_vert,
                },
            },
            lsp = {
                symbols = {
                    symbol_icons = icons.symbol_kinds,
                },
            },
            oldfiles = {
                include_current_session = true,
                winopts = {
                    preview = { hidden = 'hidden' },
                },
            },
        }
    end,
  },
  -- { 'junegunn/fzf.vim', config = require("plugins.fzf") } ,

  -- { "junegunn/fzf" },
	-- { "junegunn/fzf.vim", config = require("plugins.fzf") },

  -- {
		-- "vuki656/package-info.nvim",
		-- dependencies = "MunifTanjim/nui.nvim",
		-- config = function()
			-- require("package-info").setup()
			-- -- vim.keymap.set({ "n" }, "<LEADER>ns", require("package-info").show, { silent = true, noremap = true })
			-- -- vim.keymap.set({ "n" }, "<LEADER>nc", require("package-info").hide, { silent = true, noremap = true })
		-- end,
	-- },

  {	
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        -- formatters
        "prettier",
        "prettierd",
        -- code spell
        "codespell",
        "misspell",
        "cspell",
        -- markdown
        "markdownlint",
        -- rustywind for tailwindcss
        "rustywind",
        -- astro
        "astro-language-server",
        -- Solidity
        "solidity",
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    opts = {
      linters_by_ft = {
        ["*"] = { "cspell", "codespell" },
        -- javascript = { "eslint_d" },
        -- javascriptreact = { "eslint_d" },
        -- typescriptreact = { "eslint_d" },
      }
    },
    config = function()
      local lint = require('lint')

      lint.linters_by_ft = {
        ["*"] = { "cspell", "codespell" },
        -- javascript = { "eslint_d" },
        -- javascriptreact = { "eslint_d" },
        -- typescriptreact = { "eslint_d" },
      }

      local lint_groups = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_groups,
        callback = function()
          lint.try_lint()
        end
      })

      vim.keymap.set('n', '<leader>l', function()
        lint.try_lint()
      end,
        { desc = 'Trigger linting for current file' }
      )
    end
  },

  -- Testing on the fly
  { "nvim-neotest/nvim-nio" },
  {
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-jest",
			"nvim-neotest/neotest-plenary",
		},
		opts = {
			-- Can be a list of adapters like what neotest expects,
			-- or a list of adapter names,
			-- or a table of adapter names, mapped to adapter configs.
			-- The adapter will then be automatically loaded with the config.
			adapters = {
				["neotest-plenary"] = {},
				["neotest-jest"] = {
					jestConfigFile = function()
						local file = vim.fn.expand("%:p")
						if string.find(file, "/packages/") then
							return string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts"
						end
						return vim.fn.getcwd() .. "/jest.config.ts"
					end,
					cwd = function()
						local file = vim.fn.expand("%:p")
						if string.find(file, "/packages/") then
							return string.match(file, "(.-/[^/]+/)src")
						end
						return vim.fn.getcwd()
					end,
				},
			},
			status = { virtual_text = true },
			output = { open_on_run = true },
			quickfix = {
				open = function()
					if require("lazyvim.util").has("trouble.nvim") then
						require("trouble").open({ mode = "quickfix", focus = false })
					else
						vim.cmd("copen")
					end
				end,
			},
		},
		config = function(_, opts)
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						-- Replace newline and tab characters with space for more compact diagnostics
						local message =
							diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)

			if require("lazyvim.util").has("trouble.nvim") then
				opts.consumers = opts.consumers or {}
				-- Refresh and auto close trouble after running tests
				---@type neotest.Consumer
				opts.consumers.trouble = function(client)
					client.listeners.results = function(adapter_id, results, partial)
						if partial then
							return
						end
						local tree = assert(client:get_position(nil, { adapter = adapter_id }))

						local failed = 0
						for pos_id, result in pairs(results) do
							if result.status == "failed" and tree:get_key(pos_id) then
								failed = failed + 1
							end
						end
						vim.schedule(function()
							local trouble = require("trouble")
							if trouble.is_open() then
								trouble.refresh()
								if failed == 0 then
									trouble.close()
								end
							end
						end)
						return {}
					end
				end
			end

			if opts.adapters then
				local adapters = {}
				for name, config in pairs(opts.adapters or {}) do
					if type(name) == "number" then
						if type(config) == "string" then
							config = require(config)
						end
						adapters[#adapters + 1] = config
					elseif config ~= false then
						local adapter = require(name)
						if type(config) == "table" and not vim.tbl_isempty(config) then
							local meta = getmetatable(adapter)
							if adapter.setup then
								adapter.setup(config)
							elseif meta and meta.__call then
								adapter(config)
							else
								error("Adapter " .. name .. " does not support setup")
							end
						end
						adapters[#adapters + 1] = adapter
					end
				end
				opts.adapters = adapters
			end

			require("neotest").setup(opts)
		end,
  -- stylua: ignore
    keys = {
      { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
      { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
      { "<leader>tT", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
    },
	},

  -- Dashboard
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
  },

  {
    "nvimdev/dashboard-nvim",
    lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    opts = function()
      local opts = {
        theme = "hyper",
        config = {
          packages = { enable = false },
          header = vim.split(logo, "\n"),
          shortcut = {
            {
              icon = "󰊳 ",
              desc = "Update",
              group = "@property",
              action = "Lazy update",
              key = "u",
            },
            {
              icon = " ",
              icon_hl = "@variable",
              desc = "Files",
              group = "Label",
              action = [[lua require('fzf-lua').files({cwd_prompt = false})]],
              key = "f",
            },
            {
              icon = " ",
              desc = "Live Grep",
              group = "Number",
              action = [[lua require('fzf-lua').live_grep({cwd_prompt = false, multiprocess = true})]],
              key = "g",
            },
            {
              icon = " ",
              desc = " Restore Session",
              group = "Number",
              action = [[lua require('persistence').load()]],
              key = "s",
            },
            {
              icon = " ",
              desc = "Config",
              group = "Number",
              action = [[lua require('fzf-lua').files({ cwd = '~/.config/nvim' })]],
              key = "c",
            },
            {
              icon = "󰒲 ",
              desc = " Lazy",
              group = "Number",
              action = "Lazy",
              key = "l",
            },
            {
              icon = " ",
              desc = " Quit",
              group = "Number",
              action = "qa",
              key = "q",
            },
          },
          footer = function()
            return { "productsway.com" }
          end,
          project = { enable = false },
          mru = { limit = 5, cwd_only = true },
        },
      }

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  },
  
  { 
    'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {}, config = function()
    require("ibl").setup({
      indent = {
        char = "∘"
      },
      exclude = {
        filetypes = { "dashboard" }
      },
    })
    end
  },

  -- { 
  --   'echasnovski/mini.indentscope', 
  --   config= function()
  --     require('mini.indentscope').setup({
  --       symbol = '▏',
  --     })
  --   end
  -- },

  { 'dstein64/vim-startuptime' },

  -- reduce the start up time
  { 'lewis6991/impatient.nvim', config = function()
    require('impatient')
  end
  }
})
