/*
 * SPDX-FileCopyrightText: 2024 Anton Kharuzhy <publicantroids@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import QtQuick

QtObject {
    enum Type {
        WindowControlButton,
        Spacer
    }
    enum DisabledMode {
        Deactivated,
        HideKeepSpace,
        Hide
    }
}
