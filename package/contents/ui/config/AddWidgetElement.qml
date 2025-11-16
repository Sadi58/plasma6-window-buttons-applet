/*
 * SPDX-FileCopyrightText: 2024 Anton Kharuzhy <publicantroids@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import QtQuick
import QtQuick.Controls
import org.kde.kirigami as Kirigami

ComboBox {
    textRole: "name"
    valueRole: "value"
    displayText: currentText ? i18n(currentText) : ""

    model: ListModel {
        ListElement {
            name: "Add button..."
        }

        ListElement {
            name: "Window close button"
            value: "windowCloseButton"
        }

        ListElement {
            name: "Window minimize button"
            value: "windowMinimizeButton"
        }

        ListElement {
            name: "Window maximize button"
            value: "windowMaximizeButton"
        }

        ListElement {
            name: "Spacer"
            value: "spacer"
        }
    }
}
