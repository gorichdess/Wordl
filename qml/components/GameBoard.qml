import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Grid {
    id: root

    columns: 5
    rows: 5
    columnSpacing: Math.max(4, width * 0.01)
    rowSpacing: Math.max(4, height * 0.01)

    property int currentAttempt: 0
    property string inputText: ""

    property var boardModel

    Repeater {
        model: root.boardModel

        LetterTile {
            readonly property int cellRow: Math.floor(index / 5)
            readonly property int cellCol: index % 5

            width: (root.width - (root.columnSpacing * 4)) / 5
            height: width

            letter: cellRow === root.currentAttempt
                    ? (root.inputText.length > cellCol ? root.inputText.charAt(cellCol) : "")
                    : model.letter

            status: model.status
        }
    }
}