{ self, config, lib, pkgs, ... }:

{
  services = {
    nginx.virtualHosts = {
      "cloud" = {
        forceSSL = true;
        enableACME = true;
      };

      "office" = {
        forceSSL = true;
        enableACME = true;
      };
    };

    nextcloud = {
      enable = true;
      hostName = "cloud";

       # Need to manually increment with every major upgrade.
      package = pkgs.nextcloud30;

      # Let NixOS install and configure the database automatically.
      database.createLocally = true;

      # Let NixOS install and configure Redis caching automatically.
      configureRedis = true;

      # Increase the maximum file upload size to avoid problems uploading videos.
      maxUploadSize = "16G";
      https = true;

      autoUpdateApps.enable = true;
      extraAppsEnable = true;
      extraApps = with config.services.nextcloud.package.packages.apps; {
        # List of apps we want to install and are already packaged in
        # https://github.com/NixOS/nixpkgs/blob/master/pkgs/servers/nextcloud/packages/nextcloud-apps.json
        inherit calendar contacts mail notes onlyoffice tasks;

        # Custom app installation example.
        #cookbook = pkgs.fetchNextcloudApp rec {
        #  url =
        #    "https://github.com/nextcloud/cookbook/releases/download/v0.10.2/Cookbook-0.10.2.tar.gz";
        #  sha256 = "sha256-XgBwUr26qW6wvqhrnhhhhcN4wkI+eXDHnNSm1HDbP6M=";
        #};
      };

      config = {
        overwriteProtocol = "https";
        defaultPhoneRegion = "PT";
        dbtype = "pgsql";
        adminuser = "admin";
        adminpassFile = "~/.secrets/nextcloud.age";
      };
    };

    onlyoffice = {
      enable = true;
      hostname = "office";
    };
  };
  
  security.acme = {
    acceptTerms = true;
    defaults.email = "machtendo@outlook.com";
  # certs."mx1.example.org" = {
  # dnsProvider = "inwx";
    # Supplying password files like this will make your credentials world-readable
    # in the Nix store. This is for demonstration purpose only, do not use this in production.
    # environmentFile = "${pkgs.writeText "inwx-creds" ''
    #  INWX_USERNAME=xxxxxxxxxx
    #  INWX_PASSWORD=yyyyyyyyyy
    # ''}";
   #};
  };
}