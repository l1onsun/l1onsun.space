{ pkgs, lib, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "rsync-to" ''
      if [ $# -eq 0 ]; then
        echo "Usage: rsync-to user@host:/path/to/destination"
        exit 1
      fi

      DEST="$1"
      ${lib.getExe pkgs.rsync} -avzP --delete --exclude='.git' . "$DEST"
    '')

    (pkgs.writeShellScriptBin "rsync-from" ''
      if [ $# -eq 0 ]; then
        echo "Usage: rsync-from user@host:/path/to/source"
        exit 1
      fi

      SRC="$1"
      ${lib.getExe pkgs.rsync} -avzP --exclude='.git' "$SRC/" .
    '')

    (pkgs.writeShellScriptBin "rsy" ''
      if [ $# -ne 2 ]; then
        echo "Usage: rsync user@host:/path/to/source /local/destination"
        exit 1
      fi

      SRC="$1"
      DST="$2"
      ${lib.getExe pkgs.rsync} -avzP --exclude='.git' "$SRC" "$DST"
    '')

    (pkgs.writeShellScriptBin "mimo" ''
      ${lib.getExe pkgs.aichat} --model mimo:mimo-v2.5 "$@"
    '')

    (pkgs.writeShellScriptBin "mimo-pro" ''
      ${lib.getExe pkgs.aichat} --model mimo:mimo-v2.5-pro "$@"
    '')

    (pkgs.writeShellScriptBin "ab" (builtins.readFile ../utils/ab.sh))

    (pkgs.writeShellScriptBin "ii" ''
      env -i TERM="$TERM" PATH="$PATH" II_ARGS="$*" su -p - agentEcho
    '')

    (pkgs.writeShellScriptBin "myip" ''
      ip route get 1.1.1.1 | awk '{for(i=1;i<=NF;i++) if($i=="src") print $(i+1)}'
    '')

    (pkgs.writeShellScriptBin "pro" ''
      if [ $# -eq 0 ]; then
        echo "Usage: pro <command> [args...]"
        exit 1
      fi

      ALL_PROXY=socks5://localhost:3737 \
      HTTP_PROXY=http://localhost:3738 \
      HTTPS_PROXY=http://localhost:3738 \
        "$@"
    '')
  ];
}
