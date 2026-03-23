{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    #profiles.migg = {
    #  settings = {
    #    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    #    "browser.tabs.drawInTitlebar" = true;
    #    "browser.uidensity" = 0;
    #  };
    #};
  };
}
