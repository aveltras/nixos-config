{ pkgs, lib, config, username, inputs, ... }:

{
  imports =
    [ ./core.nix
      inputs.home.nixosModules.home-manager
      ../mixins/alacritty.nix
      ../mixins/git.nix
      ../mixins/sway.nix
      ../mixins/waybar.nix
    ];
  
  nixpkgs.overlays = [ inputs.wayland.overlay ];

  nix = {
    binaryCaches = [ "https://nixpkgs-wayland.cachix.org" ];
    binaryCachePublicKeys = [ "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA=" ];
  };

  home-manager = {
    useGlobalPkgs = true;
    users.${username} = { pkgs, ... }: {
      programs = {
        home-manager.enable = true;
        emacs.enable = true;
        bash.enable = true;
        direnv = {
          enable = true;
          enableBashIntegration = true;
          enableNixDirenvIntegration = true;
        };
      };

      home.file = {
        ".emacs.d/init.el".source = ./../dotfiles/.emacs.d/init.el;
      };

      xdg.configFile."wldash/config.yaml".source = ./../dotfiles/wldash/config.yaml;
    };
  };
  
  environment = {
    loginShellInit = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
    	  exec sway
      fi
    '';

    systemPackages = with pkgs; [
      ardour
      blender
      chromium
      discord
      docker-compose
      firefox
      gimp
      gnupg
      godot
      gotop
      inkscape
      krita
      lmms
      # morph
      musescore
      ntfs3g
      slack
      spotify
      steam-run
    ];
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
  
  services.redshift.enable = true;

  users.users.${username}.extraGroups = [ "docker" ];
  virtualisation.docker.enable = true;
  virtualisation.docker.liveRestore = false;
}
