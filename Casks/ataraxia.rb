cask "ataraxia" do
  version "0.16.0"
  sha256 "bdf285ed471419c2863afbfbbe5b769fd18a629e9e1133e4fb1779b8c07b7277"

  url "https://github.com/myrk-kale/ataraxia/releases/download/v#{version}/ataraxia-v#{version}-universal-apple-darwin.app.tar.gz"
  name "Ataraxia"
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"

  depends_on macos: ">= :big_sur"

  app "Ataraxia.app"

  # The app is not signed with an Apple Developer ID, so macOS would block the first launch of a
  # downloaded app. This tap builds and publishes it, so the quarantine mark is removed from it.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Ataraxia.app"]
  end

  zap trash: [
    "~/Library/Application Support/app.ataraxia.desktop",
    "~/Library/Caches/app.ataraxia.desktop",
    "~/Library/WebKit/app.ataraxia.desktop",
  ]
end
