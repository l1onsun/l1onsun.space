{
  pkgs,
  lpkgs,
  ...
}:

{
  home.packages = [
    (pkgs.symlinkJoin {
      name = "claude-code-proxied";
      paths = [ lpkgs.claude-code ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/claude \
          --set HTTPS_PROXY "http://127.0.0.1:3738" \
          --set HTTP_PROXY "http://127.0.0.1:3738"
      '';
    })
    (pkgs.writeShellScriptBin "claude-commit" ''
      DIFF=$(git diff --staged)
      LOG=$(git log -n 10 --pretty=format:"%h %s")
      claude -p "Create a git commit for files in stage. Use small, one line commit message.

      Recent commits (for style reference):
      $LOG

      Staged diff:
      $DIFF" \
        --model haiku \
        --allowed-tools "Bash(git:*)" "$@"
    '')
  ];
}
