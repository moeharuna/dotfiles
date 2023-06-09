# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ 
      /etc/nixos/hardware-configuration.nix #hardware is always machine specific
      ./home.nix
      ./packages.nix
    ];

  services.tailscale.enable = true;
  services.logind.lidSwitch = "ignore";
  services.emacs.package = pkgs.emacsUnstable;
   nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
  ];
  nixpkgs.config.permittedInsecurePackages = [
      "openssl-1.1.1t"
      "openssl-1.1.1u"
  ];
  programs.fish.enable = true;
  programs.bash.undistractMe.enable = true;
  programs.ssh.askPassword = "kwalletaskpass";
  programs.nix-ld.enable = true;
  environment.variables = {
    PATH = "/home/kaguya/.cargo/bin";
    EDITOR = "hx";
  };
  virtualisation.docker.enable = true;
  boot.readOnlyNixStore = true;
  users.users.root = {
    password = "root";
  };
  users.motd = "Welcome to offical kaguya laptop. Please dont break or steal anything.";
  users.mutableUsers = false;
  users.users.kaguya = {
    uid = 1000;
    isNormalUser = true;
    hashedPassword = "$y$j9T$45y8VVaGUpAgTw5w/Csq1/$8x1iIpuiOzqGqV23t8t8jQrfErlrWdKLaHwiDkhodW3";
    extraGroups = [ "wheel" "libvirtd"  "docker" ]; # Enable ‘sudo’ for the user.
  };
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  networking.hostName = "kaguya";


  security.pam.loginLimits = [
      {domain = "*";type = "-";item = "memlock";value = "infinity";}
      {domain = "*";type = "-";item = "nofile";value = "32768";}
  ];


  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  services.udev.extraRules = "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", MODE=\"0666\", TAG+=\"uaccess\", TAG+=\"udev-acl\"";
  # Pick only one of the below networking options.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  systemd.services.NetworkManager-wait-online.enable = false; 
  time.timeZone = "Europe/Moscow";
  zramSwap.enable = true;  


  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
  powerManagement.enable = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
   console = {
     #font = "Monocraft";
     keyMap = "us";
     #useXkbConfig = true; # use xkbOptions in tty.
   };
  i18n.supportedLocales = ["all"];


  # Enable the X11 windowing system.
  services.xserver.enable = true;




  services.xserver = {
    enableCtrlAltBackspace = true;
    displayManager = {
      sddm.enable = true;
      sddm.autoNumlock = true;
      sddm.theme  = "elarun";
      defaultSession = "none+i3";
    };

    windowManager.i3.enable = true;

  layout = "us,ru";
  xkbOptions = "terminate:ctrl_alt_bksp,grp:toggle,caps:hyper,lv3:caps";
  };
  nix.settings.auto-optimise-store = true;

  services.vsftpd =  {
    enable = true;
    anonymousUserNoPassword = true;
    anonymousUser = true;
    anonymousUploadEnable = true;
    extraConfig = "ftpd_banner=Hello";
  };

  services.printing.enable = true;
  documentation.dev.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;


  boot.extraModprobeConfig = "options kvm_intel nested=1";
  systemd.enableEmergencyMode = false;

  services.xserver.libinput.enable = true;

  security.polkit.enable = true;
  services.xserver.updateDbusEnvironment = true;

  services.logind.extraConfig = "IdleActionSec=30min";



  nix = {
   package = pkgs.nixFlakes;
   extraOptions =  "experimental-features = nix-command flakes";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
     enable = true;
  #   enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";
  programs.ssh.startAgent = true;
  programs.ssh.enableAskPassword = true;
  security.pam.enableSSHAgentAuth = true;

  services.syslog-ng.enable = true;
  services.journald.forwardToSyslog = true;
  # open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 5901 1217 ];
  networking.firewall.allowedUDPPorts = [ 5901 1217 ];

  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}

