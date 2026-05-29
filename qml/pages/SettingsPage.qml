import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../components"

Page {
    id: settingsPage

    background: Rectangle {
        color: Theme.pageBackgroundColor
    }

    width: stackViewMain.width
    height: stackViewMain.height

    AppButton {
        id: back
        width: 30
        height: 30

        AppText{
            text: "X"
            anchors.centerIn: parent
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

        AppText {
            text: "Word language"
        }

        ComboBox {
            id: languageBox

            model: ["English", "Deutsch", "Русский", "Українська"]
            currentIndex: model.indexOf(gameController.wordLanguage)

            font.pointSize: 17

            background: Rectangle {
                implicitWidth: 150
                implicitHeight: 40
                color: Theme.pageBackgroundColor
                border.color: Theme.defaultKeyColor
                radius: 4
            }

            contentItem: Text {
                text: languageBox.displayText
                color: Theme.textOnLightBg
                font: languageBox.font
                verticalAlignment: Text.AlignVCenter
                leftPadding: 10
            }

            onActivated: {
                gameController.wordLanguage = currentText
            }
        }

        AppText {
            text: "Selected: " + gameController.wordLanguage
            font.pointSize: 17
        }

    }
}