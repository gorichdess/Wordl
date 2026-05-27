import QtQuick
import QtQuick.Controls

Window{
    width : 700
    height : 500
    visible : true
    title: qsTr("WordlClone")

    StackView {
        id: stackViewMain
        anchors.fill: parent
        initialItem: mainPage
    }

    Component {
        id: mainPage
        Page {
            width: stackViewMain.width
            height: stackViewMain.height

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 20
                spacing: 15

                Button{
                    id: newGame
                    width: 250
                    height: 50

                    Text{
                        id: newGameText
                        text : "New Game"
                        anchors.centerIn: parent
                        font.pointSize: 20
                        font.bold: true
                    }


                    onClicked: {
                        stackViewMain.push("pages/GamePage.qml")
                    }

                    background: Rectangle {
                        color: addTransaction.pressed ? "#E0E0E0" : "#C0C0C0"
                    }

                }

                Button{
                    id: statsPage
                    width: 250
                    height: 50

                    Text{
                        id: statsPageText
                        text : "Stats"
                        anchors.centerIn: parent
                        font.pointSize: 20
                        font.bold: true
                    }


                    onClicked: {
                        //stackView.push("")
                    }

                    background: Rectangle {
                        color: addTransaction.pressed ? "#E0E0E0" : "#C0C0C0"
                    }
                }
            }
        }
    }
}
