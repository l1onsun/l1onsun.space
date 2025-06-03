{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    profiles.default.extensions = [
      pkgs.vscode-extensions.mvllow.rose-pine
      pkgs.vscode-extensions.mkhl.direnv
      pkgs.vscode-extensions.vscodevim.vim
      # (pkgs.vscode-utils.buildVscodeExtension {
      #   name = "helix-local";
      #   pname = "helix-local-0.0.1";
      #   version = "0.0.1";
      #   src = ./extensions/vscode-helix-emulation-0.6.3.zip;

      #   vscodeExtPublisher = "l1onsun";
      #   vscodeExtName = "helix-local";
      #   vscodeExtUniqueId = "l1onsun.helix-local";
      # })
      # (pkgs.vscode-utils.extensionFromVscodeMarketplace {
      #   name = "dance";
      #   publisher = "gregoire";
      #   version = "latest";
      #   sha256 = "sha256-gGTpeOQeIQj2ObyC6504+lzLFUS35RNw5z2/isPRpyM=";
      # })
    ];
  };
}
