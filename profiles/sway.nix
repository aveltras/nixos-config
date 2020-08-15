{ pkgs, lib, config, inputs, ... }:

{
  imports =
    [ ./core.nix
    ];
  
  nixpkgs.overlays = [ inputs.wayland.overlay ];

  nix = {
    binaryCaches = [ "https://nixpkgs-wayland.cachix.org" ];
    binaryCachePublicKeys = [ "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA=" ];
  };
  
  environment = {
    loginShellInit = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
    	  exec sway
      fi
    '';
  };
  
  programs = {
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

  services = {
    redshift = {
      enable = true;
      package = pkgs.redshift-wlr;
    };
  };
}
