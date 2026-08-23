{
  # ══════════════════════════════════════════════
  #  repeek.mod — Mode Badge + Editor UI
  #  Mode indicator + editor UI policy.
  #  Uses Snacks.win for floating badge,
  #  manages split separators & statusline.
  # ══════════════════════════════════════════════

  # ── Register Lua module on runtimepath ──
  extraFiles."lua/repeek/mod.lua".source = ../../lua/repeek/mod.lua;

  # ── Load on startup (after Snacks) ──
  extraConfigLua = ''
    require("repeek.mod").setup()
  '';
}
