cask "claudget" do
  arch arm: "arm64", intel: "x64"

  version "0.3.3"
  sha256 arm:   "6be19808ad510a739fb7ffb7f36101c12086c52a1080c2150fc95ed1bca8e39f",
         intel: "47be6a9386cd6d7b0afcf97352fe798b0a66187b80852e6ab39bf3a39c5ab0a6"

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
