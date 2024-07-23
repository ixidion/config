{
  lib,
  config,
  pkgs,
  namespace,
  osConfig ? { },
  ...
}:
let
  inherit (lib)
    types
    mkIf
    mkDefault
    mkMerge
    ;
  inherit (lib.${namespace}) mkOpt;

  cfg = config.${namespace}.user;

  home-directory = "/home/${cfg.name}";
in
{
  # TODO adjust to my needs
  options.${namespace}.user = {
    enable = mkOpt types.bool true "Whether to configure the user account.";
    name = mkOpt (types.nullOr types.str) (config.snowfallorg.user.name or "short") "The user account.";

    fullName = mkOpt types.str "ixidion" "The full name of the user.";
    email = mkOpt types.str "ixidion.ninja@gmail.com" "The email of the user.";

    home = mkOpt (types.nullOr types.str) home-directory "The user's home directory.";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      assertions = [
        {
          assertion = cfg.name != null;
          message = "plusultra.user.name must be set";
        }
        {
          assertion = cfg.home != null;
          message = "plusultra.user.home must be set";
        }
      ];

      home = {
        username = mkDefault cfg.name;
        homeDirectory = mkDefault cfg.home;
      };
    }
  ]);
}
