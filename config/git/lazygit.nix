{ pkgs, ... }:
{
  # ══════════════════════════════════════════════
  #  Lazygit — Binary for Snacks.lazygit()
  #  (keymap handled via snacks.lazygit in editor/snacks.nix)
  # ══════════════════════════════════════════════
  extraPackages = with pkgs; [
    lazygit
  ];
}
