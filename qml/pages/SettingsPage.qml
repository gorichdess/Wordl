import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../components"

Page {
    id: settingsPage

    width: stackViewMain.width
    height: stackViewMain.height

    Button {
        id: back
        width: 30
        height: 30

        Text{
            text: "X"
            anchors.centerIn: parent
            font.pointSize: 15
            font.bold: true
        }

        onClicked: {
            if (StackView.view) {
                StackView.view.pop()
            } else {
                stackViewMain.pop()
            }
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: "Word language"
            font.pointSize: 17
        }

        ComboBox {
            id: languageBox
            font.pointSize: 17
            anchors.centerIn: parent
            model: ["English", "Deutsch", "Русский", "Українська"]

            currentIndex: model.indexOf(gameController.wordLanguage)

            onActivated: {
                gameController.wordLanguage = currentText
            }
        }

        Text {
            text: "Selected: " + gameController.wordLanguage
            font.pointSize: 17
        }

    }
}