import QtQuick 2.4
import QtQuick.Controls 1.2

Rectangle
{
    property alias fillTool: fillTool
    id: toolBar
    width: parent.width/11
    height: parent.height - topBar.height
    x: 0
    y: topBar.height

    //horizontal gradient
    Rectangle
    {
        id: horizGradient2
        width: parent.height
        height: parent.width
        anchors.centerIn: parent
        rotation: 90
        gradient: Gradient
        {
                 GradientStop { position: 0.0; color: Qt.rgba(.5,.5,.5,1) }
                 GradientStop { position: 1.0; color: Qt.rgba(.7,.7,.7,1) }
        }
    }
    //side buttons
    Column
    {
         spacing: 0

         Rectangle{height: animationBar.height/10; width: animationBar.width; color: "transparent"}

         Rectangle
         {
            id: penTool
            height: animationBar.height/10
            width: animationBar.width
            radius: width*.1
            border.width: 10
            border.color: "#14DADE"
            Text
            {
                anchors.fill: parent
                text: "Pen"
                font.pixelSize: height/2;
                font.bold: true
                horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter
                anchors.bottomMargin: 3

            }
            MouseArea
            {
                anchors.fill:parent
                onClicked:
                {
                    square.selectedTool = "Pen"
                    penTool.border.color = "#14DADE"
                    fillTool.border.color = 'black'
                    selectTool.border.color = 'black'
                    moveTool.border.color = 'black'
                }
            }
         }
         Rectangle
         {
            id: fillTool
            height: animationBar.height/10
            width: animationBar.width
            radius: width*.1
            border.width: 10
            border.color: "black"
            property int altUse: 0
            Text
            {
                anchors.fill: parent
                text: "Fill"
                font.pixelSize: height/2;
                font.bold: true
                horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter
                anchors.bottomMargin: 3

            }
            MouseArea
            {
                anchors.fill:parent
                onClicked:
                {
                    if (square.selectedTool == "BoxSelect" && fillTool.altUse == 0)
                    {
                        fillTool.altUse = 1
                        fillTool.border.color = "#14DADE"
                        selectTool.border.color = "#00CACF"
                    }
                    else
                    {
                        fillTool.altUse = 0
                        square.selectedTool = "Fill"

                        penTool.border.color = 'black'
                        fillTool.border.color = "#14DADE"
                        selectTool.border.color = 'black'
                        moveTool.border.color = 'black'
                    }
                }
            }
         }
         Rectangle
         {
            id: selectTool
            height: animationBar.height/10
            width: animationBar.width
            radius: width*.1
            border.width: 10
            border.color: 'black'
            Text
            {
                anchors.fill: parent
                text: "BoxSelect"
                font.pixelSize: height/4;
                font.bold: true
                horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter
                anchors.bottomMargin: 3

            }
            MouseArea
            {
                anchors.fill:parent
                onClicked:
                {
                    square.selectedTool = "BoxSelect"
                    fillTool.altUse = 0
                    penTool.border.color = 'black'
                    fillTool.border.color = "#FFB01C"
                    selectTool.border.color = "#14DADE"
                    moveTool.border.color = 'black'
                }
            }
         }
         Rectangle
         {
            id: moveTool
            height: animationBar.height/10
            width: animationBar.width
            radius: width*.1
            border.width: 10
            border.color: 'black'
            Text
            {
                anchors.fill: parent
                text: "Move"
                font.pixelSize: height/2;
                font.bold: true
                horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter
                anchors.bottomMargin: 3

            }
            MouseArea
            {
                anchors.fill:parent
                onClicked:
                {
                    square.selectedTool = "Move"

                    penTool.border.color = 'black'
                    fillTool.border.color = 'black'
                    selectTool.border.color = 'black'
                    moveTool.border.color = "#14DADE"
                }
            }
         }
         Rectangle{height: animationBar.height/20; width: animationBar.width; color: "transparent"}
         Rectangle
         {
            id: save
            height: animationBar.height/10
            width: animationBar.width
            radius: width*.1
            border.width: 10
            border.color: 'black'

            Text
            {
                anchors.fill: parent
                text: "Save"
                font.pixelSize: height/2;
                font.bold: true
                horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter
                anchors.bottomMargin: 3

            }
            MouseArea
            {
                anchors.fill:parent
                onClicked:
                {
                    fExplorer.saveOpen = 1;
                    fExplorer.x = 0;
                }
            }
         }
         Rectangle
         {
            id: open
            height: animationBar.height/10
            width: animationBar.width
            radius: width*.1
            border.width: 10
            border.color: 'black'

            Text
            {
                anchors.fill: parent
                text: "Open"
                font.pixelSize: height/2;
                font.bold: true
                horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter
                anchors.bottomMargin: 3

            }
            MouseArea
            {
                anchors.fill:parent
                onClicked:
                {
                    fExplorer.saveOpen = 0;
                    fExplorer.x = 0;
                }
            }
         }
         Rectangle
         {
            id: cameraButton
            height: open.height
            width: open.width
            radius: open.radius
            border.width: 6
            border.color: 'black'

            Image{
                anchors.fill: parent
                anchors.margins: 8
                source: "images/camera.png"
            }

            MouseArea
            {
                anchors.fill:parent
                onClicked:
                {
                    camView.showCameraView();
                }
            }
         }
    }
}

