import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../components"  //whyyyy import "WordlClone" doesnt work??

Page {
    id: gamePage
    width: stackViewMain.width
    height: stackViewMain.height

    property string secretWord: "WORDS" // Later will be changed to db
    property int currentAttempt: 0
    property string currentInput: ""

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
            currentAttempt: gamePage.currentAttempt
            inputText: gamePage.currentInput
        }

        GameKeyboard {
            id: gameKeyboard

            Layout.alignment: Qt.AlignHCenter
            onLetterPressed: function(letter) {
                if (gamePage.currentInput.length < 5 && currentAttempt<5)
                    gamePage.currentInput += letter
            }

            onEnterPressed: submitWordButton.clicked()

            onBackspacePressed: {
                gamePage.currentInput = gamePage.currentInput.slice(0, -1)
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
                enabled: gamePage.currentInput.length === 5 && gamePage.currentAttempt < 5

                Text{
                    id: submitWordText
                    text : "Submit"
                    anchors.centerIn: parent
                    font.pointSize: 20
                    font.bold: true
                }


                onClicked: {
                    var guess = gamePage.currentInput.toUpperCase()
                    var startIdx = gamePage.currentAttempt * 5

                    for (var i = 0; i < 5; i++) {
                        var cellIdx = startIdx + i
                        var currentCell = gameBoard.getCell(cellIdx)
                        var letter = guess[i]

                        currentCell.savedLetter = letter

                        var status = currentCell.tileStatus.ABSENT

                        if (letter === secretWord[i]) {
                            status = currentCell.tileStatus.CORRECT
                        } else if (secretWord.indexOf(letter) !== -1) {
                            status = currentCell.tileStatus.PRESENT
                        }

                        // change grid tile color
                        currentCell.status = status

                        // change keyboard button color
                        gameKeyboard.updateKey(letter, status)
                    }

                    gamePage.currentAttempt++
                    gamePage.currentInput = ""
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
                    currentInput = ""
                    currentAttempt = 0;
                    gamePage.currentInput = "";

                    gameBoard.clearBoard()
                    gameKeyboard.clearKeys()
                }

            }
        }
    }
}
