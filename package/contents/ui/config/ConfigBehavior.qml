/*
 * SPDX-FileCopyrightText: 2024 Anton Kharuzhy <publicantroids@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import "../"
import "../utils.js" as Utils
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents

KCM.SimpleKCM {
    id: page

    property alias cfg_widgetActiveTaskSource: widgetActiveTaskSource.currentIndex
    property alias cfg_widgetActiveTaskFilterByActivity: widgetActiveTaskFilterByActivity.checked
    property alias cfg_widgetActiveTaskFilterByScreen: widgetActiveTaskFilterByScreen.checked
    property alias cfg_widgetActiveTaskFilterByVirtualDesktop: widgetActiveTaskFilterByVirtualDesktop.checked
    property alias cfg_widgetActiveTaskFilterNotMaximized: widgetActiveTaskFilterNotMaximized.checked
    property alias cfg_disableButtonsForNotHoveredWidget: disableButtonsForNotHoveredWidget.checked

    Kirigami.FormLayout {
        anchors.left: parent.left
        anchors.right: parent.right

        KWinConfig {
            id: kWinConfig

            onBorderlessMaximizedWindowsChanged: {
                borderlessMaximizedWindowsCheckBox.checked = borderlessMaximizedWindows;
                borderlessMaximizedWindowsCheckBox.enabled = kWinConfig.kwriteconfigCommandName !== "" && kWinConfig.kreadconfigCommandName !== "";
            }
        }

        Kirigami.InlineMessage {
            anchors.left: parent.left
            anchors.right: parent.right
            text: i18n("Some functionality is unsupported or can work unstable in X11 sessions.")
            type: Kirigami.MessageType.Warning
            visible: Utils.isX11()
        }

        Kirigami.InlineMessage {
            anchors.left: parent.left
            anchors.right: parent.right
            text: "QDbus command is missing in the system!"
            type: Kirigami.MessageType.Error
            visible: kWinConfig.qdbusCommandName === ""
        }

        Kirigami.InlineMessage {
            anchors.left: parent.left
            anchors.right: parent.right
            text: "Kwriteconfig command is missing in the system!"
            type: Kirigami.MessageType.Error
            visible: kWinConfig.kwriteconfigCommandName === ""
        }

        Kirigami.InlineMessage {
            anchors.left: parent.left
            anchors.right: parent.right
            text: "Kreadconfig command is missing in the system!"
            type: Kirigami.MessageType.Error
            visible: kWinConfig.kreadconfigCommandName === ""
        }

        Kirigami.InlineMessage {
            anchors.left: parent.left
            anchors.right: parent.right
            text: kWinConfig.lastError
            type: Kirigami.MessageType.Error
            visible: kWinConfig.lastError !== ""
        }

        RowLayout {
            Kirigami.FormData.label: i18n("Active task source:")

            ComboBox {
                id: widgetActiveTaskSource

                model: [i18n("Active task"), i18n("Last active task"), i18n("Last active maximized task")]
            }

            KCM.ContextualHelpButton {
                toolTipText: i18n("<p>How to obtain the active task from tasks manager: <br><b>Active task</b>: current active task after filtering. The widget will be disabled if the current active task is on another screen, regardless whether there are another tasks on this screen or not.<br/><b>Last active task</b>: show widget for the last active task after filters applied.<br/><b>Last active maximized task</b>: show widget for the last active maximized task after filters applied.</p>")
            }
        }

        CheckBox {
            id: borderlessMaximizedWindowsCheckBox

            Kirigami.FormData.label: i18n("Borderless maximized windows:")
            text: i18n("enabled (Will be applied immediately)")
            enabled: false
            onToggled: function () {
                enabled = false;
                kWinConfig.setBorderlessMaximizedWindows(checked);
            }
        }

        CheckBox {
            id: widgetActiveTaskFilterByActivity

            Kirigami.FormData.label: i18n("Filter active task by activity:")
            text: i18n("enabled")
        }

        CheckBox {
            id: widgetActiveTaskFilterByScreen

            Kirigami.FormData.label: i18n("Filter active task by screen:")
            text: i18n("enabled")
        }

        CheckBox {
            id: widgetActiveTaskFilterByVirtualDesktop

            Kirigami.FormData.label: i18n("Filter active task by virtual desktop:")
            text: i18n("enabled")
        }

        CheckBox {
            id: widgetActiveTaskFilterNotMaximized

            enabled: widgetActiveTaskSource.currentIndex !== ActiveTasksModel.ActiveTaskSource.LastActiveMaximized
            Kirigami.FormData.label: i18n("Disable for not maximized:")
            text: i18n("enabled")
        }

        CheckBox {
            id: disableButtonsForNotHoveredWidget

            Kirigami.FormData.label: i18n("Disable buttons for not hovered widget:")
            text: i18n("enabled")
        }
    }
}
