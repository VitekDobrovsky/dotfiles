return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      ---@type table<string, any>
      servers = {
        -- Your existing global keymap overrides
        ["*"] = {
          keys = {
            { "K", false },
            { "<C-,>", vim.lsp.buf.hover, desc = "Hover" },
          },
        },

        basedpyright = {
          -- use the uv-managed .venv in the project root, if present
          before_init = function(_, config)
            local venv = config.root_dir and (config.root_dir .. "/.venv/bin/python")
            if venv and vim.uv.fs_stat(venv) then
              config.settings.python = vim.tbl_deep_extend("force", config.settings.python or {}, { pythonPath = venv })
            end
          end,
          settings = {
            basedpyright = {
              analysis = { typeCheckingMode = "standard" },
            },
          },
        },

        -- ruff formats Python; wider lines unless the project has its own ruff config
        ruff = {
          init_options = {
            settings = {
              lineLength = 120,
              configurationPreference = "filesystemFirst",
            },
          },
        },

        -- emmet_ls = {
        --   filetypes = { 
        --     "html", 
        --     "typescriptreact", 
        --     "javascriptreact", 
        --     "css", 
        --     "sass", 
        --     "scss", 
        --     "less", 
        --     "eruby" 
        --   },
        -- },
      },
    },
  },
}
