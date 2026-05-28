import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../components"  //whyyyy import "WordlClone" doesnt work??

Page {
    id: gamePage
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

            Button{
                id: submitWordButton
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                enabled: gameController.currentInput.length === 5 && gameController.currentAttempt < 5

                Text{
                    id: submitWordText
                    text : "Submit"
                    anchors.centerIn: parent
                    font.pointSize: 20
                    font.bold: true
                }


                onClicked: {
                    gameController.submitGuess();
                }
            }

            Button{
                id: newGameButton
                Layout.fillWidth: true
                Layout.preferredHeight: 50

                Text{
                    id: newGameText
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
