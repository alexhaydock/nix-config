{home-manager, ...}: {
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
        # Use GitHub via SSH
        url = {
          "git@github.com:" = {
            insteadOf = [
              "https://github.com/"
              "gh:"
              "github:"
            ];
          };
        };
      };
    };
  };
}
