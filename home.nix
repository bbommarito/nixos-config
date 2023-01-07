{ config, pkgs, ... }:

{
  home = 
    {
      homeDirectory = "/home/bbommarito";
      stateVersion = "22.11";
      username = "bbommarito";
    };

  programs = 
    {
      fish =
        {
          enable = true;
        };

      git =
        {
          enable = true;

          signing =
            { 
              key = "109C35F60C38B687";
              signByDefault = true;
            };

            userEmail = "brian@brianbommarito.xyz";
            userName = "Brian 'Burrito' Bommarito";
        };

      gpg =
        {
          enable = true;

          publicKeys =
            [
              {
                source = ./pgp/bbommarito.asc;
                trust = 5;
              }
            ];
        };

      home-manager = 
        {
          enable = true;
        };

      neovim =
        {
          enable = true;

          plugins = with pkgs.vimPlugins;
            [
              vim-nix
            ];

          viAlias = true;
          vimAlias = true;
        };
    };

  services =
    {
      gpg-agent =
        {
          enable = true;
          enableFishIntegration = true;
          enableScDaemon = true;
          enableSshSupport = true;

          sshKeys =
            [
              "43FFFE87392A3EA8128FE0356CE3AA586F4F63F7"
            ];
        };
    };

  xdg =
    {
      userDirs =
        {
          enable = true;
          desktop = "${config.home.homeDirectory}";
          documents = "${config.home.homeDirectory}/documents";
          download = "${config.home.homeDirectory}/download";
          music = "${config.home.homeDirectory}/music";
          pictures = "${config.home.homeDirectory}/pictures";
          publicShare = "${config.home.homeDirectory}/public";
          templates = "${config.home.homeDirectory}/templates";
          videos = "${config.home.homeDirectory}/videos";
        };
    };
}

