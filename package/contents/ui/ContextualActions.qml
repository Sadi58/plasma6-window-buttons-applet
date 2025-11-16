/*
 * SPDX-FileCopyrightText: 2024 Anton Kharuzhy <publicantroids@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import QtQuick
import QtCore
import QtQuick.Dialogs
import QtQuick.Controls
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid

QtObject {
    property Item configManager: ConfigManager {
        onConfigLoaded: function (fileUrl, loadedConfig) {
            updatePlasmoidConfig(loadedConfig);
        }
    }

    Plasmoid.contextualActions: [
        PlasmaCore.Action {
            text: i18n("Ma&ximize")
            enabled: tasksModel.activeWindow.maximizable
            checked: tasksModel.activeWindow.maximized
            icon.name: "window-maximize"
            checkable: true
            onTriggered: tasksModel.activeWindow.actionCall(ActiveWindow.Action.Maximize)
        },
        PlasmaCore.Action {
            text: i18n("Mi&nimize")
            enabled: tasksModel.activeWindow.minimizable
            icon.name: "window-minimize"
            checkable: false
            onTriggered: tasksModel.activeWindow.actionCall(ActiveWindow.Action.Minimize)
        },
        PlasmaCore.Action {
            text: i18n("&Close")
            icon.name: "window-close"
            enabled: tasksModel.activeTask.closable
            checkable: false
            onTriggered: tasksModel.activeWindow.actionCall(ActiveWindow.Action.Close)
        },
        PlasmaCore.Action {
            text: i18n("&Export configuration...")
            icon.name: "document-export"
            checkable: false
            onTriggered: configManager.showConfigExportFileDialog()
        },
        PlasmaCore.Action {
            text: i18n("&Import configuration...")
            icon.name: "document-import"
            checkable: false
            onTriggered: configManager.showConfigImportFileDialog()
        }
    ]
}
