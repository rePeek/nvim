{ lib, ... }:
{
  # ══════════════════════════════════════════════
  #  Colorscheme — Nightfox Carbonfox
  # ══════════════════════════════════════════════
  colorschemes.nightfox = {
    enable = lib.mkDefault true;
    settings.flavor = "carbonfox";
  };
}
