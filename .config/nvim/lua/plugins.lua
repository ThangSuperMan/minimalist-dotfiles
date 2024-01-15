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

  { "iamcco/markdown-preview.nvim",
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
          signs = {
            add = { text = icons.git.added },
            change = { text = icons.git.changed },
            delete = { text = icons.git.deleted },
            topdelete = { text = icons.git.deleted },
            changedelete = { text = icons.git.changed },
            untracked = { text = icons.git.added },
          },
          on_attach = function(buffer)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, desc)
              vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
            end

            map({ "n", "v" }, "<leader>gg", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
            map({ "n", "v" }, "<leader>gx", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
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

	-- {
	-- 	"akinsho/git-conflict.nvim",
	-- 	config = function()
	-- 		require("git-conflict").setup()
	-- 	end,
	-- },

  {
    "iamcco/markdown-preview.nvim",
    config = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- Colorizer
  { 'norcalli/nvim-colorizer.lua', config = require 'plugins.colorizer' },

  -- Surround
  { 'tpope/vim-surround' },
  { 'windwp/nvim-ts-autotag' },
  { 'alvan/vim-closetag', config = require 'plugins.closetag' },
  { 'jiangmiao/auto-pairs' },

  { 'terryma/vim-multiple-cursors' },

  -- Comment
  { 'tpope/vim-commentary' },

  -- Snippet
  { 'L3MON4D3/LuaSnip' },
  { 'saadparwaiz1/cmp_luasnip', config = require 'plugins.luasnip' },

  -- AI Assistent
  {
		"Exafunction/codeium.vim",
		lazy = false,
		config = function()
			vim.keymap.set("i", "<c-g>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
			vim.keymap.set("i", "<c-;>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true })
			vim.keymap.set("i", "<c-,>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true })
			vim.keymap.set("i", "<c-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true })
		end,
	},

  -- {
  -- "jackMort/ChatGPT.nvim",
  --   event = "VeryLazy",
  --   config = require 'plugins.chatgpt',
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim"
  --   }
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

  -- references
  -- {
		-- "nvimdev/dashboard-nvim",
  --   lazy = false,
	-- },

  -- { "sainnhe/everforest", config = require("plugins.theme") },
  -- { 'Th3Whit3Wolf/space-nvim', config = require("plugins.theme") },
  -- { 'yorickpeterse/nvim-grey', config = require("plugins.theme") },
  {
    'ray-x/starry.nvim',
    config = function()
      require('starry').setup {
        -- border = false, -- Split window borders
        -- italics = {
        --   comments = true,
        --   strings = false,
        --   keywords = false,
        --   functions = false,
        --   variables = false
        -- },
        -- contrast = {       -- Select which windows get the contrast background
        --   enable = false,  -- Enable contrast
        --   terminal = true, -- Darker terminal
        --   filetypes = {},  -- Which filetypes get darker? e.g. *.vim, *.cpp, etc.
        -- },
        -- text_contrast = {
        --   lighter = false, -- Higher contrast text for lighter style
        --   darker = false   -- Higher contrast text for darker style
        -- },
        -- disable = {
        --   background = false,  -- true: transparent background
        --   term_colors = false, -- Disable setting the terminal colors
        --   eob_lines = false    -- Make end-of-buffer lines invisible
        -- },
        -- style = {
        --   fix = false,             -- fix=true - disable random loading
        --   disable = {},            -- a list of styles to disable, e.g. {'bold', 'underline'}
        --   darker_contrast = false, -- More contrast for darker style
        --   daylight_swith = true,   -- Enable day and night style switching
        --   deep_black = false,      -- Enable a deeper black background
        -- },
      }
      vim.cmd 'colorscheme limestone'
    end
  },
  
  
  -- { "sainnhe/edge", config = require("plugins.theme") },
  -- { 'ray-x/starry.nvim' },
  
  --{
  --  "catppuccin/nvim",
  --  name = "catppuccin",
  --  priority = 1000,
  --  ---@class CatppuccinOptions
  --  opts = function()
  --    return {
  --      flavour = "mocha",
  --      transparent_background = true,
  --      color_overrides = { all = theme_colors },
  --      custom_highlights = function()
  --        return {
  --          -- CurSearch = { bg = colors.yellow },
  --          -- DiffChanged = { fg = colors.yellow },
  --          -- Diffchanged = { fg = colors.yellow },
  --        }
  --      end,
  --      integrations = {
  --        cmp = true,
  --        fidget = true,
  --        gitsigns = true,
  --        harpoon = true,
  --        lsp_trouble = true,
  --        mason = true,
  --        neotest = true,
  --        noice = true,
  --        notify = true,
  --        octo = true,
  --        telescope = {
  --          enabled = true,
  --        },
  --        treesitter = true,
  --        treesitter_context = false,
  --        symbols_outline = true,
  --        illuminate = true,
  --        which_key = true,
  --        barbecue = {
  --          dim_dirname = true,
  --          bold_basename = true,
  --          dim_context = false,
  --          alt_background = false,
  --        },
  --        native_lsp = {
  --          enabled = true,
  --          virtual_text = {
  --            errors = { "italic" },
  --            hints = { "italic" },
  --            warnings = { "italic" },
  --            information = { "italic" },
  --          },
  --          underlines = {
  --            errors = { "underline" },
  --            hints = { "underline" },
  --            warnings = { "underline" },
  --            information = { "underline" },
  --          },
  --        },
  --      },
  --    }
  --  end,
  --  config = require("plugins.theme")
  --},
  -- { "cacatppuccintppuccin/nvim", name = "catppuccin", priority = 1000, config = require("plugins.theme") },
  -- { "rebelot/kanagawa.nvim", config = require("plugins.theme") },
  -- { 'sheerun/vim-polyglot' },
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {},
  --   config = require("plugins.theme")
  -- },
  { "xiyaowong/nvim-transparent", config = function()
    require("transparent").setup({
      extra_groups = {
        "NeoTreeFileIcon",
        "NeoTreeExpander"
      },
      exclude_grops = {}, -- table: groups you don't want to clear
    })
  end },

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

  { "ThePrimeagen/harpoon" },

  { 'kyazdani42/nvim-web-devicons' },
  { 'ryanoasis/vim-devicons' },
  -- { 'windwp/windline.nvim', config = require('plugins.windline') },
  {
    "nvim-lualine/lualine.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = function(plugin)
      if plugin.override then
        require("lazyvim.util").deprecate("lualine.override", "lualine.opts")
      end

      local icons = require("config.icons")

      local diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn", "info", "hint" },
        symbols = {
          error = icons.diagnostics.Error,
          hint = icons.diagnostics.Hint,
          info = icons.diagnostics.Info,
          warn = icons.diagnostics.Warn,
        },
        colored = true,
        update_in_insert = false,
        always_visible = false,
      }

      local diff = {
        "diff",
        symbols = {
          added = icons.git.added .. " ",
          untracked = icons.git.added .. " ",
          modified = icons.git.changed .. " ",
          removed = icons.git.deleted .. " ",
        },
        colored = true,
        always_visible = false,
        source = function()
          local gitsigns = vim.b.gitsigns_status_dict
          if gitsigns then
            return {
              added = gitsigns.added,
              modified = gitsigns.changed,
              removed = gitsigns.removed,
            }
          end
        end,
      }

      return {
        options = {
          theme = "auto",
          globalstatus = true,
          component_separators = { left = "", right = "" },
          disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { diff, diagnostics },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
      }
    end,
  },
  -- Prettier
  { 'mhartington/formatter.nvim', config = require 'plugins.prettier' },
  -- Lsp
  -- { 'VonHeikemen/lsp-zero.nvim', config = require 'plugins.lsp' },
  { 'neovim/nvim-lspconfig', config = require 'plugins.lsp' },
  {
    'nvimdev/lspsaga.nvim',
    
    config = function()
      require('lspsaga').setup({
        symbols_in_winbar = {
          enable = false
        }
      })
    end,
  },

  -- { 'jose-elias-alvarez/typescript.nvim' },
  { 'onsails/lspkind-nvim', config = require 'plugins.kind' },

  -- Ruby on Rails
  -- { 'vim-test/vim-test', config = require 'plugins.rails-test' },
  { 'tpope/vim-rails' },
  { 'andrewradev/splitjoin.vim' },
  { 'AndrewRadev/switch.vim' },

  -- Fzf
  { 'ibhagwan/fzf-lua', config = require("plugins.fzf")},

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
        "codespell",
        "misspell",
        "cspell",
        "eslint-lsp",
        "js-debug-adapter",
        "prettier",
        "yaml-language-server",
        "lua-language-server",
        "bash-language-server",
        "dockerfile-language-server",
        "docker-compose-language-service"
      }
    },
  },
  
  -- Set up null-ls to check spelling
	{
		"nvimtools/none-ls.nvim",
		keys = {
			{ "<leader>cn", "<cmd>NullLsInfo<cr>", desc = "NullLs Info" },
		},
		dependencies = { "mason.nvim", "davidmh/cspell.nvim" },
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			local cspell = require("cspell")
      local none_ls  = require("null-ls")

			local b = none_ls.builtins

			local sources = {
				-- spell check
				b.diagnostics.codespell,
				b.diagnostics.misspell,
				-- cspell
				cspell.diagnostics.with({
					-- Set the severity to HINT for unknown words
					diagnostics_postprocess = function(diagnostic)
						diagnostic.severity = vim.diagnostic.severity["HINT"]
					end,
				}),
				cspell.code_actions,
			}
			-- Define the debounce value
			local debounce_value = 200
			return {
				sources = sources,
				debounce = debounce_value,
				debug = true,
			}
		end,
	},

  { 'echasnovski/mini.indentscope', 
    config= function()
      require('mini.indentscope').setup({
        symbol = '▏',
      })
    end
  },

  { 'dstein64/vim-startuptime' },

  -- reduce the start up time
  { 'lewis6991/impatient.nvim', config = function()
    require('impatient')
  end
  }
})
