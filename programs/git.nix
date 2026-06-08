{ pkgs, ... }:
{
  home.packages = [
    pkgs.difftastic
    pkgs.git-crypt
  ];
  programs.git.package = pkgs.git;
  programs.git = {
    enable = true;
    lfs.enable = true;
    lfs.skipSmudge = true;

    ignores = [
      ".direnv/"
      ".envrc"
      "mpl-pygls-lsp.log"
    ];

    settings = {
      alias = {
        st = "status -sb";
        ll = "log --oneline -n 10";
        cm = "commit -m";
        ca = "commit --amend";
        cma = "commit --amend";
        d = "diff --name-only --diff-filter=d";
        ch = "checkout";
        sw = "checkout -";
        rsw = "restore --staged --worktree";
        dft = "difftool";
        stash-diff = "stash show -p stash@{0}";
        ignore = "ls-files --others --exclude-standard --directory";
        touch = ''!f() { touch "$@" && git add "$@"; }; f'';
      };

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


    };
  };
}
