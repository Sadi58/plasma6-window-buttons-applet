/*
 * SPDX-FileCopyrightText: 2024 Anton Kharuzhy <publicantroids@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

const CONDITION_ACTIVE_WINDOW_FLAG = 0;

class Condition {
    constructor(effectIndex) {
        this.effectIndex = effectIndex;
    }

    checkCondition(_widget) {
        throw new Error("Not implemented");
    }

    static fromModel(model) {
        switch (model.conditionType) {
            case CONDITION_ACTIVE_WINDOW_FLAG:
                return new ActiveWindowFlagCondition(model.effectIndex, model.arg0, !!model.arg1);
            default:
                throw new Error("Unsupported condition type: " + model.conditionType);
        }
    }
}

class ActiveWindowCondition extends Condition {
    constructor(effectIndex) {
        super(effectIndex);
    }

    checkCondition(widget) {
        return widget.tasksModel.hasActiveWindow && this.checkActiveWindowCondition(widget.tasksModel.activeWindow);
    }

    checkActiveWindowCondition(_activeWindow) {
        throw new Error("Not implemented");
    }
}

class ActiveWindowFlagCondition extends ActiveWindowCondition {
    constructor(effectIndex, propertyName, propertyValue) {
        super(effectIndex);
        this.propertyName = propertyName;
        this.propertyValue = propertyValue;
    }

    checkActiveWindowCondition(activeWindow) {
        return activeWindow[this.propertyName] === this.propertyValue;
    }
}
