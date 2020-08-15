{ pkgs, config, username, ... }:

{
  home-manager.users.${username} = { pkgs, ... }: {
    programs.waybar = {
      enable = true;
      style = pkgs.lib.readFile ./waybar.css;
      settings = [{
        layer = "bottom";
        position = "bottom";
        modules-left = [ "sway/workspaces" "sway/mode" ];
        modules-center = [ "sway/window" ];
        modules-right = [ "tray" "network" "backlight" "battery" "pulseaudio" "clock" ];
        modules = {
          "sway/window" = {
            "max-length" = 50;
          };
          "backlight" = {
    	      "device" = "intel_backlight";
    	      "format" = "{icon} {percent}%";
    	      "format-icons" = [ "" "" ];
	          "on-scroll-down" = "${pkgs.light}/bin/light -U 1";
	          "on-scroll-up" = "${pkgs.light}/bin/light -A 1";
          };
          "battery" = {
            "format" = "{icon} {capacity}%";
            "format-icons" = [ "" "" "" "" "" ];
	          "tooltip" = false;
          };
          "clock" = {
            "format" = "{:%a %d. %b  %H:%M}";
	          "tooltip" = false;
          };
          "network" = {
            "interface" = "wlp3s0";
    	      "format" = "{ifname}";
	          "format-wifi" = " {signalStrength}%";
    	      "format-ethernet" = "{ifname} ";
    	      "format-disconnected" = "";
	          "tooltip" = false;
    	      "max-length" = 50;
	          "on-click" = "${pkgs.alacritty}/bin/alacritty -e nmtui";
          };
          "pulseaudio" = {
    	      "format" = "{icon} {volume}%";
	          "format-bluetooth" = "{icon} {volume}%";
	          "format-muted" = "";
	          "format-icons" = {
	            "default" = [ "" "" ];
	          };
	          "tooltip" = false;
    	      "on-click" = "${pkgs.pavucontrol}/bin/pavucontrol";
	          "on-scroll-up" = "${pkgs.pulsemixer}/bin/pulsemixer --change-volume +1";
	          "on-scroll-down" = "${pkgs.pulsemixer}/bin/pulsemixer --change-volume -1";
          };
          "tray" = {
            "icon-size" = 21;
            "spacing" = 10;
          };
        };
      }];
    };
  };
}
