-- general
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "base16-bright"

lvim.log.level = "warn"
lvim.format_on_save = true
lvim.leader = "space"

lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

lvim.lsp.automatic_servers_installation = true

-- lvim.g['neotex_delay'] = 500
-- lvim.builtin.neotex_enabled = 2

-- additional Plugins
lvim.plugins = {
  {'chriskempson/base16-vim'},
  {"lervag/vimtex"},
  -- {'donRaphaco/neotex'},
  -- {'xuhdev/vim-latex-live-preview'},
  {
    "iamcco/markdown-preview.nvim",
      ft = "markdown",
      run = ":call mkdp#util#install()",
      event = "BufRead",
  },
}

-- vim.g.livepreview_previewer = 'zathura'

-- -- latex plugin config
-- lvim.builtin.which_key.mappings["t"] = {
--     name = "+Latex",
--     c = { "<cmd>VimtexCompile<cr>", "Toggle Compilation Mode" },
--     f = { "<cmd>call vimtex#fzf#run()<cr>", "Fzf Find" },
--     i = { "<cmd>VimtexInfo<cr>", "Project Information" },
--     s = { "<cmd>VimtexStop<cr>", "Stop Project Compilation" },
--     t = { "<cmd>VimtexTocToggle<cr>", "Toggle Table Of Content" },
--     v = { "<cmd>VimtexView<cr>", "View PDF" },
--     b = { "<cmd>TexlabBuild<cr>", "Build with Texlab" },
--     p = { "<cmd>TexlabForward<cr>", "Preview with Texlab" },
--   }

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

