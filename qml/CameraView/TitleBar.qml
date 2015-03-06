import QtQuick 2.4

Rectangle {
    gradient: Gradient {
        GradientStop {
            position: 0.00;
            color: "#3e3e3e";
        }
        GradientStop {
            position: 1.00;
            color: "#000000";
        }
    }
    border.color: "orange"
    border.width: 2
    Text{
        anchors.fill: parent
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: parent.height * .75
        text:"Photo Capture Mode"
        color: "white"
    }
}

