{ pkgs, lib, config, username, realname, inputs, ... }:

{
  boot = {
    tmpOnTmpfs = true;
    cleanTmpDir = true;
  };
  
  i18n = {
    defaultLocale = "fr_FR.UTF-8";
    supportedLocales = [ "fr_FR.UTF-8/UTF-8" ];
    inputMethod.enabled = "ibus";
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };

  documentation.nixos.enable = false;

  environment = {
    shellAliases = {
      nr = "sudo nixos-rebuild switch --flake $HOME/nixos-config#$(hostname)"; 
    };
  };
  
  time.timeZone = "Europe/Paris";
  
  location = {
    latitude = 45.75;
    longitude = 4.85;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
    };
  };

  nix = {
    package = pkgs.nixUnstable;
    trustedUsers = [ username ];
    binaryCaches = [
      "https://cache.nixos.org/"
      "https://iohk.cachix.org/"
    ];
    binaryCachePublicKeys = [ "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo=" ];
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  security.sudo.wheelNeedsPassword = false;
  
  users = {
    mutableUsers = false;
    users = {
      root.hashedPassword = "$6$o3cXYMlcT.M.1o6P$3UhleR/595sDmVSei0rx01KBlwF3NjoulvjA1KHZ5KKABns0Bi5c8n35L1LDDUMFfWaGemD/GtFw/y.f.8qMX.";
      ${username} = {
        isNormalUser = true;
        home = "/home/${username}";
        description = realname;
        extraGroups = [ "wheel" "audio" "video" "networkmanager" "docker" ];
        openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEjU6skuH49zxLEg2kMA5Y5meV1xGYZ/q+FuKPqDfZiq" ];
        hashedPassword = "$6$o3cXYMlcT.M.1o6P$3UhleR/595sDmVSei0rx01KBlwF3NjoulvjA1KHZ5KKABns0Bi5c8n35L1LDDUMFfWaGemD/GtFw/y.f.8qMX.";
      };
    };
  };
}
