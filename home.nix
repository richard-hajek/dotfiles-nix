{ config, pkgs, ... }:

let
  desktops = {
    d1  = "ac3941b0-b16c-4cbb-a1c6-d00a573dc56f";
    d2  = "2da0dc38-a677-47ac-8e3f-c16777fc7e87";
    d3  = "1c21f121-6763-4b45-8fbc-303e412393c1";
    d4  = "8f561a5f-8b3d-40a9-81a0-19d84381749f";
    d5  = "6b0cc808-51bb-4b2f-8016-3929d206d3ff";
    d6  = "ec82d0f5-517d-491f-8b49-61d25d30495b";
    d7  = "1fca3029-b768-44d6-b5d4-859561e9cb03";
    d8  = "9d63ccee-7105-4cf9-bdfe-3f26aebdd503";
    d9  = "07994b29-4300-411e-a700-e974213d7e18";
    d10 = "1d37361f-3316-4cd3-ae3b-77a441e6a127";
  };
in
{

  imports = [
    <plasma-manager/modules>
    ./user.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  # home.username = "meowxiik";
  # home.homeDirectory = "/home/meowxiik";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    kdePackages.kate
    kdePackages.konversation

    lazydocker

    hexchat
    ncdu
    opencode

    devbox
    thunderbird
    blender
    kitty
    go
    chezmoi
    jetbrains.goland
    jetbrains.ruby-mine
    jetbrains.pycharm
    delta
    foreman
    zoxide
    fzf
    zsh-syntax-highlighting
    gcc
    killall
    lsof

    obsidian

    gimp

    nixfmt-rfc-style

    #vivaldi
    (vivaldi.overrideAttrs (oldAttrs: {
      dontWrapQtApps = false;
      dontPatchELF = true;
      nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ pkgs.kdePackages.wrapQtAppsHook ];
    }))
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/meowxiik/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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
      "services/net.local.new-tab.sh.desktop"._launch = "Meta+Return";
      "services/org.kde.krunner.desktop"._launch = [
        "Alt+F2"
        "Meta+D"
        "Search"
        "Alt+Space"
      ];
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
          {
            systemTray = { };
          }
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
        match.window-class.value = "kitty";
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
        match.window-class.value = "firefox";
        apply.desktops = {
          value = desktops.d2;
          apply = "initially";
        };
      }

      {
        description = "Settings for thunderbird";
        match.window-class.value = "thunderbird";
        apply.desktops = {
          value = desktops.d3;
          apply = "initially";
        };
      }

      {
        description = "Settings for jetbrains-rubymine";
        match.window-class.value = "jetbrains-rubymine";
        apply.desktops = {
          value = desktops.d3;
          apply = "initially";
        };
      }

      {
        description = "Settings for steam";
        match.window-class.value = "steam";
        apply.desktops = {
          value = desktops.d3;
          apply = "initially";
        };
      }

      {
        description = "Settings for vivaldi-stable";
        match.window-class.value = "vivaldi-stable";
        apply.desktops = {
          value = desktops.d5;
          apply = "initially";
        };
      }

      {
        description = "Settings for pycharm";
        match.window-class.value = "jetbrains-pycharm";
        apply.desktops = {
          value = desktops.d5;
          apply = "initially";
        };
      }

      {
        description = "Settings for obsidian";
        match.window-class.value = "obsidian";
        apply.desktops = {
          value = desktops.d5;
          apply = "initially";
        };
      }
    ];

    configFile = {
      kcminputrc."Libinput/1133/16514/Logitech MX Master 3".PointerAccelerationProfile = 1;
      ksmserverrc.General.loginMode = "emptySession";

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

      #      kwinrulesrc.General.count = 7;
      #      kwinrulesrc.General.rules = "996f6099-9c64-4bb3-9668-41bf294aba15,ce43c0b4-1db5-4bb0-b637-a8cbb3c2b0d5,fbf4dada-267b-48de-9df3-09e14a5dc012,143abaff-3d69-4781-9396-a7bf2f311c60,7561dd4f-e458-4511-bd10-072156dffd2a,22830e98-342b-45f4-8f13-8e571f67530c,57d8abfa-8f88-4357-803b-5cfaacaaea6f";
      #      kwinrulesrc."143abaff-3d69-4781-9396-a7bf2f311c60".Description = "Settings for thunderbird";
      #      kwinrulesrc."143abaff-3d69-4781-9396-a7bf2f311c60".desktops =
      #        "1c21f121-6763-4b45-8fbc-303e412393c1";
      #      kwinrulesrc."143abaff-3d69-4781-9396-a7bf2f311c60".desktopsrule = 3;
      #      kwinrulesrc."143abaff-3d69-4781-9396-a7bf2f311c60".wmclass = "thunderbird";
      #      kwinrulesrc."143abaff-3d69-4781-9396-a7bf2f311c60".wmclassmatch = 1;
      #      kwinrulesrc."22830e98-342b-45f4-8f13-8e571f67530c".Description = "Settings for jetbrains-rubymine";
      #      kwinrulesrc."22830e98-342b-45f4-8f13-8e571f67530c".desktops =
      #        "1c21f121-6763-4b45-8fbc-303e412393c1";
      #      kwinrulesrc."22830e98-342b-45f4-8f13-8e571f67530c".desktopsrule = 3;
      #      kwinrulesrc."22830e98-342b-45f4-8f13-8e571f67530c".wmclass = "jetbrains-rubymine";
      #      kwinrulesrc."22830e98-342b-45f4-8f13-8e571f67530c".wmclassmatch = 1;
      #      kwinrulesrc."57d8abfa-8f88-4357-803b-5cfaacaaea6f".Description = "Settings for vivaldi-stable";
      #      kwinrulesrc."57d8abfa-8f88-4357-803b-5cfaacaaea6f".desktops =
      #        "6b0cc808-51bb-4b2f-8016-3929d206d3ff";
      #      kwinrulesrc."57d8abfa-8f88-4357-803b-5cfaacaaea6f".desktopsrule = 3;
      #      kwinrulesrc."57d8abfa-8f88-4357-803b-5cfaacaaea6f".wmclass = "vivaldi-stable";
      #      kwinrulesrc."57d8abfa-8f88-4357-803b-5cfaacaaea6f".wmclassmatch = 1;
      #      kwinrulesrc."7561dd4f-e458-4511-bd10-072156dffd2a".Description = "Settings for steam";
      #      kwinrulesrc."7561dd4f-e458-4511-bd10-072156dffd2a".desktops =
      #        "1c21f121-6763-4b45-8fbc-303e412393c1";
      #      kwinrulesrc."7561dd4f-e458-4511-bd10-072156dffd2a".desktopsrule = 3;
      #      kwinrulesrc."7561dd4f-e458-4511-bd10-072156dffd2a".wmclass = "steam";
      #      kwinrulesrc."7561dd4f-e458-4511-bd10-072156dffd2a".wmclassmatch = 1;
      #      kwinrulesrc."996f6099-9c64-4bb3-9668-41bf294aba15".Description = "Settings for kitty";
      #      kwinrulesrc."996f6099-9c64-4bb3-9668-41bf294aba15".desktops =
      #        "ac3941b0-b16c-4cbb-a1c6-d00a573dc56f";
      #      kwinrulesrc."996f6099-9c64-4bb3-9668-41bf294aba15".desktopsrule = 3;
      #      kwinrulesrc."996f6099-9c64-4bb3-9668-41bf294aba15".maximizehoriz = true;
      #      kwinrulesrc."996f6099-9c64-4bb3-9668-41bf294aba15".maximizehorizrule = 3;
      #      kwinrulesrc."996f6099-9c64-4bb3-9668-41bf294aba15".maximizevert = true;
      #      kwinrulesrc."996f6099-9c64-4bb3-9668-41bf294aba15".maximizevertrule = 3;
      #      kwinrulesrc."996f6099-9c64-4bb3-9668-41bf294aba15".noborder = true;
      #      kwinrulesrc."996f6099-9c64-4bb3-9668-41bf294aba15".noborderrule = 3;
      #      kwinrulesrc."996f6099-9c64-4bb3-9668-41bf294aba15".wmclass = "kitty";
      #      kwinrulesrc."996f6099-9c64-4bb3-9668-41bf294aba15".wmclassmatch = 1;
      #      kwinrulesrc.ce43c0b4-1db5-4bb0-b637-a8cbb3c2b0d5.Description = "Settings for firefox";
      #      kwinrulesrc.ce43c0b4-1db5-4bb0-b637-a8cbb3c2b0d5.desktops = "2da0dc38-a677-47ac-8e3f-c16777fc7e87";
      #      kwinrulesrc.ce43c0b4-1db5-4bb0-b637-a8cbb3c2b0d5.desktopsrule = 3;
      #      kwinrulesrc.ce43c0b4-1db5-4bb0-b637-a8cbb3c2b0d5.wmclass = "firefox";
      #      kwinrulesrc.ce43c0b4-1db5-4bb0-b637-a8cbb3c2b0d5.wmclassmatch = 1;
      #      kwinrulesrc.fbf4dada-267b-48de-9df3-09e14a5dc012.Description = "Settings for Ferdium";
      #      kwinrulesrc.fbf4dada-267b-48de-9df3-09e14a5dc012.desktops = "6b0cc808-51bb-4b2f-8016-3929d206d3ff";
      #      kwinrulesrc.fbf4dada-267b-48de-9df3-09e14a5dc012.desktopsrule = 2;
      #      kwinrulesrc.fbf4dada-267b-48de-9df3-09e14a5dc012.wmclass = "Ferdium";
      #      kwinrulesrc.fbf4dada-267b-48de-9df3-09e14a5dc012.wmclassmatch = 1;
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
