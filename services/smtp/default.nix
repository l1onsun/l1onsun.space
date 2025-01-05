{ inputs, ... }: {
  imports = [
    inputs.simple-nixos-mailserver.nixosModule
  ];

  mailserver = {
    enable = true;
    fqdn = "mail.cherezov.xyz";
    domains = [ "cherezov.xyz" ];

    # A list of all login accounts. To create the password hashes, use
    # nix-shell -p mkpasswd --run 'mkpasswd -sm bcrypt'
    loginAccounts = {
      "ilya@cherezov.xyz" = {
        hashedPasswordFile = ./mail.ilya.pwd;
        aliases = ["postmaster@cherezov.xyz"];
      };
      # "user2@cherezov.xyz" = { ... };
    };

    # Use Let's Encrypt certificates. Note that this needs to set up a stripped
    # down nginx and opens port 80.
    # certificateScheme = "acme-nginx";
  };
  security.acme.acceptTerms = true;
  security.acme.defaults.email = "security@cherezov.xyz";
}
