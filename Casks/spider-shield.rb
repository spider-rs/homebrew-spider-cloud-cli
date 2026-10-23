cask "spider-shield" do
  version "0.1.16"
  sha256 "d4f2ad36e44c93ee6b0b2ae4ce4fcb6a87029632bc9fb3062480e635a5669b44"

  url "https://api.spider.cloud/data/download/shield/macos?version=#{version}&utm_source=homebrew"
  name "Spider Shield"
  desc "System-wide firewall that blocks ads, trackers, malware and phishing"
  homepage "https://spider.cloud/shield"

  livecheck do
    url "https://api.spider.cloud/data/shield/releases"
    strategy :json do |json|
      json["version"]
    end
  end

  auto_updates true
  depends_on macos: ">= :catalina"

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
end
