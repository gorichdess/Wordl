import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root

    spacing: 8
    Layout.alignment: Qt.AlignHCenter

    property var keyboardModel

    signal letterPressed(string letter)
    signal enterPressed()
    signal backspacePressed()

    RowLayout {
        Layout.alignment: Qt.AlignHCenter
        spacing: 6

        Repeater {
            model: root.keyboardModel

            KeyboardButton {
                visible: index >= 0 && index < 10
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
            model: root.keyboardModel

            KeyboardButton {
                visible: index >= 10 && index < 19
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
            model: root.keyboardModel

            KeyboardButton {
                visible: index >= 19 && index < 26
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