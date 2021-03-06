{ pkgs, config, username, ... }:

{
  hardware = {
    opengl = {
      driSupport32Bit = true;
      extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    };
    pulseaudio.support32Bit = true;
  };

  environment.systemPackages = [ pkgs.steam ];
}
