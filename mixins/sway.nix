{ pkgs, config, username, ... }:

{
  programs.light.enable = true;
  programs.sway.enable = true;
  
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

        startup = [
          { command = "${pkgs.light}/bin/light -S 0.1"; }
        ];
        
        keybindings = {

          # Fn Keys
          "${modifier}+Ctrl+Up" = "exec ${pkgs.pulsemixer}/bin/pulsemixer --change-volume +1";
          "${modifier}+Ctrl+Down" = "exec ${pkgs.pulsemixer}/bin/pulsemixer --change-volume -1";
          "XF86AudioMute" = "exec ${pkgs.pulsemixer}/bin/pulsemixer --toggle-mute";
          "${modifier}+Ctrl+Left" = "exec --no-startup-id ${pkgs.light}/bin/light -U 0.1";
          "${modifier}+Ctrl+Right" = "exec --no-startup-id ${pkgs.light}/bin/light -A 0.1";
          "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
          "${modifier}+Shift+Tab" = "exec ${pkgs.playerctl}/bin/playerctl previous";
          "${modifier}+Tab" = "exec ${pkgs.playerctl}/bin/playerctl next";

          # General
          "${modifier}+Return" = "exec ${terminal}";
          "${modifier}+Shift+q" = "kill";
          "${modifier}+d" = "exec ${pkgs.wldash}/bin/wldash";
          "${modifier}+Shift+c" = "reload";
          "${modifier}+Shift+e" = ''exec swaynag -t warning -m 'Do you really want to exit sway?' -b 'Yes, exit sway' 'swaymsg exit' '';
          "${modifier}+l" = ''exec ${pkgs.swaylock}/bin/swaylock -f -i ~/.background-image'';

          # Screenshots
          "print" = "exec mkdir -p ~/Screenshots && ${pkgs.grim}/bin/grim ~/Screenshots/$(date +'%Y-%m-%d-%H%M%S_grim.png')"; # Fullscreen
          "${modifier}+print" = ''exec mkdir -p ~/Screenshots && ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" ~/Screenshots/$(date +'%Y-%m-%d-%H%M%S_grim.png')''; # Region

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
          "${modifier}+ampersand" = "workspace number 1";
          "${modifier}+eacute" = "workspace number 2";
          "${modifier}+quotedbl" = "workspace number 3";
          "${modifier}+apostrophe" = "workspace number 4";
          "${modifier}+parenleft" = "workspace number 5";
          "${modifier}+minus" = "workspace number 6";
          "${modifier}+egrave" = "workspace number 7";
          "${modifier}+underscore" = "workspace number 8";
          "${modifier}+ccedilla" = "workspace number 9";

          # Move focused container to workspace
          "${modifier}+Shift+ampersand" = "move container to workspace number 1";
          "${modifier}+Shift+eacute" = "move container to workspace number 2";
          "${modifier}+Shift+quotedbl" = "move container to workspace number 3";
          "${modifier}+Shift+apostrophe" = "move container to workspace number 4";
          "${modifier}+Shift+parenleft" = "move container to workspace number 5";
          "${modifier}+Shift+minus" = "move container to workspace number 6";
          "${modifier}+Shift+egrave" = "move container to workspace number 7";
          "${modifier}+Shift+underscore" = "move container to workspace number 8";
          "${modifier}+Shift+ccedilla" = "move container to workspace number 9";
          
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

# set $gnome-schema org.gnome.desktop.interface

# exec_always {
#     gsettings set $gnome-schema gtk-theme 'Yaru-dark'
#     gsettings set $gnome-schema icon-theme 'Yaru-dark'
#     gsettings set $gnome-schema cursor-theme 'Yaru-dark'
# }

