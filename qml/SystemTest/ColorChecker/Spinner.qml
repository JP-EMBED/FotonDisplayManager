import QtQuick 2.4

Rectangle {

    property alias value: list.currentIndex
    property alias label: caption.text
    color: "red"
    radius: 12
    Text {
        id: caption
        text: ""
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.margins: 2
    }
    Rectangle {
        id: outerCrop
        anchors.top: caption.bottom
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 8
        height: parent.height
        width: parent.width * .9
        color: "black"
        radius:2
        ListView {
            id: list
            anchors.fill: parent
            highlightRangeMode: ListView.StrictlyEnforceRange
            preferredHighlightBegin: height/3
            preferredHighlightEnd: height/3
            clip: true
            model: 256
            delegate: Text {
                font.pixelSize: redColor.height * .4
                color: "white";
                text: index;
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
        Rectangle {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#FF000000" }
                GradientStop { position: 0.2; color: "#00000000" }
                GradientStop { position: 0.8; color: "#00000000" }
                GradientStop { position: 1.0; color: "#FF000000" }
            }
        }
    }
}

