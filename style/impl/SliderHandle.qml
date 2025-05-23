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

    property T.Control control: root.parent
    property real position: control.position
    property real visualPosition: control.visualPosition
    property bool hovered: control.hovered
    property bool pressed: control.pressed
    property bool visualFocus: control.visualFocus

    property bool usePreciseHandle: false

    implicitWidth: implicitHeight
    implicitHeight: Impl.Units.inlineControlHeight

    // It's not necessary here. Not sure if it would swap leftPadding with
    // rightPadding in the x position calculation, but there's no risk to
    // being safe here.
    LayoutMirroring.enabled: false

    // It's necessary to use x and y positions instead of anchors so that the handle position can be dragged
    x: {
        let xPos = 0
        if (control.horizontal) {
            xPos = root.visualPosition * (control.availableWidth - width)
        } else {
            xPos = (control.availableWidth - width) / 2
        }
        return xPos + control.leftPadding
    }
    y: {
        let yPos = 0
        if (control.vertical) {
            yPos = root.visualPosition * (control.availableHeight - height)
        } else {
            yPos = (control.availableHeight - height) / 2
        }
        return yPos + control.topPadding
    }

    rotation: root.vertical && usePreciseHandle ? -90 : 0

    radius: height / 2

    color: Kirigami.Theme.backgroundColor/*
    border {
        width: Impl.Units.smallBorder
        color: root.pressed || root.visualFocus || root.hovered ? Kirigami.Theme.focusColor : Impl.Theme.separatorColor()
    }*/
    Rectangle {
        id: butterfly
        anchors.fill: parent
        color: root.pressed || root.visualFocus || root.hovered ? Kirigami.Theme.focusColor : Kirigami.Theme.backgroundColor
        anchors.rightMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        border.width: 2
        border.color: root.pressed || root.visualFocus || root.hovered ? Kirigami.Theme.focusColor : Kirigami.Theme.backgroundColor
        radius: height / 2
        antialiasing: true
    }

    Rectangle {
        anchors.fill: parent
        color: Kirigami.Theme.backgroundColor
        anchors.rightMargin: 0
        anchors.topMargin: -1
        anchors.bottomMargin: 0
        border.width: 2
        border.color:Impl.Theme.separatorColor()
        radius: height / 2
        antialiasing: true
    }

    Behavior on border.color {
        enabled: root.pressed || root.visualFocus || root.hovered
        ColorAnimation {
            duration: Kirigami.Units.shortDuration
            easing.type: Easing.OutCubic
        }
    }
    DropShadow {
        anchors.fill: parent
        horizontalOffset: 0
        verticalOffset: 3
        radius: 3.0
        samples: 6
        color: "#20000000"
        source: butterfly
    }

    Behavior on x {
        enabled: root.loaded && !Kirigami.Settings.hasTransientTouchInput
        SmoothedAnimation {
            duration: Kirigami.Units.longDuration
            velocity: 800
            //SmoothedAnimations have a hardcoded InOutQuad easing
        }
    }
    Behavior on y {
        enabled: root.loaded && !Kirigami.Settings.hasTransientTouchInput
        SmoothedAnimation {
            duration: Kirigami.Units.longDuration
            velocity: 800
        }
    }

    SmallBoxShadow {
        id: shadow
        opacity: root.pressed ? 0 : 1
        visible: control.enabled
        radius: parent.radius
    }

    FocusRect {
        baseRadius: root.radius
        visible: root.visualFocus
    }

    // Prevents animations from running when loaded
    // HACK: for some reason, this won't work without a 1ms timer
    property bool loaded: false
    Timer {
        id: awfulHackTimer
        interval: 1
        onTriggered: root.loaded = true
    }
    Component.onCompleted: {
        awfulHackTimer.start()
    }
}
