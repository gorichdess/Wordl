import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../components"

Page {
    id: statsPage

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
        spacing: 25

        Text {
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

            Text {
                text: "Games played:"
                font.pointSize: 16
            }

            Text {
                text: "0"
                font.pointSize: 16
                font.bold: true
            }

            Text {
                text: "Games won:"
                font.pointSize: 16
            }

            Text {
                text: "0"
                font.pointSize: 16
                font.bold: true
            }

            Text {
                text: "Games lost:"
                font.pointSize: 16
            }

            Text {
                text: "0"
                font.pointSize: 16
                font.bold: true
            }

            Text {
                text: "Win rate:"
                font.pointSize: 16
            }

            Text {
                text: "0%"
                font.pointSize: 16
                font.bold: true
            }

            Text {
                text: "Current streak:"
                font.pointSize: 16
            }

            Text {
                text: "0"
                font.pointSize: 16
                font.bold: true
            }

            Text {
                text: "Best streak:"
                font.pointSize: 16
            }

            Text {
                text: "0"
                font.pointSize: 16
                font.bold: true
            }
        }

        Button {
            text: "Reset statistics"
            Layout.preferredWidth: 220
            Layout.preferredHeight: 45
            font.pointSize: 16

            onClicked: {
                //TODO
            }
        }
    }
}