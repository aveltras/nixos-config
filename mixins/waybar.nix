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
	          "on-scroll-down" = "light -U 1";
	          "on-scroll-up" = "light -A 1";
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
	          "on-click" = "alacritty -e nmtui";
          };
          "pulseaudio" = {
    	      "format" = "{icon} {volume}%";
	          "format-bluetooth" = "{icon} {volume}%";
	          "format-muted" = "";
	          "format-icons" = {
	            "default" = [ "" "" ];
	          };
	          "tooltip" = false;
    	      "on-click" = "pavucontrol";
	          "on-scroll-up" = "pactl set-sink-volume $(pactl list short sinks | awk '{ if ($7 == \"RUNNING\") print $1 }') +1%";
	          "on-scroll-down" = "pactl set-sink-volume $(pactl list short sinks | awk '{ if ($7 == \"RUNNING\") print $1 }') -1%";
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
