
local M = {}

M.general = {
   n = {
      [";"] = { ";", "Semicolon without entering command mode", noremap = true, silent = true },

      -- Prevent 'x' from copying to clipboard
      ["x"] = { '"_x', "Delete without copying" },

      -- Increment/decrement
      ["+"] = { "<C-a>", "Increment" },
      ["-"] = { "<C-x>", "Decrement" },

      -- Select all
      ["<C-a>"] = { "gg<S-v>G", "Select all" },

      -- Save file and quit
      ["<Leader>w"] = { ":update<CR>", "Save file" },
      ["<Leader>q"] = { ":quit<CR>", "Quit window" },
      ["<Leader>Q"] = { ":qa<CR>", "Quit all" },

      -- File explorer with NvimTree
      ["<Leader>f"] = { ":NvimTreeFindFile<CR>", "Find file in NvimTree" },
      ["<Leader>t"] = { ":NvimTreeToggle<CR>", "Toggle NvimTree" },

      -- Tabs
      ["te"] = { ":tabedit<CR>", "Open new tab" },
      ["<tab>"] = { ":tabnext<CR>", "Next tab" },
      ["<S-tab>"] = { ":tabprev<CR>", "Previous tab" },
      ["tw"] = { ":tabclose<CR>", "Close tab" },

      -- Split windows
      ["ss"] = { ":split<CR>", "Split window horizontally" },
      ["sv"] = { ":vsplit<CR>", "Split window vertically" },

      -- Move between windows
      ["sh"] = { "<C-w>h", "Move to left window" },
      ["sk"] = { "<C-w>k", "Move to upper window" },
      ["sj"] = { "<C-w>j", "Move to lower window" },
      ["sl"] = { "<C-w>l", "Move to right window" },

      -- Resize windows
      ["<C-S-h>"] = { "<C-w><", "Resize window left" },
      ["<C-S-l>"] = { "<C-w>>", "Resize window right" },
      ["<C-S-k>"] = { "<C-w>+", "Resize window up" },
      ["<C-S-j>"] = { "<C-w>-", "Resize window down" },

      -- Diagnostics
      ["<C-j>"] = { function() vim.diagnostic.goto_next() end, "Go to next diagnostic" },
   },
}

M.telescope = {
   n = {
      -- File finding
      ["<Leader>ff"] = {
         function()
            require("telescope.builtin").find_files({
               no_ignore = false,
               hidden = true,
            })
         end,
         "Find files (respects .gitignore)",
      },

      ["<Leader>fg"] = {
         function()
            require("telescope.builtin").live_grep()
         end,
         "Live grep (search in project)",
      },

      -- Buffers and History
      ["<Leader>fb"] = {
         function()
            require("telescope.builtin").buffers()
         end,
         "List open buffers",
      },

      ["<Leader>fr"] = {
         function()
            require("telescope.builtin").resume()
         end,
         "Resume previous Telescope picker",
      },

      -- Diagnostics and Code Navigation
      ["<Leader>fd"] = {
         function()
            require("telescope.builtin").diagnostics()
         end,
         "List diagnostics for all open buffers",
      },

      ["<Leader>fs"] = {
         function()
            require("telescope.builtin").treesitter()
         end,
         "List function names, variables (Treesitter)",
      },

      -- File Browser at Current Buffer Location
      ["<Leader>fe"] = {
         function()
            local telescope = require("telescope")

            local function telescope_buffer_dir()
               return vim.fn.expand("%:p:h")
            end

            telescope.extensions.file_browser.file_browser({
               path = "%:p:h",
               cwd = telescope_buffer_dir(),
               respect_gitignore = false,
               hidden = true,
               grouped = true,
               previewer = false,
               initial_mode = "normal",
               layout_config = { height = 40 },
            })
         end,
         "Open file browser at current buffer’s path",
      },
   },
}
return M

