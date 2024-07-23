{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) types mkEnableOption mkIf;
  cfg = config.${namespace}.tools.ssh;
in
{
  options.${namespace}.tools.ssh = {
    enable = mkEnableOption "SSH";
  };
  # TODO adjust to my needs
  config = mkIf cfg.enable {
    programs.ssh = {
      extraConfig = ''
        Host *
          HostKeyAlgorithms +ssh-rsa
      '';
    };
  };
}
