{ opkgs, ... }:
{
  home.packages = [
    (opkgs.tome4.overrideAttrs (previousAttrs: {
      installPhase =
        previousAttrs.installPhase
        + ''
          cp ${./tome-ru_RU-.teaa} $out/share/tome4/game/addons/tome-ru_RU-.teaa
        '';
    }))
  ];
}
