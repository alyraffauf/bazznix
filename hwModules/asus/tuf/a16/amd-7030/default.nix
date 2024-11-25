{
  lib,
  pkgs,
  self,
  ...
}: {
  imports = [
    self.nixosModules.hw-common
    self.nixosModules.hw-common-amd-cpu
    self.nixosModules.hw-common-amd-gpu
    self.nixosModules.hw-common-bluetooth
    self.nixosModules.hw-common-laptop
    self.nixosModules.hw-common-ssd
  ];

  boot = {
    initrd.availableKernelModules = ["nvme" "sd_mod" "thunderbolt" "usb_storage" "xhci_pci"];
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
  };

  environment.systemPackages = with pkgs; [
    supergfxctl
  ];

  networking.networkmanager = {
    enable = true;

    wifi = {
      backend = "iwd";
      powersave = true;
    };
  };

  services.supergfxd.enable = true;
}
