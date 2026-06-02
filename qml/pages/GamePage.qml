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
    readonly property real topMargin: isLandscape ? 6 : 54
    readonly property real navButtonSize: isLandscape ? 44 : 48

    AppButton {
        id: back
        z: 10
        width: navButtonSize
        height: navButtonSize
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: topMargin
        anchors.leftMargin: 12

        AppText {
            text: "X"
            color: Theme.textOnLightBg
            anchors.centerIn: parent
            font.pointSize: 18
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
        z: 10
        width: navButtonSize
        height: navButtonSize
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: topMargin
        anchors.rightMargin: 12

        AppText {
            text: "?"
            color: Theme.textOnLightBg
            anchors.centerIn: parent
            font.pointSize: 18
            font.bold: true
        }

        onClicked: helpPopup.open()
    }

    Popup {
        id: helpPopup
        anchors.centerIn: parent
        width: gamePage.isLandscape ? Math.min(parent.width * 0.7, 500) : parent.width * 0.85

        height: Math.min(parent.height * 0.85, helpColumn.implicitHeight + padding * 2)

        padding: 20
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
            contentHeight: helpColumn.height + 30
            anchors.fill: parent
            ScrollBar.vertical: ScrollBar { policy: ScrollBar.AsNeeded }

            ColumnLayout {
                id: helpColumn
                width: parent.width - 30
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: gamePage.isLandscape ? 10 : 14
                anchors.margins: 15

                Text {
                    text: "HOW TO PLAY"
                    color: Theme.textOnDarkBg
                    font.bold: true
                    font.pointSize: gamePage.isLandscape ? 16 : 18
                    Layout.alignment: Qt.AlignHCenter
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                }

                Text {
                    text: "Guess the secret word within 5 attempts.\nAfter every attempt the color of letters will change."
                    color: Theme.textPopup
                    font.pointSize: gamePage.isLandscape ? 12 : 13
                    wrapMode: Text.WordWrap
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 10

                    RowLayout {
                        spacing: 10
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignLeft

                        Rectangle {
                            width: 36
                            height: 36
                            color: Theme.correctColor

                            Text {
                                text: "A"
                                color: Theme.textOnDarkBg
                                anchors.centerIn: parent
                                font.bold: true
                                font.pointSize: 12
                            }
                        }

                        Text {
                            text: "Letter is in correct place."
                            color: Theme.textOnDarkBg
                            wrapMode: Text.WordWrap
                            Layout.fillWidth: true
                            font.pointSize: 12
                        }
                    }

                    RowLayout {
                        spacing: 10
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignLeft

                        Rectangle {
                            width: 36
                            height: 36
                            color: Theme.presentColor

                            Text {
                                text: "B"
                                color: Theme.textOnDarkBg
                                anchors.centerIn: parent
                                font.bold: true
                                font.pointSize: 12
                            }
                        }

                        Text {
                            text: "Letter is in the word but wrong position."
                            color: Theme.textOnDarkBg
                            wrapMode: Text.WordWrap
                            Layout.fillWidth: true
                            font.pointSize: 12
                        }
                    }

                    RowLayout {
                        spacing: 10
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignLeft

                        Rectangle {
                            width: 36
                            height: 36
                            color: Theme.absentColor

                            Text {
                                text: "C"
                                color: Theme.textOnDarkBg
                                anchors.centerIn: parent
                                font.bold: true
                                font.pointSize: 12
                            }
                        }

                        Text {
                            text: "Letter is not in the secret word."
                            color: Theme.textOnDarkBg
                            wrapMode: Text.WordWrap
                            Layout.fillWidth: true
                            font.pointSize: 12
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
        anchors.top: back.bottom
        anchors.topMargin: isLandscape ? 8 : 24
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
            spacing: isLandscape ? 6 : 15

            ColumnLayout {
                width: Math.min(parent.width, maxGameWidth)
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: isLandscape ? 6 : 15

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
                    spacing: 10
                    Layout.fillWidth: true
                    Layout.maximumWidth: maxGameWidth
                    Layout.alignment: Qt.AlignHCenter

                    AppButton {
                        id: submitWordButton
                        Layout.fillWidth: true
                        Layout.preferredHeight: isLandscape ? 40 : gamePage.height * 0.065
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
                        Layout.preferredHeight: isLandscape ? 40 : gamePage.height * 0.065

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