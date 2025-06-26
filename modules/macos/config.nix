{
  system.defaults = {
    dock = {
      autohide = true;
      persistent-apps = [
        {app = "/System/Applications/Mail.app";}
        {app = "/System/Applications/Calendar.app";}
        {app = "/Applications/Claude.app";}
      ];
      mineffect = "scale";
      show-recents = true;
      tilesize = 48;
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
