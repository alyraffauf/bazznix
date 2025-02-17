# Lenovo Legion Go
{
  config,
  lib,
  self,
  ...
}: {
  imports = [
    ./home.nix
    ./secrets.nix
    ./stylix.nix
    (import ./../../disko/luks-btrfs-subvolumes.nix {disks = ["/dev/nvme0n1"];})
    self.inputs.jovian.nixosModules.default
    self.nixosModules.common-mauville-share
    self.nixosModules.common-tailscale
    self.nixosModules.common-us-locale
    self.nixosModules.common-wifi-profiles
    self.nixosModules.hw-lenovo-legion-go
  ];

  boot = {
    initrd.systemd.enable = true;

    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = lib.mkForce false;
        consoleMode = "1";
      };
    };
  };

  environment.variables.GDK_SCALE = "2";
  hardware.pulseaudio.enable = lib.mkForce false;

  jovian = {
    decky-loader = {
      enable = true;
      user = config.bazznix.user;
    };

    hardware.has.amd.gpu = true;

    steam = {
      enable = true;
      autoStart = true;
      desktopSession = "plasma";

      environment = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = lib.makeSearchPathOutput "steamcompattool" "" config.programs.steam.extraCompatPackages;
        STEAM_GAMESCOPE_COLOR_MANAGED = "0";
      };

      user = config.bazznix.user;
    };

    steamos = {
      enableAutoMountUdevRules = true;
      enableBluetoothConfig = true;
      enableDefaultCmdlineConfig = true;
      enableProductSerialAccess = true;
      enableVendorRadv = true;
      useSteamOSConfig = false;
    };
  };

  networking.hostName = "pacifidlog";
  system.stateVersion = "24.11";

  bazznix = {
    enable = true;
    user = "aly";

    users.aly = {
      enable = true;
      password = "$y$j9T$CXjk5Z9e2PXbSsWh5CK.81$I9Hm/Oa4KcYMqPi8KMBfsEv5NzoXCgaCK5xhyGeikH7";

      syncthing = {
        enable = true;
        certFile = config.age.secrets.syncthingCert.path;
        keyFile = config.age.secrets.syncthingKey.path;
        syncMusic = false;
      };
    };
  };
}
