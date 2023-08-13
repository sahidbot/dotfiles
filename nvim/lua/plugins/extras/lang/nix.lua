return {

  -- add json to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "nix" })
      end
    end,
  },

  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "nil" })
      end,
    },
    opts = {
      -- make sure mason installs the server
      servers = {
        nil_ls = {
          settings = {
            formatting = {
              command = { "nixpkgs-fmt" },
            };
          };
        },
      },
    },
  },

}
