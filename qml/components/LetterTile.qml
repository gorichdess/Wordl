import QtQuick
import QtQuick.Controls

Rectangle {
    id: box
    width: 60
    height: 60
    radius: 5
    border.width: 2

    readonly property var tileStatus: {
            "EMPTY": 0,
            "ABSENT": 1,
            "PRESENT": 2,
            "CORRECT": 3
        }

    property string letter: ""
    property int status: box.tileStatus.EMPTY

    color: {
        switch (status) {
                case box.tileStatus.CORRECT:
                    return "#6aaa64";
                case box.tileStatus.PRESENT:
                    return "#c9b458";
                case box.tileStatus.ABSENT:
                    return "#787c7e";
                default:
                    return "transparent";
            }
    }

    border.color: {
        if (status === box.tileStatus.EMPTY) return letter === "" ? "#d3d6da" : "#878a8c"
        return "transparent"
    }

    Text {
        text: box.letter.toUpperCase()
        anchors.centerIn: parent
        font.pointSize: 22
        font.bold: true
        color: box.status === box.tileStatus.EMPTY ? "#000000" : "#ffffff"
    }

    Behavior on color { ColorAnimation { duration: 250 } }
}