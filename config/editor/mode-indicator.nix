{
  # ══════════════════════════════════════════════
  #  repeek.mode — Floating Mode Indicator
  #  Uses Snacks.win to display current Vim mode
  #  as a small label in the active window.
  # ══════════════════════════════════════════════

  # ── Register Lua module on runtimepath ──
  extraFiles."lua/repeek/mode.lua".source = ../../lua/repeek/mode.lua;

  # ── Load on startup (after Snacks) ──
  extraConfigLua = ''
    require("repeek.mode").setup()
  '';
}
