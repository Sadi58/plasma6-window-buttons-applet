# Window Buttons Applet

[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)
![GitHub Release](https://img.shields.io/github/v/release/antroids/application-title-bar)

This is a Plasma 6 applet that shows window buttons in your panels.
This plasmoid is forked from [![Application Title Bar](https://github.com/antroids/application-title-bar)] to create a variant that includes window buttons only to mimick the Plasma 5 **Window Buttons** applet by [![psifidos](https://github.com/psifidotos)].  

### NOTE: Plasma 6.3 - 6.3.3 Compatibility issues
A Drag action handler does not work properly on Plasma 6.3 - 6.3.3 with ButtonsRebind KWin plugin enabled.
The plugin can be disabled with the following command:
```bash
kwriteconfig6 --file ~/.config/kwinrc --group Plugins --key buttonsrebindEnabled false && qdbus6 org.kde.KWin /Plugins UnloadPlugin "buttonsrebind"
```
The names of `kwriteconfig6` and `qdbus6` utilities can be different for your distribution.

To enable the plugin again:
```bash
kwriteconfig6 --file ~/.config/kwinrc --group Plugins --key buttonsrebindEnabled true && qdbus6 org.kde.KWin /Plugins LoadPlugin "buttonsrebind"
```

## Description

KDE plasmoid compatible with Qt6 with window buttons only.

<img src="docs/img/AllInOne.png" />

### Goal

Stable and fast widget with control buttons only, ideally with the same functionality as Unity panel.
Using pure QML to avoid incompatibility and maintenance issues.

Disadvantages of pure QML widget:
* Only icons can be used from Aurorae themes, the rest is ignored. Binary themes are unsupported at all (Issues [#18](https://github.com/antroids/application-title-bar/issues/18), [#6](https://github.com/antroids/application-title-bar/issues/6)).

### Features

* Close, minimize, maximize, keep below/above buttons.
* Configure actions on mouse events.
* Configurable elements set and order.
* Different theming options. Internal Breeze icons, System icons and Aurorae theme.
* Configurable layout and geometry.
* Click and drag widget to reposition window (as if you'd dragged the window's integrated title bar)

## Installing

1. Bash script
    - Update: `wget https://github.com/sadi58/plasma6-window-buttons-applet/releases/latest/download/plasma6-window-buttons-applet.plasmoid -O ${TMPDIR:-/tmp}/plasma6-window-buttons-applet.plasmoid && kpackagetool6 -t Plasma/Applet -u ${TMPDIR:-/tmp}/plasma6-window-buttons-applet.plasmoid && systemctl --user restart plasma-plasmashell.service`

    - Install `wget https://github.com/sadi58/plasma6-window-buttons-applet/releases/latest/download/plasma6-window-buttons-applet.plasmoid -O ${TMPDIR:-/tmp}/plasma6-window-buttons-applet.plasmoid && kpackagetool6 -t Plasma/Applet -i ${TMPDIR:-/tmp}/plasma6-window-buttons-applet.plasmoid && systemctl --user restart plasma-plasmashell.service`

2. Manual with Plasma UI
    - Install via "Add Widgets..." -> "Get New Widgets..." -> "Download..."
    - Install from [KDE Store](https://store.kde.org/p/???????)
    - Download Latest \*.plasmoid from [Releases page](https://github.com/sadi58/plasma6-window-buttons-applet/releases) and install it via "Add Widgets..." -> "Get New Widgets..." -> "Install Widget From Local file"

3. Nix (needs Nixpkgs unstable 24.11 or later)

    On NixOS:
    ```nix
    environment.systemPackages = with pkgs; [
        plasma6-window-buttons-applet
    ];
    ```
   Other distros:
   ```
   # without flakes:
   nix-env -iA nixpkgs.plasma6-window-buttons-applet
   # with flakes:
   nix profile install nixpkgs#plasma6-window-buttons-applet
   ```
### Additional packages

- Debian, Ubuntu, Kali Linux, Raspbian: `apt-get install qdbus`
- Alpine: `apk add qt5-qttools`
- Arch Linux: `pacman -S qdbus-qt5`
- CentOS: `yum install qdbus-qt5`
- Fedora: `dnf install qt5-qttools`

## 🆘 In cases of panel freezes or crashes 🆘

Although the widget is being used by me and a lot of other people, there is still a chance that it would be incompatible with your OS distribution. The worst that can happen is some Binding loop that can freeze your Plasma panel.

In such cases you can use the following script to downgrade the panel version:
`
wget https://github.com/sadi58/plasma6-window-buttons-applet/releases/download/v0.6.8/plasma6-window-buttons-applet.plasmoid -O ${TMPDIR:-/tmp}/plasma6-window-buttons-applet.plasmoid && kpackagetool6 -t Plasma/Applet -u ${TMPDIR:-/tmp}/plasma6-window-buttons-applet.plasmoid && systemctl --user restart plasma-plasmashell.service
`

Or you can remove the widget: `kpackagetool6 --type Plasma/Applet --remove com.github.sadi58.plasma6-window-buttons-applet`

Please, don't forget to fill the report about the issues.

## License

This project is licensed under the GPL-3.0-or-later License - see the LICENSE.md file for details

## Contributing

Pull requests and Issue reports are always welcome.
