cask "steelseries-gg" do
  version "27.1.0"
  sha256 "4345d68821c63bfff05f9054e489a3a695ce3874d5d0f921c55661e3dd6c6079"

  url "https://engine.steelseriescdn.com/SteelSeriesGG#{version}.pkg",
      verified: "engine.steelseriescdn.com/"
  name "SteelSeries GG #{version.major}"
  desc "Settings for SteelSeries peripherals and accessories"
  homepage "https://steelseries.com/gg"

  livecheck do
    url "https://techblog.steelseries.com"
    regex(/GG[._-]notes[._-]v?(\d+(?:\.\d+)+)\.html/i)
  end

  auto_updates true
  conflicts_with cask: "steelseries-engine"
  depends_on macos: ">= :sierra"

  pkg "SteelSeriesGG#{version}.pkg"

  uninstall launchctl: "com.steelseries.SSENext",
            quit:      [
              "com.steelseries.gg.client.*",
              "com.steelseries.gg.uninstaller",
              "com.steelseries.SteelSeries-GG",
            ],
            kext:      [
              "com.steelseries.ssenext.driver",
              "com.highpoint-tech.kext.HighPointIOP",
              "com.highpoint-tech.kext.HighPointRR",
            ],
            script:    [
              { executable: "/Applications/SteelSeries GG/SteelSeries GG Uninstaller.app/Contents/Resources/Uninstall.sh",
                sudo:       true },
            ],
            pkgutil:   "com.steelseries.*",
            delete:    "/Library/Application Support/SteelSeries GG"

  zap trash: [
    "~/Library/Application Support/steelseries-gg-client",
    "~/Library/Caches/com.steelseries.SteelSeries-GG",
    "~/Library/Preferences/com.steelseries.gg.client.plist",
    "~/Library/Preferences/com.steelseries.SteelSeries-GG.plist",
    "~/Library/Saved Application State/com.steelseries.gg.client.savedState",
    "~/Library/Saved Application State/com.steelseries.gg.uninstaller.savedState",
  ]
end
