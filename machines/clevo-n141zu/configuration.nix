{ config, inputs, lib, pkgs, ... }:

{
  imports =
    [ inputs.unstable.nixosModules.notDetected
      ../../profiles/sway.nix
    ];

  system.stateVersion = "20.03";

  fileSystems = {
    "/" = { device = "/dev/disk/by-label/nixos"; fsType = "ext4"; };
    "/boot" = { device = "/dev/disk/by-label/boot"; fsType = "vfat"; };
  };
  
  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
    kernelModules = [ "kvm-intel" ];
    kernelPackages = pkgs.linuxPackages_latest;
    plymouth.enable = true;
    
    kernel.sysctl = {
      "fs.inotify.max_user_watches" = "1048576";
    };
    
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };      
    
  };

  nix.maxJobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  hardware = {
    cpu.intel.updateMicrocode = true;

    bluetooth = {
      enable = true;
      package = pkgs.bluezFull;
      config = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
    
    pulseaudio = {
      package= pkgs.pulseaudioFull;
      extraModules = [ pkgs.pulseaudio-modules-bt ];
    };
  };

  networking.hostName = "clevoN141zu";
  
  services = {
    fstrim.enable = true;
  };
}


  # nixpkgs = {
  #   config = {
  #     allowUnfree = true;
  #     allowBroken = true;
  #   };

  #   overlays = [
  #     (import (fetchTarball https://github.com/colemickens/nixpkgs-wayland/archive/c829193decef17305c5f4cefe99539d8a023e5e7.tar.gz))
  #   ];
  # };

  # nix = {

  #   package = pkgs.nixUnstable;

  #   binaryCaches = [
  #     "https://cache.nixos.org/"
  #     "https://nixcache.reflex-frp.org"
  #     "https://nixpkgs-wayland.cachix.org"
  #     "https://ghcide-nix.cachix.org/"
  #     "https://iohk.cachix.org/"
  #     "https://miso-haskell.cachix.org/"
  #   ];
    
  #   binaryCachePublicKeys = [
  #     "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
  #     "binarycache.local:IcDIAd14oLIf7A0WcKIlHOSf22HoY2MH4T/5+2av0sA="
  #     "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
  #     "ghcide-nix.cachix.org-1:ibAY5FD+XWLzbLr8fxK6n8fL9zZe7jS+gYeyxyWYK5c="
  #     "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
  #     "miso-haskell.cachix.org-1:6N2DooyFlZOHUfJtAx1Q09H0P5XXYzoxxQYiwn6W1e8="
  #   ];

  #   extraOptions = ''
  #     experimental-features = nix-command flakes
  #     keep-outputs = true
  #     keep-derivations = true
  #   '';

  # };
