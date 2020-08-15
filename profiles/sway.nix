{ pkgs, lib, config, inputs, ... }:

{
  imports =
    [ ./core.nix
      inputs.home.nixosModules.home-manager
      ../mixins/alacritty.nix
    ];
  
  nixpkgs.overlays = [ inputs.wayland.overlay ];

  nix = {
    binaryCaches = [ "https://nixpkgs-wayland.cachix.org" ];
    binaryCachePublicKeys = [ "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA=" ];
  };

  home-manager = {
    useGlobalPkgs = true;
    users.romain = { pkgs, ... }: {
      programs = {
        home-manager.enable = true;
        htop.enable = true;
      };
    };
  };
  
  environment = {
    loginShellInit = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
    	  exec sway
      fi
    '';

    systemPackages = with pkgs; [
      # alacritty
      blender
      chromium
      direnv
      docker-compose
      emacs
      firefox
      gimp
      git
      gnupg
      godot
      gotop
      inkscape
      # insomnia
      # kubectl
      # morph
      nix-direnv
      ntfs3g
      playerctl
      # python3 # treemacs
      slack
      spotify
      steam
      yadm
    ];
  };
  
  programs = {
    light.enable = true;
    sway = {
      enable = true;      
      extraPackages = with pkgs; [
        grim
        slurp
        swaybg
        swaylock
        waybar
        wldash
        xwayland
      ];
      wrapperFeatures.gtk = true;
    };
  };

  fonts = {
    fontconfig.enable = true;
    fonts = with pkgs; [
      fantasque-sans-mono
      font-awesome_5
      iosevka-bin
      jost
    ];
  };
  
  sound.enable = true;
  
  services = {
    redshift = {
      enable = true;
      package = pkgs.redshift-wlr;
    };
  };
}
