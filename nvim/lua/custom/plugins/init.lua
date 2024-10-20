return {
  {
    'mfussenegger/nvim-jdtls',
    dependencies = { 'mfussenegger/nvim-dap' },
    ft = { 'java' },
  },
  {
    'mfussenegger/nvim-dap-python',
    dependencies = { 'mfussenegger/nvim-dap', 'williamboman/mason.nvim' },
    config = function()
      require('dap-python').setup ' /Users/mchurch/.pyenv/versions/3.10.12/bin/python3'
      vim.keymap.set('n', '<leader>tr', require('dap-python').test_method)
      vim.keymap.set('n', '<leader>tc', require('dap-python').test_class)
    end,
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    config = function()
      require('harpoon'):setup()
    end,
    dependencies = { 'nvim-lua/plenary.nvim' },
    -- stylua: ignore
     keys = {
      { "<leader>A", function() require("harpoon"):list():add() end, desc = "harpoon file", },
      { "<leader>a", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "harpoon quick menu", },
      { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "harpoon to file 1", },
      { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "harpoon to file 2", },
      { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "harpoon to file 3", },
      { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "harpoon to file 4", },
      { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "harpoon to file 5", },
    },
  },
  {
    'tpope/vim-fugitive',
    lazy = false,
    keys = {
      { '<leader>gb', '<cmd>Git blame<CR>', desc = 'Git Blame' },
    },
    {
      'stevearc/oil.nvim',
      lazy = false,
      opts = {
        default_file_explorer = true,
      },
      -- Optional dependencies
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      keys = {
        { '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' } },
      },
    },
  },
  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('refactoring').setup()
    end,
		 -- stylua: ignore
		keys = {
			{ "<leader>cxf", function() require('refactoring').refactor('Extract Function')  end, mode = "x", desc = "[e]xtract Function", },
			{ "<leader>cxF", function() require('refactoring').refactor('Extract Function To File')  end, mode="x", desc = "extract function to [f]ile", },
			{ "<leader>cv", function() require('refactoring').refactor('Extract Variable')  end, mode="x", desc = "extract [v]ariable", },
			{"<leader>cI", function() require('refactoring').refactor('Inline Function')  end, desc = "[I]nline function", },
			{"<leader>ci", function() require('refactoring').refactor('Inline Variable')  end, desc = "[i]nline variable", },
			{"<leader>cb", function() require('refactoring').refactor('Extract Block')  end, desc = "extract [b]lock", },
			{ "<leader>cbf", function() require('refactoring').refactor('Extract Block To File')  end, desc = "[b]lock to [f]ile", },
		}
,
  },
  {
    'alexghergh/nvim-tmux-navigation',
    config = function()
      local nvim_tmux_nav = require 'nvim-tmux-navigation'

      nvim_tmux_nav.setup {
        disable_when_zoomed = true, -- defaults to false
      }

      vim.keymap.set('n', '<C-h>', nvim_tmux_nav.NvimTmuxNavigateLeft)
      vim.keymap.set('n', '<C-j>', nvim_tmux_nav.NvimTmuxNavigateDown)
      vim.keymap.set('n', '<C-k>', nvim_tmux_nav.NvimTmuxNavigateUp)
      vim.keymap.set('n', '<C-l>', nvim_tmux_nav.NvimTmuxNavigateRight)
      vim.keymap.set('n', '<C-\\>', nvim_tmux_nav.NvimTmuxNavigateLastActive)
      vim.keymap.set('n', '<C-Space>', nvim_tmux_nav.NvimTmuxNavigateNext)
    end,
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
}
