return function()
local actions = require('telescope.actions')
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local fb_actions = require "telescope".extensions.file_browser.actions

require('telescope').setup {
  defaults = {
    layout_config = {
      width = 0.75,
      prompt_position = "top",
      preview_cutoff = 120,
      horizontal = {mirror = false},
      vertical = {mirror = false}
    },
    find_command = {
      'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'
    },
    prompt_prefix = " ",
    selection_caret = " ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    file_sorter = require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
    path_display = {},
    winblend = 0,
    border = {},
    borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
    color_devicons = true,
    use_less = true,
    set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
    mappings = {
      i = {
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default + actions.center
      },
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist
      }
    },
    extensions = {
      file_browser = {
        theme = "dropdown",
        -- disables netrw and use telescope-file-browser in its place
        hijack_netrw = true,
        mappings = {
          -- your custom insert mode mappings
          ["i"] = {
            ["<C-w>"] = function() vim.cmd('normal vbd') end,
          },
          ["n"] = {
            -- your custom normal mode mappings
            ["N"] = fb_actions.create,
            ["h"] = fb_actions.goto_parent_dir,
            ["/"] = function()
              vim.cmd('startinsert')
            end
          },
        },
      },
    },
  }
}

end

-- local status, telescope = pcall(require, "telescope")
-- if (not status) then return end

-- print('hello')

-- local actions = require('telescope.actions')
-- local builtin = require("telescope.builtin")

-- local function telescope_buffer_dir()
--   return vim.fn.expand('%:p:h')
-- end

-- local fb_actions = require "telescope".extensions.file_browser.actions

-- local function create_new_directory()
--   local path = telescope_buffer_dir()
--   local new_directory_name = vim.fn.input("Enter directory name: ")
--   local new_directory_path = path .. "/" .. new_directory_name
--   vim.fn.mkdir(new_directory_path, "p")
-- end

-- vim.keymap.set("n", "K", function()
--   create_new_directory()
--   builtin.refresh({ cwd = telescope_buffer_dir() })
-- end)

-- telescope.setup {
--   defaults = {
--     mappings = {
--       n = {
--         ["q"] = actions.close
--       },
--     },
--   },
--   extensions = {
--     file_browser = {
--       theme = "dropdown",
--       -- disables netrw and use telescope-file-browser in its place
--       hijack_netrw = true,
--       mappings = {
--         -- your custom insert mode mappings
--         ["i"] = {
--           ["<C-w>"] = function() vim.cmd('normal vbd') end,
--         },
--         ["n"] = {
--           -- your custom normal mode mappings
--           ["N"] = fb_actions.create,
--           ["h"] = fb_actions.goto_parent_dir,
--           ["/"] = function()
--             vim.cmd('startinsert')
--           end
--         },
--       },
--     },
--   },
-- }

-- telescope.load_extension("file_browser")

-- vim.keymap.set('n', ';f',
--   function()
--     builtin.find_files({
--       no_ignore = false,
--       hidden = true
--     })
--   end)
-- vim.keymap.set('n', ';r', function()
--   builtin.live_grep()
-- end)
-- vim.keymap.set('n', '\\\\', function()
--   builtin.buffers()
-- end)
-- vim.keymap.set('n', ';t', function()
--   builtin.help_tags()
-- end)
-- vim.keymap.set('n', ';;', function()
--   builtin.resume()
-- end)
-- vim.keymap.set('n', ';e', function()
--   builtin.diagnostics()
-- end)
-- vim.keymap.set("n", "sf", function()
--   telescope.extensions.file_browser.file_browser({
--     path = "%:p:h",
--     cwd = telescope_buffer_dir(),
--     respect_gitignore = false,
--     hidden = true,
--     grouped = true,
--     previewer = false,
--     initial_mode = "normal",
--     layout_config = { height = 40 }
--   })
-- end)
