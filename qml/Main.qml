import QtQuick
import QtQuick.Controls

Window{
    width : 700
    height : 700
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

            Column {
                anchors.centerIn: parent
                anchors.topMargin: 20
                spacing: 15

                Button{
                    id: newGameButton
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
                        stackViewMain.push("pages/GamePage.qml", {
                            gameController: gameController
                        })
                    }
                }

                Button{
                    id: statsPageButton
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
                        stackViewMain.push("pages/StatsPage.qml")
                    }

                }

                Button{
                    id: settingsPageButton
                    width: 250
                    height: 50

                    Text{
                        id: settingsPageText
                        text : "Settings"
                        anchors.centerIn: parent
                        font.pointSize: 20
                        font.bold: true
                    }


                    onClicked: {
                        stackViewMain.push("pages/SettingsPage.qml")
                    }
                }
            }
        }
    }
}
