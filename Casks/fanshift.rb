cask "fanshift" do
  version "0.1.0"
  sha256 "6a885dddc6833febefad281a1bc32b5d5e1300f383bb7b026759f1e2484fbff1"

  url "https://github.com/KrisWonka/FanShift/releases/download/v#{version}/FanShift-#{version}.zip"
  name "FanShift"
  desc "Menu bar fan control with a global hotkey and custom fan curves"
  homepage "https://github.com/KrisWonka/FanShift"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "FanShift.app"

  # FanShift is not notarized yet, so remove the quarantine flag; otherwise macOS blocks the first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/FanShift.app"]
  end

  uninstall quit:      "com.kriswonka.fanshift",
            launchctl: [
              "com.kriswonka.fanshift.autostart",
              "com.kriswonka.fanshift.daemon",
            ],
            delete:    [
              "/Library/LaunchDaemons/com.kriswonka.fanshift.daemon.plist",
              "/Library/PrivilegedHelperTools/com.kriswonka.fanshift.daemon",
            ]

  zap trash: [
    "~/Library/Application Support/FanShift",
    "~/Library/LaunchAgents/com.kriswonka.fanshift.autostart.plist",
    "~/Library/Preferences/com.kriswonka.fanshift.plist",
  ]
end
