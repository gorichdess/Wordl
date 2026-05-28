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
        spacing: 25

        AppText {
            text: "Statistics"
            font.pointSize: 28
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
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
                text: "0"
                font.bold: true
            }

            AppText {
                text: "Games won:"
            }

            AppText {
                text: "0"
                font.bold: true
            }

            AppText {
                text: "Games lost:"
            }

            AppText {
                text: "0"
                font.bold: true
            }

            AppText {
                text: "Win rate:"
            }

            AppText {
                text: "0%"
                font.bold: true
            }

            AppText {
                text: "Current streak:"
            }

            AppText {
                text: "0"
                font.bold: true
            }

            AppText {
                text: "Best streak:"
            }

            AppText {
                text: "0"
                font.bold: true
            }
        }

        AppButton {
            AppText{
                text:"Reset statistics"
                anchors.centerIn: parent
                font.bold: true
            }
            Layout.preferredWidth: 220
            Layout.preferredHeight: 45

            onClicked: {
                //TODO
            }
        }
    }
}