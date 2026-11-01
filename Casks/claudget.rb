cask "claudget" do
  arch arm: "arm64", intel: "x64"

  version "0.3.7"
  sha256 arm:   "454f6c35a39f90ad73447aa360ab3b3997b165055c2d196aba9d2617bbe467ca",
         intel: "0904048a7a27cf859708f1e129920bbd4f294c3143e8bdf3c987846b2f90db5e"

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
