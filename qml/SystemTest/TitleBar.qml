import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

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
        id: titleText
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.right: parent.horizontalCenter
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: parent.height * .75
        text:"System Test Mode"
        color: "white"
    }
}

