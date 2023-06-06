{ config, pkgs, ... }:

{
  networking.networkmanager.plugins = [
    pkgs.networkmanager-openconnect
    pkgs.networkmanager-openvpn
  ];
  hardware.opengl.extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  services = {
    earlyoom.enable = true;
    lorri.enable = true;
    xserver.windowManager.i3 = {
      package = pkgs.i3-gaps;
      extraPackages =  with pkgs; [
        rofi
        i3lock-fancy
        scrot
        i3wsr
        polybarFull
        feh
        neofetch
        conky
        picom
        mpv
        xss-lock
        ranger
        kitty
      ];
    };
  };
  users.users.kaguya.packages = with pkgs; [
      ranger
      xdg-user-dirs
      moreutils
      mksh
      ghidra
      mypaint
      rustdesk
      rustup
      sniffnet
      discord
      libvterm
      unrar
      mcfly
      lazygit
      cloc
      poke
      kitty
      nix-index
      kwalletcli
      github-desktop
      harfbuzz
      pipenv
      firefox
      thunderbird
      ripgrep
      fd
      gcc
      cmake
      gnumake
      ninja
      zpaq
      ser2net
      pkg-config
      cozette
      networkmanager_dmenu
      dig
      killall
      python310Packages.python-lsp-server
      pcmanfm
      unzip
      libreoffice
      qemu_full
      polkit_gnome
      rsync
      ethtool
      file
      wine
      winetricks
      sshpass
      qbittorrent
      man-pages
      man-pages-posix
      nodePackages.pyright
      beekeeper-studio
      lldb
      jq
      gdb
      p7zip
      curie
      scientifica
      helix
      lapce
      shellcheck
      ccls
      glxinfo
      vulkan-tools
      cmake-language-server
      ark
      pavucontrol
      clang_14
      llvmPackages_14.llvm
      clang-tools_14
      screen
      tio
      bear
      patchelf
      htop
      steam-run
      vial
      nfs-utils
      mpd
      xorg.xkill
      virtualenv
      black
      ispell
      aspellDicts.ru
      aspellDicts.en
      hunspell
      mypaint
      vivaldi
      hunspellDicts.en_US
      hunspellDicts.en-us
      hunspellDicts.ru_RU
      hunspellDicts.ru-ru
      enchant
      picom
      tree
      msitools
      trunk
      wireshark
      alsa-lib
      networkmanager-openconnect
      networkmanager-openvpn
      rtags
      dos2unix
      gnum4
      blueman
      xorg.xmodmap
      libnotify
      dunst
      difftastic
      qmk
      ntfs3g
      docker
      valgrind
      bottles
      bdep
      graphviz
      protobuf
      barrier
      guile
      bat
      exa
      fzf
      tldr
      zoxide
      duf
      direnv
      virt-manager
    ];
  environment.systemPackages = with pkgs; [
    helix
    kde-cli-tools
    vim # Do not forget to add an editor to edit configuration.nix! The Nano edito ris also installed by default.
    wget
    emacs
    git
    ripgrep
    exa
    bat
    python3
    #nerdfonts
    nushell
    starship
    direnv
    playerctl
    polkit
    fish
    inetutils
    cabextract
    glibc
  ];
 users.defaultUserShell = pkgs.fish;
 programs.starship = {
   enable = false;
 };
  nixpkgs.config.allowUnfree=true;
  fonts.fonts = with pkgs; [
    nerdfonts
    monocraft
    scientifica
    curie
    fira-code
    fira-code-symbols
    dina-font
    proggyfonts

  ];
}
