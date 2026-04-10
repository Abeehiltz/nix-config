{ config, pkgs, inputs, ...}
:
{
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;

    settings = {
      vim.viAlias = true;
      vim.vimAlias = true;
      vim.lsp = {
        enable = true;
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
    };
  };
}
