import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../components"

Page {
    id: gamePage
    focus: true

    Component.onCompleted: gamePage.forceActiveFocus()

    Keys.onBackPressed: (event) => {
        if (helpPopup.opened) {
            helpPopup.close()
            event.accepted = true
        } else if (resultDialog.opened) {
            resultDialog.close()
            gameController.resetGame()
            event.accepted = true
        } else if (invalidWordDialog.opened) {
            invalidWordDialog.close()
            event.accepted = true
        } else {
            if (StackView.view) {
                StackView.view.pop()
            } else {
                stackViewMain.pop()
            }
            event.accepted = true
        }
    }

    background: Rectangle {
        color: Theme.pageBackgroundColor
    }

    readonly property bool isLandscape: width > height
    readonly property bool isTablet: width > 600
    readonly property real maxGameWidth: isLandscape ? Math.min(width * 0.9, 450) : (isTablet ? 500 : Math.min(width * 0.9, 400))
    readonly property real topMargin: isLandscape ? 6 : 40
    readonly property real smallButtonSize: isLandscape ? 34 : 30

    AppButton {
        id: back
        width: smallButtonSize
        height: smallButtonSize
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: topMargin
        anchors.leftMargin: 12

        AppText {
            text: "X"
            color: Theme.textOnLightBg
            anchors.centerIn: parent
            font.pointSize: isLandscape ? 16 : 15
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
        id: helpButton
        width: smallButtonSize
        height: smallButtonSize
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: topMargin
        anchors.rightMargin: 12

        AppText {
            text: "?"
            color: Theme.textOnLightBg
            anchors.centerIn: parent
            font.pointSize: isLandscape ? 16 : 15
            font.bold: true
        }

        onClicked: helpPopup.open()
    }

    Popup {
        id: helpPopup
        anchors.centerIn: parent
        width: gamePage.isLandscape ? parent.width * 0.65 : parent.width * 0.8
        height: gamePage.isLandscape ? parent.height * 0.85 : parent.height * 0.7
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        background: Rectangle {
            color: Theme.popupBg
            radius: 10
            border.width: 2
        }

        contentItem: Flickable {
            clip: true
            contentHeight: helpContent.height

            ColumnLayout {
                id: helpContent
                width: helpPopup.width - 40
                spacing: gamePage.isLandscape ? 8 : 15
                anchors.margins: 20

                Text {
                    text: "HOW TO PLAY"
                    color: Theme.textOnDarkBg
                    font.bold: true
                    font.pointSize: gamePage.isLandscape ? 16 : 18
                    Layout.alignment: Qt.AlignHCenter
                    Layout.fillWidth: true
                }

                Text {
                    text: "Guess the secret word within 5 attempts.\nAfter every attempt color of letters will change."
                    color: Theme.textPopup
                    font.pointSize: 12
                    wrapMode: Text.WordWrap
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                }

                GridLayout {
                    columns: gamePage.isLandscape ? 2 : 1
                    rowSpacing: 8
                    columnSpacing: 15
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter

                    RowLayout {
                        spacing: 8
                        Layout.alignment: Qt.AlignHCenter

                        Rectangle {
                            width: 34
                            height: 34
                            color: Theme.correctColor

                            Text {
                                text: "A"
                                color: Theme.textOnDarkBg
                                anchors.centerIn: parent
                                font.bold: true
                            }
                        }

                        Text {
                            text: "Letter is in correct place."
                            color: Theme.textOnDarkBg
                            wrapMode: Text.WordWrap
                            Layout.fillWidth: true
                        }
                    }

                    RowLayout {
                        spacing: 8
                        Layout.alignment: Qt.AlignHCenter

                        Rectangle {
                            width: 34
                            height: 34
                            color: Theme.presentColor

                            Text {
                                text: "B"
                                color: Theme.textOnDarkBg
                                anchors.centerIn: parent
                                font.bold: true
                            }
                        }

                        Text {
                            text: "Letter is in the word but wrong position."
                            color: Theme.textOnDarkBg
                            wrapMode: Text.WordWrap
                            Layout.fillWidth: true
                        }
                    }

                    RowLayout {
                        spacing: 8
                        Layout.alignment: Qt.AlignHCenter

                        Rectangle {
                            width: 34
                            height: 34
                            color: Theme.absentColor

                            Text {
                                text: "C"
                                color: Theme.textOnDarkBg
                                anchors.centerIn: parent
                                font.bold: true
                            }
                        }

                        Text {
                            text: "Letter is not in the secret word."
                            color: Theme.textOnDarkBg
                            wrapMode: Text.WordWrap
                            Layout.fillWidth: true
                        }
                    }
                }

                Text {
                    text: "Note: If a letter appears multiple times in your guess but only once in the secret word, only the first occurrence will be highlighted in yellow!"
                    color: Theme.textPopup
                    font.pointSize: 11
                    wrapMode: Text.WordWrap
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignLeft
                }

                Button {
                    text: "OK"
                    Layout.alignment: Qt.AlignHCenter
                    onClicked: helpPopup.close()
                }
            }
        }
    }

    Popup {
        id: resultDialog
        padding: 20
        modal: true
        anchors.centerIn: parent

        property string resultText: ""
        property string title: "Game result"

        background: Rectangle {
            color: Theme.pageBackgroundColor
            radius: 10
        }

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
        padding: 20
        modal: true
        anchors.centerIn: parent

        property string resultText: ""
        property string title: "Invalid word"

        background: Rectangle {
            color: Theme.pageBackgroundColor
            radius: 10
        }

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

    Flickable {
        anchors.top: parent.top
        anchors.topMargin: isLandscape ? 44 : back.height + topMargin + 10
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        contentHeight: gameLayout.height
        clip: true
        flickableDirection: Flickable.VerticalFlick
        ScrollBar.vertical: ScrollBar { policy: ScrollBar.AsNeeded }

        ColumnLayout {
            id: gameLayout
            width: parent.width
            spacing: isLandscape ? 4 : 15

            ColumnLayout {
                width: Math.min(parent.width, maxGameWidth)
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: isLandscape ? 4 : 15

                GameBoard {
                    id: gameBoard
                    Layout.fillWidth: true
                    Layout.preferredHeight: width
                    Layout.alignment: Qt.AlignHCenter
                    Layout.maximumWidth: maxGameWidth
                    Layout.maximumHeight: maxGameWidth

                    currentAttempt: gameController.currentAttempt
                    inputText: gameController.currentInput
                    boardModel: gameController.boardModel
                }

                GameKeyboard {
                    id: gameKeyboard
                    Layout.fillWidth: true
                    Layout.maximumWidth: maxGameWidth
                    Layout.alignment: Qt.AlignHCenter
                    keyboardRowModel: gameController.keyboardModel

                    onLetterPressed: function(letter) {
                        gameController.appendLetter(letter)
                    }

                    onEnterPressed: submitWordButton.clicked()
                    onBackspacePressed: gameController.removeLastLetter()
                }

                RowLayout {
                    spacing: 8
                    Layout.fillWidth: true
                    Layout.maximumWidth: maxGameWidth
                    Layout.alignment: Qt.AlignHCenter

                    AppButton {
                        id: submitWordButton
                        Layout.fillWidth: true
                        Layout.preferredHeight: isLandscape ? 32 : gamePage.height * 0.06
                        enabled: gameController.currentInput.length === 5 && gameController.currentAttempt < 5

                        AppText {
                            text: "Submit"
                            color: Theme.textOnLightBg
                            anchors.centerIn: parent
                            font.pixelSize: Math.min(parent.height * 0.45, 20)
                            font.bold: true
                        }

                        onClicked: gameController.submitGuess()
                    }

                    AppButton {
                        id: newGameButton
                        Layout.fillWidth: true
                        Layout.preferredHeight: isLandscape ? 32 : gamePage.height * 0.06

                        AppText {
                            text: "New Game"
                            color: Theme.textOnLightBg
                            anchors.centerIn: parent
                            font.pixelSize: Math.min(parent.height * 0.45, 20)
                            font.bold: true
                        }

                        onClicked: gameController.resetGame()
                    }
                }
            }
        }
    }
}