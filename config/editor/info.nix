{
  # ══════════════════════════════════════════════
  #  repeek.info — Current buffer information HUD
  # ══════════════════════════════════════════════

  extraFiles."lua/repeek/info.lua".source = ../../lua/repeek/info.lua;

  extraConfigLua = ''
    require("repeek.info").setup()
  '';
}
