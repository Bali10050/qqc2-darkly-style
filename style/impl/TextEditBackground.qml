/* SPDX-FileCopyrightText: 2020 Noah Davis <noahadvs@gmail.com>
 * SPDX-License-Identifier: LGPL-2.1-only OR LGPL-3.0-only OR LicenseRef-KDE-Accepted-LGPL
 */

import QtQuick
import Qt5Compat.GraphicalEffects
import QtQuick.Templates as T
import org.kde.kirigami as Kirigami

import "." as Impl

Impl.StandardRectangle {
    id: root

    property Item control: root.parent
    property bool visualFocus: control.activeFocus && (
        control.focusReason == Qt.TabFocusReason ||
        control.focusReason == Qt.BacktabFocusReason ||
        control.focusReason == Qt.ShortcutFocusReason
    )

    property bool highlightBackground: control.down || control.checked
    property bool highlightBorder: control.enabled && (control.down || control.checked || control.highlighted || control.visualFocus || control.hovered)

    implicitWidth: implicitHeight
    implicitHeight: Impl.Units.smallControlHeight

    color: Kirigami.Theme.backgroundColor
    radius: Impl.Units.smallRadius/*
    border {
        color: control.activeFocus || control.hovered ?
            Kirigami.Theme.focusColor : Impl.Theme.buttonSeparatorColor()
        width: Impl.Units.smallBorder
    }*/

    FocusRect {
        visible: root.visualFocus
        baseRadius: parent.radius
    }

    Behavior on border.color {
        enabled: control.activeFocus || control.hovered
        ColorAnimation {
            duration: Kirigami.Units.shortDuration
            easing.type: Easing.OutCubic
        }
    }/*
    Rectangle {
        anchors.fill: parent
        color: {
            if (highlightBackground) {
                return Kirigami.Theme.alternateBackgroundColor
            } else if (control.flat) {
                return flatColor
            } else if (hovered){return Impl.Theme.separatorColor()} else {
                return Kirigami.Theme.backgroundColor
            }
        }
        anchors.rightMargin: 0
        anchors.topMargin: -1
        anchors.bottomMargin: 3
        border.width: 2
        border.color:Impl.Theme.separatorColor()
        radius: Impl.Units.smallRadius
    }*/
    Rectangle {
        anchors.fill: parent
        id: butterfly
        color: {
            if (highlightBackground) {
                return Kirigami.Theme.alternateBackgroundColor
            } else if (control.flat) {
                return flatColor
            } /*else if (hovered){return Impl.Theme.separatorColor()} */else {
                return Kirigami.Theme.backgroundColor
            }
        }
        anchors.rightMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        border.width: 2
        border.color: {
            if (control.activeFocus) {
                return Kirigami.Theme.focusColor
            } else if (control.flat) {
                return flatColor
            } else {
                return Kirigami.Theme.backgroundColor
            }
        }
        radius: Impl.Units.smallRadius
    }
    DropShadow {
        anchors.fill: parent
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "#20000000"
        source: butterfly
    }
}
