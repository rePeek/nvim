{ lib, ... }:
{
  # ══════════════════════════════════════════════
  #  Colorscheme — Tokyo Night (LazyVim default)
  # ══════════════════════════════════════════════
  colorschemes.tokyonight = {
    enable = lib.mkDefault true;
    settings = {
      style = "storm";
      transparent = false;
      styles = {
        sidebars = "dark";
        floats = "dark";
      };
    };
  };
}
