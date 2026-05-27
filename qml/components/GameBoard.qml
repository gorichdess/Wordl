import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Grid {
    id: root

    columns: 5
    rows: 5
    spacing: 8

    property int currentAttempt: 0
    property string inputText: ""

    Repeater {
        model: 25

        LetterTile {
            readonly property int cellRow: Math.floor(index / 5)
            readonly property int cellCol: index % 5

            property string savedLetter: ""

            letter: cellRow === root.currentAttempt
                    ? root.inputText[cellCol] || ""
                    : savedLetter
        }
    }

    function getCell(index) {
        return children[index]
    }

    function clearBoard() {
        for (var i = 0; i < children.length; i++) {
            var cell = children[i]
            if (cell.tileStatus !== undefined) {
                cell.status = cell.tileStatus.EMPTY
                cell.savedLetter = ""
            }
        }
    }
}