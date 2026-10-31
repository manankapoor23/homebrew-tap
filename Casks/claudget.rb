cask "claudget" do
  arch arm: "arm64", intel: "x64"

  version "0.3.6"
  sha256 arm:   "d993b219c923146b4841392e793ba513484a9fc195be350ed0d0ece7ebc8f481",
         intel: "e0bc6c41b9bd95645b39513cb53d6d05887d8f583ac46a68525582a76f02e71e"

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
