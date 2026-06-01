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

        anchors.top: parent.top
        anchors.left: parent.left

        anchors.topMargin: 40
        anchors.leftMargin: 15

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

    AppButton {
        width: 30
        height: 30

        anchors.top: parent.top
        anchors.right: parent.right

        anchors.topMargin: 40
        anchors.rightMargin: 15

        AppText{
            text: "?"
            color: Theme.textOnLightBg
            anchors.centerIn: parent
            font.pointSize: 15
            font.bold: true
        }

        onClicked: {
            helpPopup.open()
        }
    }

    Popup {
        id: helpPopup
        anchors.centerIn: parent
        width: parent.width * 0.8
        height: parent.height * 0.7
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        background: Rectangle {
            color: Theme.popupBg
            radius: 10
            border.width: 2
        }

        contentItem: ColumnLayout {
            spacing: 15

            Text {
                text: "HOW TO PLAY"
                color: Theme.textOnDarkBg
                font.bold: true
                font.pointSize: 18
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "Guess the secret word within 5 attempts.\nAfter every attempt color of letters will change."
                color: Theme.textPopup
                font.pointSize: 12
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
                Layout.maximumWidth: helpPopup.width - 40
                horizontalAlignment: Text.AlignHCenter
            }

            RowLayout {
                spacing: 10
                Layout.alignment: Qt.AlignHCenter

                Rectangle {
                    width: 40; height: 40; color: Theme.correctColor
                    Text { text: "A"; color: Theme.textOnDarkBg; anchors.centerIn: parent; font.bold: true }
                }
                Text { text: "Letter is in correct place."; color: Theme.textOnDarkBg }
            }

            RowLayout {
                spacing: 10
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
                Layout.maximumWidth: helpPopup.width - 40

                Rectangle {
                    width: 40; height: 40; color: Theme.presentColor
                    Text { text: "В"; color: Theme.textOnDarkBg; anchors.centerIn: parent; font.bold: true }
                }
                Text { text: "Letter is not in correct place, \n but is in secret word"; color: Theme.textOnDarkBg }
            }

            RowLayout {
                spacing: 10
                Layout.alignment: Qt.AlignHCenter

                Rectangle {
                    width: 40; height: 40; color: Theme.absentColor
                    Text { text: "C"; color: Theme.textOnDarkBg; anchors.centerIn: parent; font.bold: true }
                }
                Text { text: "Letter isnt in secret word."; color: Theme.textOnDarkBg }
            }

            RowLayout {
                spacing: 10
                Layout.alignment: Qt.AlignHCenter

                Text { text: "\n If a letter is repeated multiple times in your guess,
                              \n but appears only once in the secret word,
                            \n only the first extra letter will be highlighted in yellow!"; color: Theme.textPopup; font.pointSize: 12}
            }

            Button {
                text: "Ok"
                Layout.alignment: Qt.AlignHCenter
                onClicked: helpPopup.close()
            }
        }
    }

    Popup {
        id: resultDialog

        background: Rectangle {
            color: Theme.pageBackgroundColor
            radius: 10
        }

        padding: 20
        modal: true
        anchors.centerIn: parent

        property string resultText: ""
        property string title: "Game result"

        contentItem: ColumnLayout {
            spacing: 15

            Item {
                Layout.preferredHeight: 40
                Layout.fillWidth: true
                AppText {
                    text: resultDialog.title
                    anchors.centerIn: parent
                    font.pointSize: 18
                    font.bold: true
                    color: Theme.textOnLightBg
                }
            }

            AppText {
                text: resultDialog.resultText
                font.pointSize: 18
                color: Theme.textOnLightBg
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }

            Item {
                Layout.preferredHeight: 50
                Layout.fillWidth: true

                AppButton {
                    width: 50
                    height: 35
                    anchors.centerIn: parent

                    AppText {
                        text: "OK"
                        anchors.centerIn: parent
                        font.bold: true
                    }

                    onClicked: {
                        resultDialog.close()
                        gameController.resetGame()
                    }
                }
            }
        }
    }

    Popup {
        id: invalidWordDialog

        background: Rectangle {
            color: Theme.pageBackgroundColor
            radius: 10
        }

        padding: 20
        modal: true
        anchors.centerIn: parent

        property string resultText: ""
        property string title: "Invalid word"

        contentItem: ColumnLayout {
            spacing: 15

            Item {
                Layout.preferredHeight: 40
                Layout.fillWidth: true
                AppText {
                    text: invalidWordDialog.title
                    anchors.centerIn: parent
                    font.pointSize: 18
                    font.bold: true
                    color: Theme.textOnLightBg
                }
            }

            AppText {
                text: invalidWordDialog.resultText
                font.pointSize: 18
                color: Theme.textOnLightBg
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }

            Item {
                Layout.preferredHeight: 50
                Layout.fillWidth: true

                AppButton {
                    width: 50
                    height: 35
                    anchors.centerIn: parent

                    AppText {
                        text: "OK"
                        anchors.centerIn: parent
                        font.bold: true
                    }

                    onClicked: invalidWordDialog.close()
                }
            }
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
        width: Math.min(gamePage.width * 0.9, 400)
        anchors.centerIn: parent
        spacing: 15

        GameBoard {
            id: gameBoard
            Layout.fillWidth: true
            Layout.preferredHeight: width
            Layout.alignment: Qt.AlignHCenter

            currentAttempt: gameController.currentAttempt
            inputText: gameController.currentInput

            boardModel: gameController.boardModel
        }

        Item {
            Layout.fillHeight: true
            Layout.preferredHeight: 20
        }

        GameKeyboard {
            id: gameKeyboard
            Layout.fillWidth: true
            keyboardRowModel: gameController.keyboardModel

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

            AppButton{
                id: submitWordButton

                Layout.fillWidth: true
                Layout.preferredHeight: gamePage.height * 0.06
                enabled: gameController.currentInput.length === 5 && gameController.currentAttempt < 5

                AppText{
                    id: submitWordText
                    color: Theme.textOnLightBg
                    text : "Submit"
                    anchors.centerIn: parent
                    font.pixelSize: parent.height * 0.4
                    font.bold: true
                }


                onClicked: {
                    gameController.submitGuess();
                }
            }

            AppButton{
                id: newGameButton

                Layout.fillWidth: true
                Layout.preferredHeight: gamePage.height * 0.06

                AppText{
                    id: newGameText
                    color: Theme.textOnLightBg
                    text : "New Game"
                    anchors.centerIn: parent
                    font.pixelSize: parent.height * 0.4
                    font.bold: true
                }


                onClicked: {
                    gameController.resetGame();
                }

            }
        }
    }
}
