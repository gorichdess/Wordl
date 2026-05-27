import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Button {
    id: root

    property string keyText: ""
    property int keyStatus: 0

    text: keyText

    background: Rectangle {
            radius: 4
            color: {
                switch (root.keyStatus) {
                case 3: return "#6aaa64" // correct
                case 2: return "#c9b458" // present
                case 1: return "#787c7e" // absent
                default: return "#d3d6da"
                }
            }
        }

    Layout.preferredWidth: 50
    Layout.preferredHeight: 60

    font.pointSize: 15
    font.bold: true
}