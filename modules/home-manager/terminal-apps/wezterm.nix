{
  programs.wezterm = let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in {
    enable = true;
    enableZshIntegration = true;
    extraConfig = toLuaFile ./wezterm/wezterm.lua;
  };
}
