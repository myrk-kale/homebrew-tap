cask "ataraxia" do
  version "0.27.0"
  sha256 "f1d93fa6814f9917ea926492a949d9a1861ec0a4ec9ff583126f2a111b5ea369"

  url "https://github.com/myrk-kale/ataraxia/releases/download/v#{version}/ataraxia-v#{version}-universal-apple-darwin.app.tar.gz"
  name "Ataraxia"
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"

  # No minimum version: the app needs macOS 11, and Homebrew itself does not run on anything older.
  depends_on :macos

  app "Ataraxia.app"

  # The app is not signed with an Apple Developer ID, so macOS would block the first launch of a
  # downloaded app. This tap builds and publishes it, so the quarantine mark is removed from it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Ataraxia.app"]
  end

  zap trash: [
    "~/Library/Application Support/app.ataraxia.desktop",
    "~/Library/Caches/app.ataraxia.desktop",
    "~/Library/WebKit/app.ataraxia.desktop",
  ]
end
