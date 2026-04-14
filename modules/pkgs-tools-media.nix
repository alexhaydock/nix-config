{pkgs, ...}: {
  users.users.user = {
    packages = with pkgs; [
      ffmpeg-headless
      ffmpegthumbnailer
      flac
      mediainfo
      mpv
      sox # Spectrogram generation
      yt-dlp
    ];
  };
}
