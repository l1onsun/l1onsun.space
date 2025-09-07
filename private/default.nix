let
  importIfDecrypted =
    path:
    let
      attemptEval = builtins.tryEval (import path);
    in
    if attemptEval.success then attemptEval.value else { };
in
{ ... }:
{
  imports = [
    (importIfDecrypted ./helix_private.nix)
    (importIfDecrypted ./aider_models.nix)
  ];
}
