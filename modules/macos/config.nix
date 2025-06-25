{
  system.defaults = {
    dock = {
      autohide = true;
      persistent-apps = [
        "/System/Applications/Mail.app"
        "/System/Applications/Calendar.app"
        "/Applications/Claude.app"
      ];
      mineffect = "scale";
      show-recents = false;
      tilesize = 32;
    };

    # “icnv” = Icon view, “Nlsv” = List view, “clmv” = Column View, “Flwv” = Gallery View
    finder = {
      FXPreferredViewStyle = "clmv";
      AppleShowAllExtensions = true;
    };

    loginwindow.GuestEnabled = false;
    NSGlobalDomain.KeyRepeat = 2;
  };
}
