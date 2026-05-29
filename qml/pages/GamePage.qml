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

    Dialog {
        id: resultDialog

        background: Rectangle {
            color: Theme.pageBackgroundColor
        }

        padding: 20

        header: Item {
            implicitHeight: 40
            AppText {
                text: resultDialog.title
                anchors.centerIn: parent
                font.pointSize: 18
                font.bold: true
                color: Theme.textOnLightBg
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        footer: Item {
            implicitHeight: 50

            AppButton {
                AppText{
                    text: "OK"
                    anchors.centerIn: parent
                    font.bold: true
                }
                width: 50
                height: 35

                anchors.right: parent.right
                anchors.centerIn: parent
                onClicked: resultDialog.accept()
            }
        }

        modal: true
        anchors.centerIn: parent

        property string resultText: ""

        title: "Game result"

        contentItem: AppText {
            text: resultDialog.resultText
            font.pointSize: 18
            color: Theme.textOnLightBg
        }

        onAccepted: {
            gameController.resetGame()
        }
    }

    Dialog {
        id: invalidWordDialog

        background: Rectangle {
            color: Theme.pageBackgroundColor
        }

        padding: 20

        header: Item {
            implicitHeight: 40
            AppText {
                text: invalidWordDialog.title
                anchors.centerIn: parent
                font.pointSize: 18
                font.bold: true
                color: Theme.textOnLightBg
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        footer: Item {
            implicitHeight: 50

            AppButton {
                AppText{
                    text: "OK"
                    anchors.centerIn: parent
                    font.bold: true
                }
                width: 50
                height: 35

                anchors.right: parent.right
                anchors.centerIn: parent
                onClicked: invalidWordDialog.accept()
            }
        }

        modal: true
        anchors.centerIn: parent

        property string resultText: ""

        title: "Invalid word"
        standardButtons: Dialog.Ok

        contentItem: AppText {
            text: invalidWordDialog.resultText
            font.pointSize: 18
            color: Theme.textOnLightBg
        }
    }

    Connections {
        target: gameController

        function onGameWon(word) {
            resultDialog.title = "You won!"
            resultDialog.resultText = "Congratulations! The word was: " + word
            resultDialog.open()
        }

        function onGameLost(word) {
            resultDialog.title = "You lost!"
            resultDialog.resultText = "The word was: " + word
            resultDialog.open()
        }

        function onInvalidWord(word) {
            invalidWordDialog.resultText = word + " is not in the word list"
            invalidWordDialog.open()
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
            keyboardRowModel: gameController.keyboardModel

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
