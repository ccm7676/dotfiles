# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }: 


{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  hardware.bluetooth.enable = true;

  programs.hyprland.enable = true;
  programs.hyprland.xwayland.hidpi = true;
  programs.hyprland.xwayland.enable = true; 

  services.flatpak.enable = true;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
 
  services.physlock.enable = true;
  services.physlock.allowAnyUser = true;
  services.physlock.lockOn.suspend = true; 
  services.logind.lidSwitch = "suspend-then-hibernate";
  services.logind.lidSwitchExternalPower = "lock"; 
  systemd.sleep.extraConfig = "HibernateDelaySec=1h";		
  services.logind.extraConfig = "
    idleAction=suspend-then-hibernate
    idleActionSec=15min";


  networking.hostName = "device";
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  security.pki.certificateFiles = ["/etc/ssl/certs/SCHOOL-BRY-AD1-CA"];
  # Set your time zone.
  time.timeZone = "Europe/London";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  virtualisation.waydroid.enable = true; 
  environment.sessionVariables.DEFAULT_BROWSER = "${pkgs.brave}/bin/brave";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  #console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  #};

  # Enable the X11 windowing system.
  services.xserver.enable = true;

 

  # Configure keymap in X11
  services.xserver.layout = "de";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";
  programs.adb.enable = true;


  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  #sound.enable = true;
  hardware.pulseaudio.enable = false;
  programs.wireshark.enable = true;

  security.rtkit.enable = true;
  
  #SOUND NOT ENABLED BECAUSE PIPEWIRE USED INSTEAD
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };  

# Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.carl = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager"]; 
     packages = with pkgs; [
       flatpak
       kitty
       hyprpaper
     ];
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
      vim
      pfetch
      wget
      sudo
      rustc
      gnome.gnome-keyring
      pw-volume
      physlock
      gnome.gnome-software
   ];

  services.gnome.gnome-keyring.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  programs.sway.enable = true;
  
  services.dbus.enable = true;
  
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };
 
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
