{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "abee";
  home.homeDirectory = "/home/abee";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.
 
  # Zsh setup
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;


    shellAliases = {
      # eza aliases
      ls   = "eza --icons=always";
      ll   = "eza -lg --icons=always"; 
      lls  = "eza -lg -s newest --icons=always";
      la   = "eza -lag --icons=always";
      las  = "eza -lag -s newest --icons=always";
      lt   = "eza -lTg --icons=always";
      lt2  = "eza -lTg --level=2 --icons=always";
      lt3  = "eza -lTg --level=3 --icons=always";
      lt4  = "eza -lTg --level=4 --icons=always";
      lta2 = "eza -lTag --level=2 --icons=always";
      lta3 = "eza -lTag --level=3 --icons=always";
      lta4 = "eza -lTag --level=4 --icons=always";

      # git
      lg = "lazygit";
    };

    history = {
      append = true;
      size = 10000;
    };
    
  };

  # Oh my posh config for zsh
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
  settings = {
    "$schema" = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json";
    transient_prompt = {
      background = "transparent";
      foreground = "#ffffff";
      template = "➜ ";
    };
    blocks = [
      {
        alignment = "left";
        segments = [
          {
            foreground = "cyan";
            style = "powerline";
            template = "{{ if .WSL }}WSL at {{ end }}{{.Icon}}";
            type = "os";
          }
          {
            foreground = "cyan";
            properties = {
              style = "full";
            };
            style = "plain";
            template = " {{ .Path }} ";
            type = "path";
          }
          {
            foreground = "#F1502F";
            properties = {
              fetch_status = true;
            };
            style = "plain";
            template = ":: {{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Staging.Changed }} \\uf046 {{ .Staging.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Working.Changed }} \\uf044 {{ .Working.String }}{{ end }} ";
            type = "git";
          }
        ];
        type = "prompt";
      }
      {
        alignment = "right";
        segments = [
          {
            foreground = "red";
            style = "plain";
            template = "| root ";
            type = "root";
          }
          {
            foreground = "#06A4CE";
            style = "powerline";
            template = "| \\ue798 {{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }} ";
            type = "dart";
          }
          {
            foreground = "#6CA35E";
            style = "powerline";
            template = "| \\ue718 {{ if .PackageManagerIcon }}{{ .PackageManagerIcon }} {{ end }}{{ .Full }} ";
            type = "node";
          }
          {
            foreground = "#4584b6";
            properties = {
              display_mode = "context";
              fetch_virtual_env = true;
            };
            style = "plain";
            template = "| \\ue235 {{ .Venv }} ";
            type = "python";
          }
          {
            foreground = "lightGreen";
            style = "plain";
            template = "| {{ .CurrentDate | date .Format }} ";
            type = "time";
          }
        ];
        type = "prompt";
      }
      {
        alignment = "left";
        newline = true;
        segments = [
          {
            foreground = "lightGreen";
            foreground_templates = [
              "{{ if gt .Code 0 }}red{{ end }}"
            ];
            properties = {
              always_enabled = true;
            };
            style = "powerline";
            template = "➜ ";
            type = "status";
          }
        ];
        type = "prompt";
      }
    ];
    version = 3;
  };
};

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    vim
    eza    # Modern ls 
    fd     # Find alternative
    zoxide # Better cd

    lazygit
    fastfetch

    jq

    # Kubernetes
    talosctl
    kompose
    kubectl
    kubernetes-helm

    # Fonts
    fira-code
    fira-code-symbols
    nerd-fonts.fira-code
  ];

  # enable the configuration of fonts
  fonts.fontconfig.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/abee/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.git = {
    enable = true;
    userName = "Abeehiltz";
    userEmail = "36138393+Abeehiltz@users.noreply.github.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
