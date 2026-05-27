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
                    return Theme.correctColor;
                case box.tileStatus.PRESENT:
                    return Theme.presentColor;
                case box.tileStatus.ABSENT:
                    return Theme.absentColor;
                default:
                    return "transparent";
            }
    }

    border.color: {
        if (status === box.tileStatus.EMPTY) return letter === "" ? Theme.defaultKeyColor : Theme.typedBorderColor
        return "transparent"
    }

    Text {
        text: box.letter.toUpperCase()
        anchors.centerIn: parent
        font.pointSize: 22
        font.bold: true
        color: box.status === box.tileStatus.EMPTY ? Theme.textOnLightBg : Theme.textOnDarkBg
    }

    Behavior on color { ColorAnimation { duration: 250 } }
}