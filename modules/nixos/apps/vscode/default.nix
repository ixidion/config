{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.apps.vscode;
in
{
  options.${namespace}.apps.vscode = with types; {
    enable = mkBoolOpt false "Whether or not to enable vscode.";
  };
  # TODO switch to codium
  config = mkIf cfg.enable { environment.systemPackages = with pkgs; [ vscode ]; };
}
