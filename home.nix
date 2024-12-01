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

      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
      [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
      export EDITOR="emacs -nw"

      alias cookiepy="curl https://gist.githubusercontent.com/bengosney/461645e361892d14db112957ed771a49/raw/Makefile -o Makefile"

      if [ -f "$HOME/.cargo/env" ]; then
          source "$HOME/.cargo/env"
      fi
    '';

    shellAliases = {
      la = "ls -lah";
      update = "sudo apt-get update; sudo apt-get upgrade -y";
      off = "sudo shutdown -h now";
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
    extraConfig = {
      push = {
        autoSetupRemote = true;
      };
      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.emacs.enable = true;

  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
}
