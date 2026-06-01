import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

AppButton {
    id: root

    property string keyText: ""
    property int keyStatus: 0

    Layout.fillWidth: true
    Layout.preferredHeight: minPageWidth * 0.12

    readonly property real minPageWidth: root.Window.width ? root.Window.width : 360

    AppText{
        text: keyText
        anchors.centerIn: parent
        font.bold: true
        font.pixelSize: parent.height * 0.4
    }

    background: Rectangle {
            radius: 4
            color: {
                switch (root.keyStatus) {
                case 3: return Theme.correctColor // correct
                case 2: return Theme.presentColor // present
                case 1: return Theme.absentColor // absent
                default: return Theme.defaultKeyColor
                }
            }
        }

    font.bold: true
}