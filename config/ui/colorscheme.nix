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
    BlinkCmpMenu.link = "Normal";
    BlinkCmpMenuBorder.link = "Normal";
    BlinkCmpMenuSelection.link = "Visual";
    BlinkCmpDoc.link = "Normal";
    BlinkCmpDocBorder.link = "Normal";
    BlinkCmpSignatureHelp.link = "Normal";
    BlinkCmpSignatureHelpBorder.link = "Normal";
    BlinkCmpScrollBarThumb.link = "Normal";
    BlinkCmpScrollBarGutter.link = "Normal";
    SnacksIndentScope.link = "Comment";
    SnacksIndentChunk.link = "Comment";
  };
}
