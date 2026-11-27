# Rendered by spider-shield scripts/package-manifests.sh from the release's SHA256SUMS; bump with scripts/bump-cask.sh.
cask "spider-shield" do
  version "0.1.22"
  sha256 "06ca77159b35a1bd993fa02deffd4b13aa7a5389ddf450715d2104a4d4e42bd6"

  url "https://api.spider.cloud/data/download/shield/macos?version=#{version}&utm_source=homebrew"
  name "Spider Shield"
  desc "Blocks ads and trackers. Shield is free because it shares your connection"
  homepage "https://spider.cloud/shield"

  livecheck do
    url "https://api.spider.cloud/data/shield/releases"
    strategy :json do |json|
      json["version"]
    end
  end

  auto_updates true
  depends_on :macos

  app "Spider Shield.app"

  # The app installs a root LaunchDaemon that repoints the system resolver at
  # itself. `--uninstall-service` restores the saved DNS servers before it
  # removes the daemon, so it has to run first. The daemon keeps that state
  # under root's data dir, hence HOME=/var/root.
  uninstall early_script: {
              executable:   "/usr/bin/env",
              args:         ["HOME=/var/root", "/usr/local/bin/shield_daemon", "--uninstall-service"],
              sudo:         true,
              must_succeed: false,
            },
            launchctl:    [
              "com.spidercloud.shield",
              "Spider Shield",
            ],
            quit:         "com.spidercloud.shield",
            delete:       [
              "/Library/LaunchDaemons/com.spidercloud.shield.plist",
              "/usr/local/bin/shield_daemon",
              "/var/run/spider-shield.sock",
            ]

  zap delete: [
        "/Library/Logs/SpiderShield",
        "/var/root/Library/Application Support/SpiderShield",
      ],
      trash:  [
        "~/.spider-shield",
        "~/Library/Application Support/com.spidercloud.shield",
        "~/Library/Application Support/SpiderShield",
        "~/Library/Caches/com.spidercloud.shield",
        "~/Library/LaunchAgents/Spider Shield.plist",
        "~/Library/Preferences/com.spidercloud.shield.plist",
        "~/Library/Saved Application State/com.spidercloud.shield.savedState",
        "~/Library/WebKit/com.spidercloud.shield",
      ]

  caveats "Shield is free because it shares your connection. Terms: https://spider.cloud/shield/terms/"
end
