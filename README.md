# homebrew-spider-cloud-cli
## Install

```sh
brew tap spider-rs/spider-cloud-cli
brew install spider-cloud-cli        # the Spider Cloud CLI
brew install --cask spider-shield    # Spider Shield, the macOS firewall app
```

Removing the cask with `brew uninstall --cask spider-shield` restores the system DNS servers and removes the root daemon. `--zap` also deletes settings and logs.
