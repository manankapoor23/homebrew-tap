cask "claudget" do
  arch arm: "arm64", intel: "x64"

  version "0.3.9"
  sha256 arm:   "5eec9ed25abe9cc092963d9d1a5d05e6dc13a580c0ef3ec94d8cb89e535a213b",
         intel: "afa09622658f75e67dec440be4392df302125a9639e8759a96c8743a0c95745f"

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
