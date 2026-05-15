-- ============================================================
-- Options
-- ============================================================
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.tabstop        = 2
vim.opt.shiftwidth     = 2
vim.opt.expandtab      = true
vim.opt.smartindent    = true
vim.opt.wrap           = false
vim.opt.termguicolors  = true
vim.opt.signcolumn     = "yes"
vim.opt.updatetime     = 250
vim.opt.clipboard      = "unnamedplus"
vim.opt.scrolloff      = 8

-- ============================================================
-- Leader (must be before any mappings or plugin setup)
-- ============================================================
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- ============================================================
-- Keymaps
-- ============================================================
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<cr>",  { desc = "Quit" })
vim.keymap.set("n", "<Esc>",     "<cmd>nohlsearch<cr>")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- ============================================================
-- Bootstrap lazy.nvim
-- ============================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================
-- Plugins
-- ============================================================
require("lazy").setup({

  {
    "catppuccin/nvim",
    name     = "catppuccin",
    priority = 1000,
    config   = function()
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },

  -- Treesitter: proper syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- v1.0 API: highlight and indent are on by default
      require("nvim-treesitter").setup({
        ensure_installed = {
          "lua", "python", "javascript", "typescript",
          "tsx", "cpp", "c", "swift",
        },
      })
    end,
  },
  -- Telescope: fuzzy finder
  -- Cmd+P equivalent for files, live grep, and more
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      local builtin   = require("telescope.builtin")

      telescope.setup({
        defaults = {
          layout_strategy = "horizontal",
          sorting_strategy = "ascending",
          layout_config = { prompt_position = "top" },
        },
      })

      -- Keymaps — space is your leader key
      vim.keymap.set("n", "<leader>ff", builtin.find_files,  { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep,   { desc = "Search text in project" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers,     { desc = "Find open buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags,   { desc = "Search help" })
    end,
  },

}, {
  ui = { border = "rounded" },
})
