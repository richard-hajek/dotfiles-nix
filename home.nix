{ config, pkgs, ... }:

let
  desktops = {
    d1 = "ac3941b0-b16c-4cbb-a1c6-d00a573dc56f";
    d2 = "2da0dc38-a677-47ac-8e3f-c16777fc7e87";
    d3 = "1c21f121-6763-4b45-8fbc-303e412393c1";
    d4 = "8f561a5f-8b3d-40a9-81a0-19d84381749f";
    d5 = "6b0cc808-51bb-4b2f-8016-3929d206d3ff";
    d6 = "ec82d0f5-517d-491f-8b49-61d25d30495b";
    d7 = "1fca3029-b768-44d6-b5d4-859561e9cb03";
    d8 = "9d63ccee-7105-4cf9-bdfe-3f26aebdd503";
    d9 = "07994b29-4300-411e-a700-e974213d7e18";
    d10 = "1d37361f-3316-4cd3-ae3b-77a441e6a127";
  };
in
{

  imports = [
    <plasma-manager/modules>
    ./user.nix
  ];

  programs.home-manager.enable = true;

  programs.obs-studio = {
    enable = true;

    # optional Nvidia hardware acceleration
    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-gstreamer
      obs-vkcapture
    ];
  };

  home = {
    stateVersion = "25.11";

    packages = with pkgs; [
      blender
      chezmoi
      delta
      devbox
      foreman
      fzf
      gcc
      gimp
      godot
      jetbrains.goland
      jetbrains.pycharm
      jetbrains.ruby-mine
      jetbrains.rust-rover
      kdePackages.kate
      killall
      kitty
      lazydocker
      libreoffice
      lsof
      ncdu
      nixfmt-rfc-style
      obsidian
      opencode
      ripgrep
      thunderbird
      zoxide
      libnotify
      glib

      (vivaldi.overrideAttrs (oldAttrs: {
        dontWrapQtApps = false;
        dontPatchELF = true;
        nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ pkgs.kdePackages.wrapQtAppsHook ];
      }))
    ];
  };

  programs.plasma = {
    overrideConfig = true;
    enable = true;

    input.keyboard.numlockOnStartup = "on";
    workspace = {
      clickItemTo = "select";
      lookAndFeel = "org.kde.breezedark.desktop";
    };

    shortcuts = {
      kwin."Switch to Desktop 1" = "Meta+1";
      kwin."Switch to Desktop 2" = "Meta+2";
      kwin."Switch to Desktop 3" = "Meta+3";
      kwin."Switch to Desktop 4" = "Meta+4";
      kwin."Switch to Desktop 5" = "Meta+5";
      kwin."Switch to Desktop 6" = "Meta+6";
      kwin."Switch to Desktop 7" = "Meta+7";
      kwin."Switch to Desktop 8" = "Meta+8";
      kwin."Switch to Desktop 9" = "Meta+9";
      kwin."Switch to Desktop 10" = "Meta+0";

      kwin."Window to Desktop 1" = "Meta+!";
      kwin."Window to Desktop 2" = "Meta+@";
      kwin."Window to Desktop 3" = "Meta+#";
      kwin."Window to Desktop 4" = "Meta+$";
      kwin."Window to Desktop 5" = "Meta+%";
      kwin."Window to Desktop 6" = "Meta+^";
      kwin."Window to Desktop 7" = "Meta+&";
      kwin."Window to Desktop 8" = "Meta+*";
      kwin."Window to Desktop 9" = "Meta+(";
      kwin."Window to Desktop 10" = "Meta+)";

      kwin."Window Close" = [
        "Meta+Shift+Q"
        "Alt+F4"
      ];
      "services/org.kde.krunner.desktop"._launch = [
        "Alt+F2"
        "Meta+D"
        "Search"
        "Alt+Space"
      ];
    };

    hotkeys.commands."launch-kitty" = {
      name = "Launch Kitty";
      key = "Meta + Return";
      command = "${config.home.homeDirectory}/.local/bin/Scripts/new-tab.sh";
    };

    session = {
      general.askForConfirmationOnLogout = false;
      sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
    };

    panels = [
      {
        location = "bottom";
        height = 40;
        widgets = [
          {
            kickoff = {
              sortAlphabetically = true;
              icon = "nix-snowflake-white";
            };

          }
          { pager = { }; }
          "org.kde.plasma.marginsseparator"
          {
            iconTasks = {
              launchers = [ ];
              behavior.grouping.method = "none";
            };
          }
          { systemTray = { }; }
          {
            digitalClock = {
              calendar.firstDayOfWeek = "monday";
              time.format = "24h";
            };
          }
        ];
      }
    ];

    window-rules = [
      {
        description = "Settings for kitty";
        match.window-class.value = "kitty kitty";
        apply = {
          desktops.value = desktops.d1;
          desktops.apply = "force";
          maximizehoriz = {
            value = true;
            apply = "force";
          };
          maximizevert = {
            value = true;
            apply = "force";
          };
          noborder = {
            value = true;
            apply = "force";
          };
        };
      }

      {
        description = "Settings for firefox";
        match.window-class.value = "firefox firefox";
        apply.desktops = {
          value = desktops.d2;
          apply = "force";
        };
      }

      {
        description = "Settings for thunderbird";
        match.window-class.value = "thunderbird thunderbird";
        apply.desktops = {
          value = desktops.d3;
          apply = "force";
        };
      }

      {
        description = "Settings for jetbrains-rubymine";
        match.window-class.value = "jetbrains-rubymine jetbrains-rubymine";
        apply.desktops = {
          value = desktops.d3;
          apply = "force";
        };
      }

      {
        description = "Settings for jetbrains-rustrover";
        match.window-class.value = "jetbrains-rustrover jetbrains-rustrover";
        apply.desktops = {
          value = desktops.d3;
          apply = "force";
        };
      }

      {
        description = "Settings for steam";
        match.window-class.value = "steamwebhelper steam";
        apply.desktops = {
          value = desktops.d3;
          apply = "force";
        };
      }

      {
        description = "Settings for vivaldi-stable";
        match.window-class.value = "vivaldi-bin vivaldi-stable";
        apply.desktops = {
          value = desktops.d5;
          apply = "force";
        };
      }

      {
        description = "Settings for pycharm";
        match.window-class.value = "jetbrains-pycharm jetbrains-pycharm";
        apply.desktops = {
          value = desktops.d3;
          apply = "force";
        };
      }

      {
        description = "Settings for obsidian";
        match.window-class.value = "obsidian obsidian";
        apply.desktops = {
          value = desktops.d3;
          apply = "force";
        };
      }
    ];

    configFile = {
      kcminputrc."Libinput/1133/16514/Logitech MX Master 3".PointerAccelerationProfile = 1;

      kdeglobals.KDE.AnimationDurationFactor = 0;

      kwinrc.Desktops = {
        Id_1 = desktops.d1;
        Id_2 = desktops.d2;
        Id_3 = desktops.d3;
        Id_4 = desktops.d4;
        Id_5 = desktops.d5;
        Id_6 = desktops.d6;
        Id_7 = desktops.d7;
        Id_8 = desktops.d8;
        Id_9 = desktops.d9;
        Id_10 = desktops.d10;
        Number = 10;
        Rows = 2;
      };

      kxkbrc.Layout.DisplayNames = ",";
      kxkbrc.Layout.LayoutList = "cz,cz";
      kxkbrc.Layout.Use = true;
      kxkbrc.Layout.VariantList = "coder,qwerty";
      plasma-localerc.Formats.LANG = "en_US.UTF-8";
    };
    dataFile = {

    };
  };
}
