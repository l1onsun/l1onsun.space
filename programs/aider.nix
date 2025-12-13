{ pkgs, ... }:
{
  home.file.".aider.conf.yml".text = ''
    dark-mode: true
    # auto-commits: false
    # show-model-warnings: false
    check-update: false
  '';
  
  
  home.packages = [
    pkgs.aider-chat
  ];
}
