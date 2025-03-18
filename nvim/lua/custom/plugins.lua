local plugins = {
 -- Treesitter for Syntax Highlighting
   {
      "echasnovski/mini.hipatterns",
      event = "BufReadPre",
      opts = {},
   },
   {
      "nvim-telescope/telescope.nvim",
      priority = 1000,
      dependencies = {
         {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
         },
         "nvim-telescope/telescope-file-browser.nvim",
      },
      keys = {
         {
            ";f",
            function()
               require("telescope.builtin").find_files({
                  no_ignore = false,
                  hidden = true,
               })
            end,
            desc = "Lists files in your current working directory, respects .gitignore",
         },
         {
            ";r",
            function()
               require("telescope.builtin").live_grep()
            end,
            desc = "Search for a string in your current working directory",
         },
         {
            "\\\\",
            function()
               require("telescope.builtin").buffers()
            end,
            desc = "Lists open buffers",
         },
         {
            ";;",
            function()
               require("telescope.builtin").resume()
            end,
            desc = "Resume previous telescope picker",
         },
         {
            ";e",
            function()
               require("telescope.builtin").diagnostics()
            end,
            desc = "Lists Diagnostics for all open buffers",
         },
         {
            ";s",
            function()
               require("telescope.builtin").treesitter()
            end,
            desc = "Lists function names, variables using Treesitter",
         },
         {
            "sf",
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
            desc = "Open File Browser at current buffer's path",
         },
      },
      config = function(_, opts)
         local telescope = require("telescope")
         local actions = require("telescope.actions")
         local fb_actions = require("telescope").extensions.file_browser.actions

         opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
            wrap_results = true,
            layout_strategy = "horizontal",
            layout_config = { prompt_position = "top" },
            sorting_strategy = "ascending",
            winblend = 0,
            mappings = {
               n = {},
            },
         })

         opts.pickers = {
            diagnostics = {
               theme = "ivy",
               initial_mode = "normal",
               layout_config = {
                  preview_cutoff = 9999,
               },
            },
         }

         opts.extensions = {
            file_browser = {
               theme = "dropdown",
               hijack_netrw = true,
               mappings = {
                  ["n"] = {
                     ["N"] = fb_actions.create,
                     ["h"] = fb_actions.goto_parent_dir,
                     ["<C-u>"] = function(prompt_bufnr)
                        for i = 1, 10 do
                           actions.move_selection_previous(prompt_bufnr)
                        end
                     end,
                     ["<C-d>"] = function(prompt_bufnr)
                        for i = 1, 10 do
                           actions.move_selection_next(prompt_bufnr)
                        end
                     end,
                  },
               },
            },
         }

         telescope.setup(opts)
         require("telescope").load_extension("fzf")
         require("telescope").load_extension("file_browser")
      end,
   },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "tsx", "javascript", "typescript", "html", "css", "json" },
        highlight = { enable = true },
      }
    end,
  },

  -- LSP (Language Server Protocol) Support
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local nvlsp = require("nvchad.configs.lspconfig")

      -- LSP servers for Next.js
      local servers = { "tsserver", "html", "cssls", "jsonls", "tailwindcss", "eslint" }

      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          on_attach = nvlsp.on_attach,
          on_init = nvlsp.on_init,
          capabilities = nvlsp.capabilities,
        }
      end
    end,
  },

  -- Auto-completion (nvim-cmp)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },

  -- Tailwind CSS IntelliSense
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
}

return plugins
