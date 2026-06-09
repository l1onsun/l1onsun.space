{ pkgs, ... }:
{
  home.packages = [pkgs.git-credential-manager];

  programs.git = {
    settings = {
      credential.helper = "manager";
      credential.credentialStore = "secretservice";
    };
  };
}
