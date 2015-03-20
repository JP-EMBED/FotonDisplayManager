import QtQuick 2.4
import "../ledscreencomponent"
Rectangle {
    color:"darkgrey"
    Rectangle{
        id:titleImage
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        border.color: "black"
        border.width: 4
        width:parent.width/2
        height: parent.height/2
        Image{
            anchors.fill: parent
            anchors.margins: 4
            source: "images/background.png"
        }
    }

    Item{
        id:sourceArea
        anchors.top: titleImage.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: parent.height/5

        Text{
            anchors.fill: parent
            font.pixelSize: height * .84
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text:"Display Manager"
            font.family: rockerFont.name
        }
    }
    Rectangle{
        anchors.top: titleImage.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width*.8
        height: parent.height/5
        radius: 10
        border.width: 2
        border.color: "white"
        color:"black"
        LedScreen {
            id: ledScreen
            anchors.margins: 4
            anchors.fill: parent
            sourceItem: sourceArea
            ledSize: 8
            ledColor: "#fb00ff"
        }
    }

    TitleButton {
        id:connectButton
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: parent.width/20
        anchors.bottomMargin: parent.height/10
        width: parent.width/4
        height: parent.height/8
        text:"Connect"
        font_family: rockerFont.name
        MouseArea{
            anchors.fill: parent
            onClicked:{
                showConnectionView();
            }
        }
    }


    TitleButton {
        id: aboutButton
        anchors.verticalCenter:connectButton.verticalCenter
        anchors.left: connectButton.right
        anchors.leftMargin: parent.width/40
        width: parent.width/2.6
        height: parent.height/8
        text:"About F0T0N"
        font_family: rockerFont.name
    }

    TitleButton {
        id: drawButton
        anchors.verticalCenter:connectButton.verticalCenter
        anchors.left: aboutButton.right
        anchors.leftMargin: parent.width/40
        width: parent.width/4
        height: parent.height/8
        text:"Draw"
        font_family: rockerFont.name
        MouseArea{
            anchors.fill: parent
            onClicked:{
                showBoardView();
            }
        }
    }
}

