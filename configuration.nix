# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  console = {
    earlySetup = true;
    font = "ter-128n";
    keyMap = "us";
    packages = with pkgs;
      [
        terminus_font
      ];
  };

  environment.systemPackages = with pkgs; 
    [
      curl 
      sof-firmware
      vim
      wget
    ];

  i18n =
    {
      defaultLocale = "en_US.UTF-8";

      extraLocaleSettings =
        {
          LC_TIME = "en_GB.UTF-8";
        };

      supportedLocales =
        [
          "en_US.UTF-8/UTF-8"
          "en_GB.UTF-8/UTF-8"
        ];
    };

  networking =
    {
      hostName = "nala";
      networkmanager.enable = true;
    };

  nix = 
    {
      extraOptions = "experimental-features = nix-command flakes";

      gc = 
        {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 30d";
        };
  };

  nixpkgs =
    {
      hostPlatform = lib.mkDefault "x86_64-linux";
    };

  programs =
    {
      ssh.startAgent = true;
    };

  security.rtkit.enable = true;

  services =
    {
      openssh.enable = true;

      pipewire =
        {
          alsa =
            {
              enable = true;
              support32Bit = true;
            };

          enable = true;
          jack.enable = true;
          pulse.enable = true;
          wireplumber.enable = true;
        };

      printing =
        {
          drivers = with pkgs;
            [
              gutenprint
              hplip
            ];

          enable = true;
        };

      tlp =
        {
          enable = true;

          settings =
            {
              DEVICES_TO_DISABLE_ON_DOCK = "wifi wwan";
              DEVICES_TO_DISABLE_ON_LAN_CONNECT = "wifi wwan";
              DEVICES_TO_DISABLE_ON_WIFI_CONNECT = "wwan";
              DEVICES_TO_DISABLE_ON_WWAN_CONNECT = "wifi";
              DEVICES_TO_ENABLE_ON_LAN_DISCONNECT = "wifi wwan";
              DEVICES_TO_ENABLE_ON_UNDOCK = "wifi wwan";
              DEVICES_TO_ENABLE_ON_WIFI_DISCONNECT = "wwan";
              DEVICES_TO_ENABLE_ON_WWAN_DISCONNECT = "wifi";
              RESTORE_DEVICE_STATE_ON_STARTUP = 1;
              RESTORE_THRESHOLDS_ON_BAT = 1;
              START_CHARGE_THRESH_BAT0 = 75;
              STOP_CHARGE_THRESH_BAT0 = 80;
            };
        };

      udev =
        {
          enable = true;

          extraRules =
            ''
              ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video $sys$devpath/brightness", RUN+="${pkgs.coreutils}/bin/chmod g+w $sys$devpath/brightness"
            '';
        };
    };

  system.stateVersion = "22.11";

  time.timeZone = "America/Detroit";

  users.users.bbommarito =
    {
      createHome = true;

      extraGroups =
        [
          "audio"
          "networkmanager"
          "video"
          "wheel"
        ];

      initialPassword = "password";
      isNormalUser = true;
      shell = pkgs.fish;
    };

}

