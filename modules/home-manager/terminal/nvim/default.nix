{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nvf.homeModules.default
  ];

  programs.nvf = {
    enable = true;

    settings = {
      vim.globals.mapleader = " ";
      vim.viAlias = true;
      vim.vimAlias = true;
      vim.lsp = {
        enable = true;
        trouble.enable = true;
        lightbulb.enable = true;
        formatOnSave = true;
      };

      vim.options = {
        cursorline = true;
      };

      #      vim.startPlugins = [ pkgs.vimPlugins.base16-nvim ];

      vim.extraPackages = [
        pkgs.yamllint
      ];

      vim.clipboard = {
        enable = true;
        providers.wl-copy.enable = true;
      };

      vim.languages = {
        nix.enable = true;
        python.enable = true;
        markdown.enable = true;
        helm.enable = true;
        yaml.enable = true;
      };

      vim.diagnostics.nvim-lint = {
        enable = true;
        linters_by_ft = {
          yaml = ["yamllint"];
        };
        lint_after_save = true;
      };

      vim.telescope = {
        enable = true;
      };

      vim.statusline.lualine = {
        enable = true;
      };

      vim.utility.oil-nvim = {
        enable = true;
        gitStatus.enable = true;
        setupOpts = {
          default_file_explorer = true;
          view_options.show_hidden = true;
        };
      };

      vim.autocomplete.blink-cmp = {
        enable = true;
        setupOpts.signature.enabled = true;
      };
      vim.extraPlugins = {
        tiny-inline-diagnostic = {
          package = pkgs.vimPlugins.tiny-inline-diagnostic-nvim;
          setup = ''
            require("tiny-inline-diagnostic").setup({
              preset = "simple",
              transparent_cursorline = true;
            })
          '';
        };
      };

      vim.diagnostics.config.virtual_text = false; # Disable Neovim's default virtaul text as as recommended by tiny-inline-diagnostic

      vim.binds.whichKey.enable = true;
      vim.keymaps = [
        {
          key = "<leader>y";
          mode = [
            "n"
            "v"
          ];
          action = "\"+y";
          desc = "Yank to system (Wayland) clipboard";
        }
        {
          key = "<leader>Y";
          mode = "n";
          action = "\"+Y";
          desc = "Yank line to system clipboard";
        }
        {
          key = "<leader>p";
          mode = [
            "n"
            "v"
          ];
          action = "\"+p";
          desc = "Paste from system clipboard";
        }
        {
          key = "-";
          mode = "n";
          action = "<CMD>Oil<CR>";
          desc = "Open parent directory in Oil";
        }
        {
          key = "<leader>-";
          mode = "n";
          action = "<CMD>Oil --float<CR>";
          desc = "Open parent directory in Oil (floating)";
        }
      ];
    };
  };
}
