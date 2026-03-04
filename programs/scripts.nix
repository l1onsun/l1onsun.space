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
  ];
}
