{
  lib,
  pkgs,
  ...
}:
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableTransience = true;

    settings = {
      add_newline = true;
      continuation_prompt = "[▸▹ ](dimmed white)";
      command_timeout = 1300;
      scan_timeout = 50;

      format = ''$username$hostname $directory $fill $kubernetes $helm $vcsh $git_branch$git_commit$git_state$git_status $docker_context$package$c$cpp$cmake$golang$guix_shell$java$lua$nodejs$perl$php$purescript$python$terraform$memory_usage$custom$os$battery$time$status 
$character'';

      character = {
        success_symbol = "[❯](bold green) ";
        vimcmd_symbol  = "[❮](bold blue) ";
        error_symbol   = "[✗](bold red) ";
      };

      cmd_duration = {
        format = " [$duration]($style)";
      };
  
      directory = {
        truncation_length = 8;
        truncate_to_repo = false; 
      };

      username = {
        format = "\\[[$user]($style)";
        show_always = false;
      };

      hostname = {
        ssh_symbol = "@";
        format = "[$ssh_symbol$hostname]($style)\\] ";
        ssh_only = true;
      };

      fill = {
        symbol = "---";
        style = "bold grey";
      };

      time = {
        format = "  [$time]($style) ";
        time_format = "%F %H:%M:%S";
        disabled = false; 
      };

      status = {
        disabled = false;
        success_symbol = "";
        success_style = "bold green";
        format = "[$symbol]($style) ";
      };
    };
  };
}
