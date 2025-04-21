{
  system.defaults = {
    dock = {
      autohide = true;
      persistent-apps = [
        "/System/Applications/Mail.app"
        "/System/Applications/Calendar.app"
        "/Applications/Claude.app"
        "/Applications/Perplexity.app"
      ];
    };

    # “icnv” = Icon view, “Nlsv” = List view, “clmv” = Column View, “Flwv” = Gallery View
    finder.FXPreferredViewStyle = "clmv";

    loginwindow.GuestEnabled = false;
    NSGlobalDomain.KeyRepeat = 2;
  };
}
