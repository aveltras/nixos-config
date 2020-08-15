{ pkgs, config, ... }:

{
  home-manager.users.romain = { pkgs, ... }: {
    programs.git = {
      enable = true;
      userEmail = "romain.viallard@outlook.fr";
      userName = "Romain Viallard";
    };
  };
}
