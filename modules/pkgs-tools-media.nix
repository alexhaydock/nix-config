{pkgs, ...}: {
  users.users.user = {
    packages = with pkgs; [
      ffmpeg-headless
      ffmpegthumbnailer
      flac
      mpv
      yt-dlp
    ];
  };
}
