{ pkgs, ... }:
{
  systemd.user.services.rsync-backup-ffxiv = {
    Unit.Description = "Rsync FFXIV folders";
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "rsync-backup-ffxiv" ''
        ${pkgs.rsync}/bin/rsync -a --no-group \
          "$HOME/Documents/FFXIV/" /mnt/storage/backup/ffxiv/ --exclude 'SundouleiaCache' --exclude 'Exported_mods' --exclude 'IINACT' --exclude 'Lightless' --exclude 'PlayerSync'
        ${pkgs.rsync}/bin/rsync -a --no-group \
          "$HOME/Pictures/FFXIV/" /mnt/storage/Images/FFXIV/ --exclude 'old'
      ''}";
    };
  };

  systemd.user.timers.rsync-backup-ffxiv = {
    Unit.Description = "Daily FFXIV folders rsync";
    Timer = {
      OnCalendar = "daily";
      Persistent = true; # run missed jobs after boot
      RandomizedDelaySec = "5m";
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
