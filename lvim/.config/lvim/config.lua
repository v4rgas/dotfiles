-- general
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "base16-bright"

lvim.log.level = "warn"
lvim.format_on_save = true
lvim.leader = "space"

lvim.builtin.alpha.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

lvim.builtin.treesitter.highlight.enabled = true

lvim.lsp.automatic_servers_installation = false

local opts = {}
require("lvim.lsp.manager").setup("pyright", opts)


local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "rubocop",
    filetypes = { "ruby" },
  },
  {
    command = "prettier",
    filetypes = { "html", "css", "eruby" },
  },
  {
    command = "eslint_d",
    filetypes = { "javascript", "javascriptreact" },
  },
  {
    command = "autopep8",
    filetypes = { "python" },
  },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    command = "rubocop",
    filetypes = { "ruby" },
  },
  {
    command = "eslint",
    filetypes = { "javascript", "javascriptreact" },
  },
}

-- additional Plugins
lvim.plugins = {
  { "RRethy/nvim-base16" },
  { "lervag/vimtex" },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    run = ":call mkdp#util#install()",
    event = "BufRead",
  },
}

-- vim.g.livepreview_previewer = 'zathura'

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
