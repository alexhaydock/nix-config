{pkgs, ...}: {
  users.users.user = {
    packages = with pkgs; [
      ansible
      ansible-lint
      bat # Like cat, but cooler
      below
      bitwarden-desktop
      bpftop
      chromium
      conntrack-tools
      devenv # https://devenv.sh/
      diffoscope # Compare files to find out where they differ for Reproducible Build work
      direnv
      easytag # GUI based audio file tagger
      element-desktop
      feishin # Navidrome client
      ffmpeg
      file # provides `file`
      flac
      ghostscript # compress PDFs with: `gs -sDEVICE=pdfwrite -dPDFSETTINGS=/ebook -dNOPAUSE -dBATCH -sOutputFile=output.pdf input.pdf`
      gimp
      gitsign # Chainguard's git signing program: https://docs.sigstore.dev/cosign/signing/gitsign/
      gnupg
      hadolint
      hyfetch
      iperf3
      just
      keepassxc
      libreoffice
      links2
      mpv
      nyancat
      obsidian
      opentofu
      optipng
      pciutils # lspci
      pre-commit
      psmisc # provides fuser, killall, pstree, etc
      rpi-imager
      rpmextract
      signal-desktop
      socat
      sshfs
      usbutils # lsusb
      vhs # For creating shell recordings for documentation
      wget
      yamllint
      yt-dlp
    ];
  };
}
