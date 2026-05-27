import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../components"  //whyyyy import "WordlClone" doesnt work??

Page {
    width: stackViewMain.width
    height: stackViewMain.height

    property string secretWord: "WORDS" // Later will be changed to db
    property int currentAttempt: 0

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

        Grid{
            id: gameGrid
            columns: 5
            rows: 5
            spacing: 8
            Layout.alignment: Qt.AlignHCenter

            Repeater{
                model: 25

                LetterTile{
                    id: cell

                    readonly property int cellRow: Math.floor(index / 5)
                    readonly property int cellCol: index % 5

                    property string savedLetter: ""

                    letter: cellRow === currentAttempt
                            ? inputField.text[cellCol] || ""
                            : savedLetter
                }
            }
        }

        TextField {
            id: inputField
            placeholderText: "Enter 5 letters..."
            font.pointSize: 16
            maximumLength: 5
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter

            validator: RegularExpressionValidator { regularExpression: /[a-zA-Zа-яА-ЯёЁ]{5}/ }
            onAccepted: submitWordButton.clicked() //if enter pressed
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
                enabled: inputField.text.length === 5 && currentAttempt < 5

                Text{
                    id: submitWordText
                    text : "Submit"
                    anchors.centerIn: parent
                    font.pointSize: 20
                    font.bold: true
                }


                onClicked: {
                    var guess = inputField.text.toUpperCase();
                    var startIdx = currentAttempt * 5;

                    for (var i = 0; i < 5; i++) {
                        var cellIdx = startIdx + i;
                        var currentCell = gameGrid.children[cellIdx];
                        var letter = guess[i];

                        currentCell.savedLetter = letter;

                        switch (true) {
                        case (letter === secretWord[i]):
                            currentCell.status = currentCell.tileStatus.CORRECT;
                            break;

                        case (secretWord.indexOf(letter) !== -1):
                            currentCell.status = currentCell.tileStatus.PRESENT;
                            break;

                        default:
                            currentCell.status = currentCell.tileStatus.ABSENT;
                            break;
                        }
                    }

                    currentAttempt++;
                    inputField.clear();
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
                    currentAttempt = 0;
                    inputField.clear();

                    for (var i = 0; i < gameGrid.children.length - 1; i++) {
                        var cell = gameGrid.children[i];
                        if (cell.status) {
                            cell.status = cell.tileStatus.EMPTY;
                            cell.savedLetter = "";
                        }
                    }
                }

            }
        }
    }
}
