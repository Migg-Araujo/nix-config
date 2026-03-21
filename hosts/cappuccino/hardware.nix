{ config, lib, pkgs, modulesPath, ... }:


{

  imports =

    [ (modulesPath + "/installer/scan/not-detected.nix")

    ];


  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];

  boot.initrd.kernelModules = [ ];

  boot.kernelModules = [ ];

  boot.extraModulePackages = [ ];


  fileSystems."/" =

    { device = "/dev/disk/by-uuid/90cbe40d-4f35-47f3-a8cf-7b6d0c595033";

      fsType = "btrfs";

      options = [ "subvol=@" ];

    };


  fileSystems."/boot" =

    { device = "/dev/disk/by-uuid/E480-A67B";

      fsType = "vfat";

      options = [ "fmask=0077" "dmask=0077" ];

    };


  swapDevices =

    [ { device = "/dev/disk/by-uuid/d203c355-b980-4670-a50b-744db25a4f4b"; }

    ];


  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

}
