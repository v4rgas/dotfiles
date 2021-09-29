-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "onedarker"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.nvimtree.hide_dotfiles = 0

lvim.builtin.treesitter.ensure_installed = {}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- python
lvim.lang.python.formatters = { { exe = 'autopep8' } }
lvim.lang.python.linters = { { exe = 'flake8' } }

-- additional Plugins
lvim.plugins = {
  {"lervag/vimtex"},
  {
    "iamcco/markdown-preview.nvim",
      ft = "markdown",
      run = ":call mkdp#util#install()",
      event = "BufRead",
  },
}

-- latex plugin config
lvim.builtin.which_key.mappings["t"] = {
    name = "+Latex",
    c = { "<cmd>VimtexCompile<cr>", "Toggle Compilation Mode" },
    f = { "<cmd>call vimtex#fzf#run()<cr>", "Fzf Find" },
    i = { "<cmd>VimtexInfo<cr>", "Project Information" },
    s = { "<cmd>VimtexStop<cr>", "Stop Project Compilation" },
    t = { "<cmd>VimtexTocToggle<cr>", "Toggle Table Of Content" },
    v = { "<cmd>VimtexView<cr>", "View PDF" },
    b = { "<cmd>TexlabBuild<cr>", "Build with Texlab" },
    p = { "<cmd>TexlabForward<cr>", "Preview with Texlab" },
  }

-- compile on initialization, cleanup on quit
  vim.api.nvim_exec(
    [[
        augroup vimtex_event_1
            au!
            au User VimtexEventQuit     call vimtex#compiler#clean(0)
            au User VimtexEventInitPost call vimtex#compiler#compile()
        augroup END
    ]],
    false
  )

