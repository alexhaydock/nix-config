{home-manager, ...}: {
  # Configure Git config for root (so that root can commit to /etc/nixos)
  home-manager.users.root = {pkgs, ...}: {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Alex Haydock";
          email = "alex@alexhaydock.co.uk";
        };
      };
    };

    # Configure SSH to use the Git key
    #
    # Copy this into position with:
    #   sudo cp -fv /home/user/.ssh/id_ed25519_Git /root/.ssh/id_ed25519_Git
    programs.ssh = {
      enable = true;
      matchBlocks = {
        "github.com" = {
          identityFile = "/root/.ssh/id_ed25519_Git";
        };
      };
    };
  };

  # Configure Git config for regular user
  home-manager.users.user = {pkgs, ...}: {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Alex Haydock";
          email = "alex@alexhaydock.co.uk";
          signingkey = "4C1B4DC797D244ED0CE5E68F991B5784CC0F0336";
        };
        commit = {
          gpgsign = "true";
          verbose = "true";
        };
        core = {
          autocrlf = "input";
          compression = "9";
          whitespace = "trailing-space";
        };
        branch = {
          sort = "-committerdate";
        };
        tag = {
          forceSignAnnotated = "true";
          sort = "-version:refname";
        };
        column = {
          ui = "auto";
        };
        diff = {
          algorithm = "histogram";
        };
        fetch = {
          prune = "true";
        };
        pull = {
          rebase = "true";
        };
        rebase = {
          missingCommitsCheck = "warn";
          autosquash = "true";
        };
        init = {
          defaultBranch = "main";
        };
        push = {
          autoSetupRemote = "true";
        };
        status = {
          branch = "true";
          showStash = "true";
        };
        maintenance = {
          auto = "true";
          strategy = "incremental";
        };
        rerere = {
          enabled = "true";
        };
        help = {
          autocorrect = "prompt";
        };
      };
    };
  };
}
