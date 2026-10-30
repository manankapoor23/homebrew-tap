# manankapoor23/homebrew-tap

Homebrew casks for [claudget](https://github.com/manankapoor23/claudget), which shows your Claude Code usage and plan limits in the menu bar.

```bash
brew trust manankapoor23/tap
brew install --cask manankapoor23/tap/claudget
```

Homebrew 7 and later only load casks from third-party taps you've trusted, which is what the first line does. On an older Homebrew, skip it.

Update with `brew upgrade --cask claudget`. Uninstall with `brew uninstall --cask claudget`, or use `brew uninstall --zap --cask claudget` to remove its settings and history too.

claudget is free and open source. It's ad-hoc signed but not notarized, because that needs a paid Apple certificate. The cask removes the quarantine flag after installing, which is the same `xattr` step the [claudget README](https://github.com/manankapoor23/claudget#download--install) asks you to run by hand. Without it, macOS would refuse to open the app.

The cask is updated automatically when a claudget release is published.
