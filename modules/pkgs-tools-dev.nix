{pkgs, ...}: {
  users.users.user = {
    packages = with pkgs; [
      age
      age-plugin-yubikey
      ansible
      ansible-lint
      bat # Like cat, but cooler
      below
      bpftop
      conntrack-tools
      devenv # https://devenv.sh/
      diffoscope # Compare files to find out where they differ for Reproducible Build work
      direnv
      ghostscript # compress PDFs with: `gs -sDEVICE=pdfwrite -dPDFSETTINGS=/ebook -dNOPAUSE -dBATCH -sOutputFile=output.pdf input.pdf`
      gitsign # Chainguard's git signing program: https://docs.sigstore.dev/cosign/signing/gitsign/
      gnumake
      gnupg
      go
      hadolint
      iperf3
      just
      links2
      nmap
      opentofu
      pre-commit
      rpmextract
      sops # Secrets management: https://getsops.io/
      vhs # For creating shell recordings for documentation
      waypipe # Wayland session forwarding
      yamllint
    ];
  };
}
