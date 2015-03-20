import QtQuick 2.4

Rectangle {
    property alias text: textObj.text
    property alias font_family: textObj.font.family
    radius: width/8
    border.width: 4
    gradient: Gradient {
        GradientStop {
            position: 0.28;
            color: "#000882";
        }
        GradientStop {
            position: 0.89;
            color: "#5a4bff";
        }
    }
    Text{
        id:textObj
        anchors.fill: parent
        anchors.margins:4
        font.pixelSize: width/text.length + 16
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color:"white"
        font.family: "calibri"
    }

}

