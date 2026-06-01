import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root

    spacing: 6
    Layout.fillWidth: true
    Layout.alignment: Qt.AlignHCenter

    property var keyboardRowModel

    signal letterPressed(string letter)
    signal enterPressed()
    signal backspacePressed()

    RowLayout {
        Layout.alignment: Qt.AlignHCenter
        spacing: 6

        Repeater {
            model: root.keyboardRowModel.row0

            KeyboardButton {
                Layout.fillWidth: true

                keyText: model.letter
                keyStatus: model.status

                onClicked: root.letterPressed(model.letter)
            }
        }
    }

    RowLayout {
        Layout.alignment: Qt.AlignHCenter
        spacing: 4

        Layout.leftMargin: parent.width * 0.04
        Layout.rightMargin: parent.width * 0.04

        Repeater {
            model: root.keyboardRowModel.row1

            KeyboardButton {
                Layout.fillWidth: true

                keyText: model.letter
                keyStatus: model.status

                onClicked: root.letterPressed(model.letter)
            }
        }
    }

    RowLayout {
        Layout.alignment: Qt.AlignHCenter
        spacing: 4

        Repeater {
            model: root.keyboardRowModel.row2

            KeyboardButton {
                Layout.fillWidth: true

                keyText: model.letter
                keyStatus: model.status

                onClicked: root.letterPressed(model.letter)
            }
        }

        KeyboardButton {
            keyText: "⌫"
            Layout.preferredWidth: parent.width * 0.15
            onClicked: root.backspacePressed()
        }
    }
}