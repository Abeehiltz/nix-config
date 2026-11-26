# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  username,
  ...
}:
{
  imports = [ ./base.nix ];
  # Boot config
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    #    kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_7_1.override {
    #    argsOverride = rec {
    #      src = pkgs.fetchurl {
    #            url = "mirror://kernel/linux/kernel/v7.x/linux-${version}.tar.xz";
    #            sha256 = "sha256-IqAZazy83zTcJ7d1YfTQQFhf00R+3JqzUxoax54wQec=";
    #      };
    #      version = "7.1.5";
    #      modDirVersion = "7.1.5";
    #      };
    #  });

    kernel.sysctl = {
      "fs.inotify.max_user_watches" = "1048576";
    };

    loader.systemd-boot.enable = false;
    loader.efi.canTouchEfiVariables = true;
    loader.grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
  };

  # For x11
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.graphics.enable = true;

  # Networking
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [
    2234 # Soulseek
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.groups.plugdev = {
    members = [ "${username}" ];
  };

  environment.systemPackages = with pkgs; [
    # For customizing keyboard
    sops
    age
    ssh-to-age
    via
    qmk
    qmk-udev-rules

    # for iPhone
    libimobiledevice

    # configure python
    (python3.withPackages (
      python-pkgs: with python-pkgs; [
      ]
    ))
  ];

  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      fira-code
      fira-code-symbols
      nerd-fonts.fira-code
      # For electron apps
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "Noto Sans" ];
        serif = [ "Noto Serif" ];
        monospace = [ "DejaVu Sans Mono" ];
      };
    };
  };

  # For strata file explorer to manage network shares and disk management
  services.udisks2.enable = true;
  services.gvfs.enable = true;

  services.udev.packages = [
    pkgs.via
    pkgs.qmk-udev-rules
  ];

  # Enable xwayland
  programs.xwayland.enable = true;

  qt.enable = true;

  # Enable PipeWire for sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true; # Deprecated - use pw-jack wrapper instead
  };

  # Logitech mouse configuration
  hardware.logitech.wireless.enable = true;

  # For iPhone
  services.usbmuxd.enable = true;

  # To be able to run normal binaries not packaged in nixpkgs
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    icu
    libx11
    libice
    libsm
    libxi
    libxcursor
    libxrandr
    libxext
    fontconfig
    libGL
  ];

  systemd.tmpfiles.rules = [
    "L+ /usr/share/fonts - - - - /home/abee/.nix-profile/share/fonts"
  ];
}
