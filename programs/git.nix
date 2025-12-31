{ pkgs, ... }:
{
  home.packages = [
    pkgs.difftastic
    pkgs.git-credential-manager
    pkgs.xdg-utils
  ];
  programs.git.package = pkgs.git;
  programs.git = {
    enable = true;
    lfs.enable = true;
    lfs.skipSmudge = true;
    userName = "Ilya Cherezov";
    userEmail = "cherezov.ia@phystech.edu";

    # difftastic.enable = true;
    # config = {
    aliases = {
      st = "status -sb";
      ll = "log --oneline -n 10";
      cm = "commit -m";
      ca = "commit --amend";
      d = "diff --name-only --diff-filter=d";
      ch = "checkout";
      sw = "checkout -";
      rsw = "restore --staged --worktree";
      dft = "difftool";
    };
    extraConfig = {
      # filter.lfs = {
      #   clean = "git-lfs clean -- %f";
      #   smudge = "git-lfs smudge --skip -- %f";
      #   process = "git-lfs filter-process --skip ";
      #   required = "true";
      # };
      core.quotepath = false;
      pull.ff = "only";

      diff.tool = "difftastic";
      difftool.prompt = false;
      difftool.difftastic.cmd = ''difft "$LOCAL" "$REMOTE"'';
      pager.difftool = true;

      init.defaultBranch = "master";

      credential.helper = "manager";
      credential.credentialStore = "secretservice";
    };

    # };
  };
}
