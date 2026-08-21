{
  # ══════════════════════════════════════════════
  #  repeek.hud — Head-Up Display
  #  Mode indicator + editor UI policy.
  #  Uses Snacks.win for floating badge,
  #  manages split separators & statusline.
  # ══════════════════════════════════════════════

  # ── Register Lua module on runtimepath ──
  extraFiles."lua/repeek/hud.lua".source = ../../lua/repeek/hud.lua;

  # ── Load on startup (after Snacks) ──
  extraConfigLua = ''
    require("repeek.hud").setup()
  '';
}
