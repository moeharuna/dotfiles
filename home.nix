{ config, pkgs, ... }:
let
    home-manager = builtins.fetchTarball {
        url = "https://github.com/nix-community/home-manager/archive/master.tar.gz";
    };
in
{
    imports = [
        (import "${home-manager}/nixos")
    ];


    home-manager.users.kaguya = {

    nixpkgs.overlays = [
    (self: super: {
      fcitx-engines = pkgs.fcitx5;
    })
  ];
    home.file = {
        ".config/i3"            = {
            source = ./src/i3;
            recursive = true;
        };
        ".config/rofi"            = {
            source = ./src/rofi;
            recursive = true;
        };
        ".config/helix"            = {
            source = ./src/helix;
            recursive = true;
        };
        ".config/kitty"            = {
            source = ./src/kitty;
            recursive = true;
        };
        ".wallpaper"            = {
            source = ./src/wallpaper;
            recursive = true;
        };
        ".config/polybar"            = {
            source = ./src/polybar;
            recursive = true;
        };
        ".mozilla/firefox/kaguya"            = {
            source = ./src/firefox_config/chrome;
            recursive = true;
        };
        ".config/starship.toml".source   = ./src/starship.toml;
        ".config/picom.conf".source = ./src/picom.conf;
    };
        # This should be the same value as `system.stateVersion` in
        # your `configuration.nix` file.
        home.stateVersion = "22.05";
    };
}

