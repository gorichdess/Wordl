import QtQuick
import QtQuick.Controls

Button {
    id: root

    font.pointSize: 16
    font.bold: true

    background: Rectangle {
        radius: 4
        color: root.pressed ? Theme.pressedButtonColor : Theme.defaultKeyColor
    }
}