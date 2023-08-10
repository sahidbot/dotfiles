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

require("config").init()

require("lazy").setup({
  spec = {
    { import = "plugins" },
    { import = "plugins.extras.dap.core" },
    { import = "plugins.extras.lang.docker" },
    { import = "plugins.extras.lang.json" },
    { import = "plugins.extras.lang.lua" },
    { import = "plugins.extras.lang.typescript" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  checker = { enabled = false }, -- automatically check for plugin updates
  performance = {
    -- set to 'false' to use tree-sitter installed by home-manager
    -- reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      -- reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory

      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

require("config").setup({
  -- treesitter parsers
  ensure_installed = {
    "bash",
    "c",
    "html",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "regex",
    "vim",
    "vimdoc",
    "yaml",
  },
})
