{ pkgs, config, username, realname, email, ... }:

{
  home-manager.users.${username} = { pkgs, ... }: {
    programs.git = {
      enable = true;
      userEmail = email;
      userName = realname;
    };
  };
}
