{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    alyraffauf.user.aly.enable = lib.mkEnableOption "Enables Aly's user.";
  };

  config = lib.mkIf config.alyraffauf.user.aly.enable {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.aly = {
      isNormalUser = true;
      description = "Aly Raffauf";
      extraGroups = ["networkmanager" "wheel" "docker" "libvirtd" "video"];
    };

    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
      user = "aly";
      dataDir = "/home/aly";
      settings = {
        devices = {
          "brawly" = {id = "BBIBWMR-CN4CFC4-2XMPLII-XFWXBT5-EPCZCAF-JOWAX5J-DHIGNM4-O3XQ4Q3";}; # Pixel 6a
          "gsgmba" = {id = "V2YCZSL-XY7H72L-FGJFWP2-JNYX72O-OJ5V2HY-V4SSSJM-77A7E3Z-7EJFAAV";}; # Work Macbook Air
          "lavaridge" = {id = "6ZHSHTQ-HO7NLK5-JVKGTAN-H7W7KXS-QB5FN2X-CEDETRE-7E6LDHE-U5FYLAS";}; # Framework 13 AMD
          "mauville" = {id = "52MTCMC-PKEWSAU-HADMTZU-DY5EKFO-B323P7V-OBXLNTQ-EJY7F7Y-EUWFBQX";}; # Desktop/Homelab
          "petalburg" = {id = "E7XBKXN-QGEPQGZ-P6PIYXI-3IHWXRD-VJCFLYP-D3M6ACJ-EDZDQ3D-ZLTEBAC";}; # Yoga 9i
          "rustboro" = {id = "MUCZMA2-5K3XVT7-CF5W5MG-WZUG3PU-VAX6ZZY-FCTFPEZ-FNRSCNC-A4W5LAR";}; # Thinkpad t440p
          "mossdeep" = {id = "XRIGHMT-54OGBWP-UAAGAJS-LGTRHA2-EMKOMEB-EJEWKZN-GJFK6FO-3O6KQQ4";}; # Steam Deck OLED
          "wattson" = {id = "B2EYRQJ-LE2FR2J-D4M35TY-FXVGJ6D-USE7S2T-5V357SV-IQQWEAT-RQBLJQB";}; # Samsung a54 5g
          "winona" = {id = "IGAW5SS-WY2QN6J-5TF74YZ-6XPNPTC-RCH3HIT-ZZQKCAI-6L54IS2-SNRIMA2";}; # Pixel Tablet
        };
        folders = {
          "sync" = {
            id = "default";
            path = "/home/aly/sync";
            devices = ["brawly" "gsgmba" "lavaridge" "mauville" "petalburg" "rustboro" "mossdeep" "wattson" "winona"];
          };
          "camera" = {
            id = "fcsgh-dlxys";
            path = "/home/aly/pics/camera";
            devices = ["brawly" "lavaridge" "mauville" "petalburg" "rustboro" "wattson" "winona"];
          };
          "music" = {
            id = "6nzmu-z9der";
            path =
              if config.networking.hostName == "mauville"
              then "/mnt/Media/Music"
              else "/home/aly/music";
            devices = ["lavaridge" "mauville" "petalburg" "rustboro" "wattson"];
          };
        };
      };
    };
  };
}
