{ lib, ... }:
{
  # ══════════════════════════════════════════════
  #  Colorscheme — Nightfox Carbonfox
  # ══════════════════════════════════════════════
  colorschemes.nightfox = {
    enable = lib.mkDefault true;
    settings = {
      flavor = "carbonfox";
      options.transparent = true;
    };
  };

  highlightOverride = {
    NormalFloat.link = "Normal";
    SnacksPickerNormal.link = "Normal";
    SnacksPickerListNormal.link = "Normal";
    SnacksPickerPreviewNormal.link = "Normal";
    SnacksPickerInputNormal.link = "Normal";
    SnacksIndentScope.link = "Comment";
    SnacksIndentChunk.link = "Comment";
  };
}
