/*
 * SPDX-FileCopyrightText: 2024 Anton Kharuzhy <publicantroids@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import "../../"
import "../../config"
import "../../config/effect"
import "../../common"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

RowLayout {
    id: root

    readonly property list<string> argumentFragments: ["ActiveWindowFlagCondition"]

    property RuleModel ruleModel: RuleModel {}
    required property JsonListModel effects
    signal rowRemoved

    ComboBox {
        Kirigami.FormData.label: i18n("Effect:")
        model: effects
        currentIndex: ruleModel.effectIndex
        textRole: "name"
        wheelEnabled: false
        onActivated: function (index) {
            ruleModel.effectIndex = index;
        }
    }

    Label {
        Kirigami.FormData.label: i18n("Type:")
        text: i18n("Flag")
        Layout.preferredWidth: Kirigami.Units.gridUnit * 4
    }

    Loader {
        id: argumentFragmentLoader
        Layout.fillWidth: true
        source: argumentFragments[0] + ".qml"

        Binding {
            when: argumentFragmentLoaderConnections.enabled
            target: argumentFragmentLoader.item
            property: "arg0"
            value: ruleModel.arg0
            delayed: true
        }

        Binding {
            when: argumentFragmentLoaderConnections.enabled
            target: argumentFragmentLoader.item
            property: "arg1"
            value: ruleModel.arg1
            delayed: true
        }

        Connections {
            id: argumentFragmentLoaderConnections

            enabled: argumentFragmentLoader.status === Loader.Ready
            target: argumentFragmentLoader.item
            function onArg0Updated(val) {
                ruleModel.arg0 = val;
            }
            function onArg1Updated(val) {
                ruleModel.arg1 = val;
            }
        }
    }

    Button {
        icon.name: "delete"
        onClicked: function () {
            root.rowRemoved();
        }
    }
}
