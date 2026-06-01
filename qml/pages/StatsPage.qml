import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../components"

Page {
    id: statsPage

    background: Rectangle {
        color: Theme.pageBackgroundColor
    }

    width: stackViewMain.width
    height: stackViewMain.height

    AppButton {
        id: back
        width: 30
        height: 30

        anchors.top: parent.top
        anchors.left: parent.left

        anchors.topMargin: 40
        anchors.leftMargin: 15

        AppText{
            text: "X"
            color: Theme.textOnLightBg
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
        width: parent.width * 0.8

        AppText {
            text: "Statistics"
            font.pointSize: 28
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
        }

        ComboBox {
            id: statsBox

            model: ["English", "Deutsch", "Русский", "Українська", "General"]
            Layout.alignment: Qt.AlignHCenter

            background: Rectangle {
                implicitWidth: 150
                implicitHeight: 40
                color: Theme.pageBackgroundColor
                border.color: Theme.defaultKeyColor
                radius: 4
            }
        }


        GridLayout {
            columns: 2
            rowSpacing: 15
            columnSpacing: 40
            Layout.alignment: Qt.AlignHCenter

            AppText {
                text: "Games played:"
            }

            AppText {
                text: gameController.statistics.getGamesPlayed(statsBox.currentText)
                font.bold: true
            }

            AppText {
                text: "Games won:"
            }

            AppText {
                text: gameController.statistics.getGamesWon(statsBox.currentText)
                font.bold: true
            }

            AppText {
                text: "Games lost:"
            }

            AppText {
                text: gameController.statistics.getGamesLost(statsBox.currentText)
                font.bold: true
            }

            AppText {
                text: "Win rate:"
            }

            AppText {
                text: gameController.statistics.getWinRate(statsBox.currentText)
                font.bold: true
            }

            AppText {
                text: "Current streak:"
            }

            AppText {
                text: gameController.statistics.getCurrentStreak(statsBox.currentText)
                font.bold: true
            }

            AppText {
                text: "Best streak:"
            }

            AppText {
                text: gameController.statistics.getBestStreak(statsBox.currentText)
                font.bold: true
            }
        }

        AppButton {
            Layout.alignment: Qt.AlignHCenter
            AppText{
                text:"Reset statistics"
                anchors.centerIn: parent
                font.bold: true
            }
            Layout.preferredWidth: 220
            Layout.preferredHeight: 45

            onClicked: {
                gameController.statistics.resetResults(statsBox.currentText)
            }
        }
    }
}