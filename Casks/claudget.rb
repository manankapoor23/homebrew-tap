cask "claudget" do
  arch arm: "arm64", intel: "x64"

  version "0.3.8"
  sha256 arm:   "2025425caf0b3f7c061d0692820f7b9df09f515a3415de27a4aaeb8d0936a4fd",
         intel: "01cca7a652da71737955098502e0c7fa6fcb080578e50399683cfb1821d0779d"

  url "https://github.com/manankapoor23/claudget/releases/download/v#{version}/claudget-#{version}-#{arch}.dmg"
  name "claudget"
  desc "Claude Code usage and plan limits in the menu bar"
  homepage "https://claudget.vercel.app/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "claudget.app"

  # claudget is ad-hoc signed, not notarized (no paid Apple certificate), so
  # macOS would refuse the first open. This is the same step the README asks
  # you to run by hand: https://github.com/manankapoor23/claudget#download--install
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/claudget.app"]
  end

  uninstall quit: "com.claudget.app"

  zap trash: [
    "~/Library/Application Support/@claude-widget",
    "~/Library/Preferences/com.claudget.app.plist",
    "~/Library/Saved Application State/com.claudget.app.savedState",
  ]
end
