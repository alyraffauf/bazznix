{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./syncthing.nix];

  config = lib.mkIf config.steamed-nix.users.aly.enable {
    users.users.aly = {
      description = "Aly Raffauf";
      extraGroups = config.steamed-nix.users.defaultGroups;
      hashedPassword = config.steamed-nix.users.aly.password;
      isNormalUser = true;

      openssh.authorizedKeys = {
        keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGcJBb7+ZxkDdk06A0csNsbgT9kARUN185M8k3Lq7E/d u0_a336@localhost" # termux on winona
        ];

        keyFiles = [
          ../../secrets/publicKeys/aly_lavaridge.pub
          ../../secrets/publicKeys/aly_mauville.pub
          ../../secrets/publicKeys/aly_petalburg.pub
          ../../secrets/publicKeys/aly_rustboro.pub
        ];
      };

      shell = pkgs.zsh;
      uid = 1000;
    };
  };
}
