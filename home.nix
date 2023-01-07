{ config, pkgs, ... }:

{
  imports = [./mail];


  home = 
    {
      file =
        {
          ".mailcap" =
            {
              target = ".mailcap";
              text =
                ''
                  text/html; ${pkgs.lynx}/bin/lynx -assume_charset=%{charset} -display_charset=utf-8 -dump -width=1024 %s; nametemplate=%s.html; copiousoutput;
                '';
            };
        };

      homeDirectory = "/home/bbommarito";

      packages = with pkgs;
        [
          lynx
        ];

      stateVersion = "22.11";
      username = "bbommarito";
    };

  programs = 
    {
      fish =
        {
          enable = true;

          shellInit =
            ''
              gpg-connect-agent updatestartuptty /bye
            '';
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

      mbsync.enable = true;
      msmtp.enable = true;

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
        
      password-store.enable = true;
      ssh.enable = true;
    };

  services =
    {
      gpg-agent =
        {
          enable = true;
          enableFishIntegration = true;
          enableSshSupport = true;

          sshKeys =
            [
              "43FFFE87392A3EA8128FE0356CE3AA586F4F63F7"
              "cardno:13 193 209"
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

