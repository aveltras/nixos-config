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
      enable = true;
      package= pkgs.pulseaudioFull;
      extraModules = [ pkgs.pulseaudio-modules-bt ];
    };
  };

  networking = {
    hostName = "clevo-n141zu";
    networkmanager.enable = true;
    nameservers = [ "1.1.1.1" ];
  };

  services = {
    fstrim.enable = true;
  };
}
