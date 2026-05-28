import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../components"  //whyyyy import "WordlClone" doesnt work??

Page {
    id: gamePage

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

    ColumnLayout{
        anchors.centerIn: parent
        spacing: 20

        GameBoard {
            id: gameBoard
            Layout.alignment: Qt.AlignHCenter
            currentAttempt: gameController.currentAttempt
            inputText: gameController.currentInput

            boardModel: gameController.boardModel
        }

        GameKeyboard {
            id: gameKeyboard
            keyboardModel: gameController.keyboardModel

            Layout.alignment: Qt.AlignHCenter

            onLetterPressed: function(letter) {
                gameController.appendLetter(letter)
            }

            onEnterPressed: submitWordButton.clicked()

            onBackspacePressed: {
                gameController.removeLastLetter()
            }
        }

        RowLayout {
            spacing: 10
            Layout.fillWidth: true
            Layout.preferredWidth: 400
            Layout.alignment: Qt.AlignHCenter

            AppButton{
                id: submitWordButton

                Layout.fillWidth: true
                Layout.preferredHeight: 50
                enabled: gameController.currentInput.length === 5 && gameController.currentAttempt < 5

                AppText{
                    id: submitWordText
                    color: Theme.textOnLightBg
                    text : "Submit"
                    anchors.centerIn: parent
                    font.pointSize: 20
                    font.bold: true
                }


                onClicked: {
                    gameController.submitGuess();
                }
            }

            AppButton{
                id: newGameButton

                Layout.fillWidth: true
                Layout.preferredHeight: 50

                AppText{
                    id: newGameText
                    color: Theme.textOnLightBg
                    text : "New Game"
                    anchors.centerIn: parent
                    font.pointSize: 20
                    font.bold: true
                }


                onClicked: {
                    gameController.resetGame();
                }

            }
        }
    }
}
