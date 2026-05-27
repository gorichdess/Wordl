import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root

    spacing: 8
    Layout.alignment: Qt.AlignHCenter

    signal letterPressed(string letter)
    signal enterPressed()
    signal backspacePressed()

    RowLayout {
        Layout.alignment: Qt.AlignHCenter
        spacing: 6
        Repeater {
            model: ["Q","W","E","R","T","Y","U","I","O","P"]

            KeyboardButton {
                objectName: modelData
                keyText: modelData
                onClicked: root.letterPressed(modelData)
            }
        }
    }

    RowLayout {
        Layout.alignment: Qt.AlignHCenter
        spacing: 6
        Repeater {
            model: ["A","S","D","F","G","H","J","K","L"]

            KeyboardButton {
                objectName: modelData
                keyText: modelData
                onClicked: root.letterPressed(modelData)
            }
        }
    }

    RowLayout {
        Layout.alignment: Qt.AlignHCenter
        spacing: 6
        Repeater {
            model: ["Z","X","C","V","B","N","M"]

            KeyboardButton {
                objectName: modelData
                keyText: modelData
                onClicked: root.letterPressed(modelData)
            }
        }

        KeyboardButton {
            keyText: "-"
            width: 70
            onClicked: backspacePressed()
        }
    }

    function updateKey(letter, status) {
        var buttons = root.children

        function search(item) {
            if (item.objectName === letter && item.keyStatus !== undefined) {
                item.keyStatus = Math.max(item.keyStatus, status)
            }

            for (var i = 0; i < item.children.length; i++) {
                search(item.children[i])
            }
        }

        search(root)
    }

    function clearKeys() {
        function clearItem(item){
            if (item.keyStatus !== undefined) {
                item.keyStatus = 0
            }

            for (var i = 0; i < item.children.length; i++) {
                clearItem(item.children[i])
            }
        }

        clearItem(root)
    }
}
