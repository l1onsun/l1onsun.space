{ pkgs, ... }:
{
  home.packages = [
    pkgs.zellij
  ];
  xdg.configFile."zellij/config.kdl".source = ./config.kdl;
}
  # programs.zellij = {
  #   enable = true;
  #   # enableFishIntegration = true;
  #   settings = {
  #     simplified_ui = true;
  #     session_serialization = false;
  #     default_shell = "fish";
  #     # default_mode = "locked";
  #     keybinds = {
  #       normal = {
  #         _props = {
  #           # This attribute defines KDL props.
  #           clear-defaults = true;
  #         };
  #         "bind \"Ctrl b\"" = {
  #           SwitchToMode = "Tmux";
  #         };
  #       };
  #       tmux = {
  #         "bind \"Ctrl e\"" = {
  #           EditScrollback = null;
  #           SwitchToMode = "Normal";
  #         };
  #       };
  #     };
  #     default_layout = "compact";
  #     pane_frames = false;
  #     theme = "rose_pine";
  #     themes.rose_pine = {
  #       bg = "#403d52";
  #       fg = "#e0def4";
  #       red = "#eb6f92";
  #       green = "#31748f";
  #       blue = "#9ccfd8";
  #       yellow = "#f6c177";
  #       magenta = "#c4a7e7";
  #       orange = "#fe640b";
  #       cyan = "#ebbcba";
  #       black = "#26233a";
  #       white = "#e0def4";
  #     };
  #   };
  # };
  # home.packages = [
  #   pkgs.isort
  #   pkgs.pyright
  #   pkgs.black
  #   pkgs.typos-lsp
  # ];
# }
