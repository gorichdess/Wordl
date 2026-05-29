import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root

    spacing: 8
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
                Layout.preferredWidth: visible ? 50 : 0

                keyText: model.letter
                keyStatus: model.status

                onClicked: root.letterPressed(model.letter)
            }
        }
    }

    RowLayout {
        Layout.alignment: Qt.AlignHCenter
        spacing: 6

        Repeater {
            model: root.keyboardRowModel.row1

            KeyboardButton {
                Layout.preferredWidth: visible ? 50 : 0

                keyText: model.letter
                keyStatus: model.status

                onClicked: root.letterPressed(model.letter)
            }
        }
    }

    RowLayout {
        Layout.alignment: Qt.AlignHCenter
        spacing: 6

        Repeater {
            model: root.keyboardRowModel.row2

            KeyboardButton {
                Layout.preferredWidth: visible ? 50 : 0

                keyText: model.letter
                keyStatus: model.status

                onClicked: root.letterPressed(model.letter)
            }
        }

        KeyboardButton {
            keyText: "-"
            Layout.preferredWidth: 70
            onClicked: root.backspacePressed()
        }
    }
}