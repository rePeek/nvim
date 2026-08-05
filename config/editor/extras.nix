{
  # ══════════════════════════════════════════════
  #  Extra Plugins (LazyVim util.lua + misc)
  # ══════════════════════════════════════════════

  # ── Multicursors ──
  plugins.multicursors = {
    enable = true;
  };

  # ── Web Devicons (fallback if mini.icons not enough) ──
  plugins.web-devicons.enable = true;

  # ── Indent Blankline (replaced by snacks.indent, keep as fallback) ──
  plugins.indent-blankline = {
    enable = false; # snacks.indent handles this now
  };

  # ── NUI (required by noice/dap-ui) ──
  plugins.nui = {
    enable = true;
  };
}
