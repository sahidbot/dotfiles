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

require("lazy").setup({
  spec = {
    -- { import = "nyxvim.plugins" },
    -- { import = "nyxvim.plugins.extras.lang.json" },
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
