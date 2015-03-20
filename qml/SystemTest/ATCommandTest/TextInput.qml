import QtQuick 2.4

Rectangle {
    property real parentWidth:0
    property real parentHeight:0
    width: parentWidth * .95
    height: parentHeight * .30
    anchors.centerIn: parent
    color:"black"
    border.color: "white"
    border.width: 2
    clip: true
    TextInput{
        anchors.fill: parent
        color:"white"
        text:""
        font.pixelSize: (width/text.length + 8) > 28 ? 28: (width/text.length + 8)
        anchors.margins: 4
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

}

