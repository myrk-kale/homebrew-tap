cask "ataraxia" do
  version "0.23.1"
  sha256 "dd57232c3df187f8c270e03afb1e0973a4a081f403fd7e008b02f2a6e7d6b6f0"

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
