{
  config,
  inputs,
  lib,
  pkgs,
  self,
  ...
}: {
  options = {
    alyraffauf = {
      apps = {
        nicotine-plus.enable =
          lib.mkEnableOption "Nicotine+ Soulseek client.";
        podman.enable =
          lib.mkEnableOption "Podman for OCI container support.";
        steam.enable =
          lib.mkEnableOption "Valve's Steam for video games.";
        virt-manager.enable =
          lib.mkEnableOption "Virt-manager for virtual machines with TPM and EFI support.";
      };

      base.enable =
        lib.mkEnableOption "Basic system configuration and sane defaults.";

      containers = {
        nixos = {
          audiobookshelf = {
            enable =
              lib.mkEnableOption "audiobookshelf audiobook and podcast server in NixOS container.";
            mediaDirectory = lib.mkOption {
              description = "Media directory for audiobookshelf.";
              default = "/mnt/Media";
              type = lib.types.str;
            };
            port = lib.mkOption {
              description = "Port for audiobookshelf.";
              default = 13378;
              type = lib.types.int;
            };
          };
          navidrome = {
            enable =
              lib.mkEnableOption "Navidrome music server in NixOS container.";
            musicDirectory = lib.mkOption {
              description = "Music directory for Navidrome.";
              default = "/mnt/Media/Music";
              type = lib.types.str;
            };
            port = lib.mkOption {
              description = "Port for Navidrome.";
              default = 4533;
              type = lib.types.int;
            };
          };
        };
        oci = {
          audiobookshelf = {
            enable =
              lib.mkEnableOption "audiobookshelf podcast and audiobook server in OCI container.";
            mediaDirectory = lib.mkOption {
              description = "Media directory for audiobookshelf.";
              default = "/mnt/Media";
              type = lib.types.str;
            };
            port = lib.mkOption {
              description = "Port for audiobookshelf.";
              default = 13378;
              type = lib.types.int;
            };
          };
          freshRSS = {
            enable =
              lib.mkEnableOption "FreshRSS news client in OCI container.";
            port = lib.mkOption {
              description = "Port for FreshRSS.";
              default = 8080;
              type = lib.types.int;
            };
          };
          jellyfin = {
            enable =
              lib.mkEnableOption "Jellyfin media server in OCI container.";
            archiveDirectory = lib.mkOption {
              description = "Archive directory for Jellyfin.";
              default = "/mnt/Archive";
              type = lib.types.str;
            };
            mediaDirectory = lib.mkOption {
              description = "Media directory for Jellyfin.";
              default = "/mnt/Media";
              type = lib.types.str;
            };
            port = lib.mkOption {
              description = "Port for Jellyfin.";
              default = 8096;
              type = lib.types.int;
            };
          };
          plexMediaServer = {
            enable =
              lib.mkEnableOption "Plex Media Server in OCI container.";
            archiveDirectory = lib.mkOption {
              description = "Archive directory for Plex Media Server.";
              default = "/mnt/Archive";
              type = lib.types.str;
            };
            mediaDirectory = lib.mkOption {
              description = "Media directory for Plex Media Server.";
              default = "/mnt/Media";
              type = lib.types.str;
            };
            port = lib.mkOption {
              description = "Port for Plex Media Server.";
              default = 32400;
              type = lib.types.int;
            };
          };
          transmission = {
            enable =
              lib.mkEnableOption "Transmission Bittorrent client in OCI container.";
            archiveDirectory = lib.mkOption {
              description = "Archive directory for Transmission.";
              default = "/mnt/Archive";
              type = lib.types.str;
            };
            bitTorrentPort = lib.mkOption {
              description = "Port for BitTorrent p2p services..";
              default = 5143;
              type = lib.types.int;
            };
            mediaDirectory = lib.mkOption {
              description = "Media directory for Transmission.";
              default = "/mnt/Media";
              type = lib.types.str;
            };
            port = lib.mkOption {
              description = "Port for Transmission.";
              default = 9091;
              type = lib.types.int;
            };
          };
        };
      };
      desktop = {
        cinnamon.enable =
          lib.mkEnableOption "Cinnamon desktop session.";
        gnome = {
          enable =
            lib.mkEnableOption "GNOME desktop session.";
          fprintdFix.enable =
            lib.mkEnableOption
            "Fix fprintd & pam issues with GNOME Display Manager.";
        };
        greetd = {
          enable =
            lib.mkEnableOption "Greetd display manager.";

          autologin = {
            enable = lib.mkOption {
              description = "Whether to enable autologin.";
              default = false;
              type = lib.types.bool;
            };
            user = lib.mkOption {
              description = "User to autologin.";
              default = "aly";
              type = lib.types.str;
            };
          };
          session = lib.mkOption {
            description = "Default command to execute on login.";
            default = lib.getExe config.programs.hyprland.package;
            type = lib.types.str;
          };
        };
        hyprland.enable =
          lib.mkEnableOption "Hyprland wayland session.";
        lightdm.enable =
          lib.mkEnableOption
          "Lightdm and slick greeter with Catppuccin theme.";
        plasma.enable =
          lib.mkEnableOption "Plasma desktop session.";
        sway.enable =
          lib.mkEnableOption "Sway wayland session.";
        waylandComp = lib.mkOption {
          description = "Shared defaults for wayland compositors.";
          default =
            config.alyraffauf.desktop.hyprland.enable
            || config.alyraffauf.desktop.sway.enable;
          type = lib.types.bool;
        };
      };
      scripts.hoenn.enable =
        lib.mkEnableOption "Hoenn system configuration script";
      services = {
        binaryCache.enable = lib.mkEnableOption "nixpkgs cache server.";
        flatpak.enable =
          lib.mkEnableOption "Flatpak support with GUI.";
        ollama = {
          enable = lib.mkEnableOption "Ollama interface for LLMs.";
          listenAddress = lib.mkOption {
            description = "Listen Address for Ollama.";
            default = "127.0.0.1:11434";
            type = lib.types.str;
          };
          gpu = lib.mkOption {
            description = "Type of GPU for enabling GPU acceleration.";
            default = null;
            type = lib.types.str;
          };
        };
        syncthing = {
          enable = lib.mkEnableOption "Syncthing sync service.";
          user = lib.mkOption {
            description = "Specify user Syncthing runs as.";
            default = "aly";
            type = lib.types.str;
          };
          syncMusic = lib.mkOption {
            description = "Whether to sync music folder.";
            default = true;
            type = lib.types.bool;
          };
          musicPath = lib.mkOption {
            description = "Whether to sync music folder.";
            default = "/home/${config.alyraffauf.services.syncthing.user}/music";
            type = lib.types.str;
          };
        };
        tailscale.enable = lib.mkEnableOption "Tailscale WireGuard VPN.";
      };
      base = {
        plymouth.enable =
          lib.mkEnableOption "Plymouth boot screen with catppuccin theme.";
        power-profiles-daemon.enable = lib.mkOption {
          description = "Power Profiles Daemon for power management.";
          default = true;
          type = lib.types.bool;
        };
        zramSwap = {
          enable = lib.mkEnableOption "Zram swap.";
          size = lib.mkOption {
            description = "Percent size of the zram swap relative to RAM.";
            default = 50;
            type = lib.types.int;
          };
        };
      };
      users = {
        aly = {
          enable = lib.mkEnableOption "Aly's user.";
          password = lib.mkOption {
            description = "Hashed password for aly.";
            type = lib.types.str;
          };
        };
        dustin = {
          enable = lib.mkEnableOption "Dustin's user.";
          password = lib.mkOption {
            description = "Hashed password for dustin.";
            type = lib.types.str;
          };
        };
      };
    };
  };
}