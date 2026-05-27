import QtQuick
import QtQuick.Controls

Page {
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

        background: Rectangle {
            color: back.pressed ? "#E0E0E0" : "#C0C0C0"
        }
    }
}
