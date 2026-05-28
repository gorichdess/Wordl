import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

AppButton {
    id: root

    property string keyText: ""
    property int keyStatus: 0

    AppText{
        text: keyText
        anchors.centerIn: parent
        font.bold: true
        font.pointSize: 20
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

    Layout.preferredWidth: 50
    Layout.preferredHeight: 60

    font.pointSize: 15
    font.bold: true
}