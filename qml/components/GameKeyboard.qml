import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root

    spacing: 6
    Layout.fillWidth: true
    Layout.alignment: Qt.AlignHCenter

    property var keyboardRowModel
    readonly property real keyHeight: {
        if (root.width > 600) return 60
        if (root.width > 400) return 50
        return 40
    }

    signal letterPressed(string letter)
    signal enterPressed()
    signal backspacePressed()

    RowLayout {
        Layout.alignment: Qt.AlignHCenter
        spacing: Math.max(4, parent.width * 0.01)
        Layout.fillWidth: true

        Repeater {
            model: root.keyboardRowModel.row0

            KeyboardButton {
                Layout.fillWidth: true
                Layout.maximumWidth: 70
                Layout.minimumWidth: 30
                Layout.preferredHeight: keyHeight

                keyText: model.letter
                keyStatus: model.status

                onClicked: root.letterPressed(model.letter)
            }
        }
    }

    RowLayout {
        Layout.alignment: Qt.AlignHCenter
        spacing: Math.max(4, parent.width * 0.008)
        Layout.leftMargin: parent.width * 0.02
        Layout.rightMargin: parent.width * 0.02

        Repeater {
            model: root.keyboardRowModel.row1

            KeyboardButton {
                Layout.fillWidth: true
                Layout.maximumWidth: 70
                Layout.minimumWidth: 30
                Layout.preferredHeight: keyHeight

                keyText: model.letter
                keyStatus: model.status

                onClicked: root.letterPressed(model.letter)
            }
        }
    }

    RowLayout {
        Layout.alignment: Qt.AlignHCenter
        spacing: Math.max(4, parent.width * 0.008)

        Repeater {
            model: root.keyboardRowModel.row2

            KeyboardButton {
                Layout.fillWidth: true
                Layout.maximumWidth: 70
                Layout.minimumWidth: 30
                Layout.preferredHeight: keyHeight

                keyText: model.letter
                keyStatus: model.status

                onClicked: root.letterPressed(model.letter)
            }
        }

        KeyboardButton {
            keyText: "-"
            Layout.preferredWidth: parent.width * 0.12
            Layout.maximumWidth: 80
            Layout.minimumWidth: 50
            Layout.preferredHeight: keyHeight
            onClicked: root.backspacePressed()
        }
    }
}