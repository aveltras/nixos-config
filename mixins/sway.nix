{ pkgs, config, username, ... }:

{
  programs.sway = {
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
  };

  services.redshift.package = pkgs.redshift-wlr;
  
  home-manager.users.${username} = { pkgs, ... }: {
         
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;

      extraConfig = ''
        seat * hide_cursor 5000
      '';

      config = rec {
        modifier = "Mod4";
        terminal = "${pkgs.alacritty}/bin/alacritty";
        window = {
          border = 0;
          hideEdgeBorders = "both";
        };
        
        input = {
          "*" = {
            tap = "enable";
            dwt = "enable";
            events = "disabled_on_external_mouse";
            xkb_layout = "fr";
            xkb_options = "ctrl:nocaps";
          };
        };
        
        output = {
          "*".bg = "~/.background-image fill";
          "DP-1".resolution = "1920x1080 position 0,0";
          "DP-2".resolution = "1920x1080 position 1920,0";
          "eDP-1".resolution = "1920x1080 position 0,0";
          "HDMI-A-2".resolution = "1920x1080 position 1920,0";
        };

        bars = [{
          command = "${pkgs.waybar}/bin/waybar";
        }];

        assigns = {
          "1" = [{ class="^Firefox$"; }];
          "2" = [{ class="^Emacs$"; }];
          "3" = [{ app_id="Alacritty"; }];
        };

        keybindings = {

          # Fn Keys
          "XF86AudioRaiseVolume" = ''exec --no-startup-id pactl set-sink-volume $(pactl list short sinks | awk '{ if ($7 == "RUNNING") print $1 }') +1%'';
          "XF86AudioLowerVolume" = ''exec --no-startup-id pactl set-sink-volume $(pactl list short sinks | awk '{ if ($7 == "RUNNING") print $1 }') -1%'';
          "XF86AudioMute" = ''exec --no-startup-id pactl set-sink-mute $(pactl list short sinks | awk '{ if ($7 == "RUNNING") print $1 }') toggle'';
          "XF86MonBrightnessDown" = ''exec --no-startup-id light -U 1'';
          "XF86MonBrightnessUp" = ''exec --no-startup-id light -A 1'';
          "XF86AudioPlay" = ''exec playerctl play-pause'';
          "${modifier}+Shift+Tab" = ''exec playerctl previous'';
          "${modifier}+Tab" = ''exec playerctl next'';

          # General
          "${modifier}+Return" = "exec ${terminal}";
          "${modifier}+Shift+q" = "kill";
          "${modifier}+d" = "exec wldash";
          "${modifier}+Shift+c" = "reload";
          "${modifier}+Shift+e" = ''exec swaynag -t warning -m 'Do you really want to exit sway?' -b 'Yes, exit sway' 'swaymsg exit' '';
          "${modifier}+l" = ''exec swaylock -f -i ~/.background-image'';

          # Screenshots
          "print" = "exec mkdir -p ~/Screenshots && grim ~/Screenshots/$(date +'%Y-%m-%d-%H%M%S_grim.png')"; # Fullscreen
          "${modifier}+print" = ''exec mkdir -p ~/Screenshots && grim -g "$(slurp)" ~/Screenshots/$(date +'%Y-%m-%d-%H%M%S_grim.png')''; # Region

          # Move focus
          "${modifier}+Left" = "focus left";
          "${modifier}+Down" = "focus down";
          "${modifier}+Up" = "focus up";
          "${modifier}+Right" = "focus right";
          
          # Move focused window
          "${modifier}+Shift+Left" = "move left";
          "${modifier}+Shift+Down" = "move down";
          "${modifier}+Shift+Up" = "move up";
          "${modifier}+Shift+Right" = "move right";

          # Switch to workspace
          "${modifier}+ampersand" = "workspace 1";
          "${modifier}+eacute" = "workspace 2";
          "${modifier}+quotedbl" = "workspace 3";
          "${modifier}+apostrophe" = "workspace 4";
          "${modifier}+parenleft" = "workspace 5";
          "${modifier}+minus" = "workspace 6";
          "${modifier}+egrave" = "workspace 7";
          "${modifier}+underscore" = "workspace 8";
          "${modifier}+ccedilla" = "workspace 9";
          "${modifier}+agrave" = "workspace 10";

          # Move focused container to workspace
          "${modifier}+Shift+ampersand" = "move container to workspace 1";
          "${modifier}+Shift+eacute" = "move container to workspace 2";
          "${modifier}+Shift+quotedbl" = "move container to workspace 3";
          "${modifier}+Shift+apostrophe" = "move container to workspace 4";
          "${modifier}+Shift+parenleft" = "move container to workspace 5";
          "${modifier}+Shift+minus" = "move container to workspace 6";
          "${modifier}+Shift+egrave" = "move container to workspace 7";
          "${modifier}+Shift+underscore" = "move container to workspace 8";
          "${modifier}+Shift+ccedilla" = "move container to workspace 9";
          "${modifier}+Shift+agrave" = "move container to workspace 10";
          
          # Switch workspace to other output
          "${modifier}+m" = "move workspace to output left";
          "${modifier}+k" = "output DP-2 Toggle";

          # Resizing
          "${modifier}+Prior" = "resize grow width 20px";
          "${modifier}+Next" = "resize shrink width 20px";
          "${modifier}+Shift+Prior" = "resize grow height 20px";
          "${modifier}+Shift+Next" = "resize shrink height 20px";

          # Layout
          "${modifier}+b" = "splith";
          "${modifier}+v" = "splitv";
          "${modifier}+s" = "layout stacking";
          "${modifier}+w" = "layout tabbed";
          "${modifier}+e" = "layout toggle split";
          "${modifier}+f" = "fullscreen";
          "${modifier}+Shift+space" = "floating toggle";
          "${modifier}+space" = "focus mode_toggle";
          "${modifier}+a" = "focus parent";
        };
      };
    };
  };
}

# include @sysconfdir@/sway/config.d/*
# exec systemctl --user start graphical-session.target

# set $gnome-schema org.gnome.desktop.interface

# exec_always {
#     gsettings set $gnome-schema gtk-theme 'Yaru-dark'
#     gsettings set $gnome-schema icon-theme 'Yaru-dark'
#     gsettings set $gnome-schema cursor-theme 'Yaru-dark'
# }

# exec --no-startup-id light -S 1

