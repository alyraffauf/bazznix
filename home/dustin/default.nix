{ config, pkgs, ... }:

{
    imports = [
        ../common.nix
    ];

    # TODO please change the username & home directory to your own
    home.username = "dustin";
    home.homeDirectory = "/home/dustin";
}
