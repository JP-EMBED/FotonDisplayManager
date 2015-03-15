import QtQuick 2.4
Rectangle{
    width: 360
    height: 180
    property alias redValue: redColor.value
    property alias greenValue: greenColor.value
    property alias blueValue: blueColor.value
    property alias label: rgbText.text
    color: "transparent"
    Text{
        id: rgbText
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: colorRow.top
        horizontalAlignment: Text.AlignHCenter
        height: 60
        text:"Starting Color"
        color: "black"
        font.pixelSize: height * .85
    }

    Row{
        id: colorRow
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        width: 300
        height: 120
        Spinner{
            id: redColor
            height: 140
            width: 100
            color: "red"
            label: "Red Base"
        }
        Spinner{
            id: greenColor
            height: 140
            width: 100
            color: "green"
            label: "Green Base"
        }
        Spinner{
            id: blueColor
            height: 140
            width: 100
            color: "blue"
            label: "Blue Base"
        }
    }
}

