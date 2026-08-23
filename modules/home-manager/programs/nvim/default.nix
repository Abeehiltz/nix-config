{ config, pkgs, inputs, ...}
:
{
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;

    settings = {
      vim.globals.mapleader = " ";
      vim.viAlias = true;
      vim.vimAlias = true;
      vim.lsp = {
        enable = true;
      };

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

      vim.telescope = {
        enable = true;
      };

      vim.statusline.lualine = {
        enable = true;
      };

      vim.filetree.neo-tree = {
        enable = true;
      };

      vim.keymaps = [
        {
          key = "<leader>y";
          mode = [ "n" "v" ];
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
          mode = [ "n" "v" ];
          action = "\"+p";
          desc = "Paste from system clipboard";
        }
      ];
    };
  };
}
