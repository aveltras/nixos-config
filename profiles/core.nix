{ pkgs, lib, config, inputs, ... }:

{
  i18n = {
    defaultLocale = "fr_FR.UTF-8";
    supportedLocales = [ "fr_FR.UTF-8/UTF-8" ];
    inputMethod.enabled = "ibus";
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };

  time.timeZone = "Europe/Paris";
  
  location = {
    latitude = 45.75;
    longitude = 4.85;
  };
  
  nix.trustedUsers = [ "romain" ];
  
  users.users.romain = {
    isNormalUser = true;
    home = "/home/romain";
    description = "Romain Viallard";
    extraGroups = [ "wheel" "audio" "video" "networkmanager" ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEjU6skuH49zxLEg2kMA5Y5meV1xGYZ/q+FuKPqDfZiq" ];
    hashedPassword = "$6$o3cXYMlcT.M.1o6P$3UhleR/595sDmVSei0rx01KBlwF3NjoulvjA1KHZ5KKABns0Bi5c8n35L1LDDUMFfWaGemD/GtFw/y.f.8qMX.";
  };
}
