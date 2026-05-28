import QtQuick
import QtQuick.Controls
import "components"

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

            background: Rectangle {
                color: Theme.pageBackgroundColor
            }

            Column {
                anchors.centerIn: parent
                anchors.topMargin: 20
                spacing: 15

                AppButton{
                    id: newGameButton
                    width: 250
                    height: 50

                    AppText{
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

                AppButton{
                    id: statsPageButton
                    width: 250
                    height: 50

                    AppText{
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

                AppButton{
                    id: settingsPageButton
                    width: 250
                    height: 50

                    AppText{
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
