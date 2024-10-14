{ pkgs, ... }:

{
  home.username = "ben";
  home.homeDirectory = "/home/ben";

  home.stateVersion = "24.05";

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:~/.nix-profile/bin"

      ## Re-add deprecated autocomplete functions
      _have() {
          PATH=$PATH:/usr/sbin:/sbin:/usr/local/sbin type $1 &>/dev/null
      }
      have() {
          unset -v have
          _have $1 && have=yes
      }
    '';

    shellAliases = {
      la = "ls -lah";
    };
  };

  home.packages = with pkgs; [
    nerdfonts
    commitizen
    pre-commit
    direnv
    uv
    nixpkgs-fmt
  ];

  programs.starship = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Ben Gosney";
    userEmail = "bengosney@googlemail.com";
  };

  programs.emacs.enable = true;

  programs.home-manager.enable = true;
}
