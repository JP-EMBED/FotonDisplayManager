import QtQuick 2.4
import QtQuick.Controls 1.2

Rectangle
{
    property alias fillTool: fillTool
    property alias selectTool: selectTool

    id: toolBar
    width: parent.width/11
    height: parent.height - topBar.height
    x: 0
    y: topBar.height
    signal selectToolEnabled()
    signal selectToolDisabled()
    signal toolSelected()
    signal testModeOpen()
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

         //Rectangle{height: animationBar.height/10; width: animationBar.width; color: "transparent"}

         Rectangle
         {
            id: penTool
            height: animationBar.height/10
            width: animationBar.width
            radius: width*.1
            border.width: 6
            border.color: "#14DADE"
            Image
            {
                source: "images/pen.png"
                anchors.fill: parent
                anchors.margins: 6
            }

            MouseArea
            {
                anchors.fill:parent
                onClicked: // on clicked pen
                {
                    square.selectedTool = "Pen"
                    toolBar.toolSelected();
                    penTool.border.color = "#14DADE"
                    fillTool.border.color = 'black'
                    moveTool.border.color = 'black'
                    eyedropperTool.border.color = 'black'

                }
            }
         }
         Rectangle
         {
            id: fillTool
            height: animationBar.height/10
            width: animationBar.width
            radius: width*.1
            border.width: 6
            border.color: "black"
            property int altUse: 0
            Image
            {
                source: "images/fillBucket.png"
                anchors.fill: parent
                anchors.margins: 6
            }

            MouseArea
            {
                anchors.fill:parent
                onClicked: // On clicked Fill
                {
                    square.selectedTool = "Fill"
                    penTool.border.color = 'black'
                    fillTool.border.color = "#14DADE"
                    toolBar.toolSelected();
                    moveTool.border.color = 'black'
                    eyedropperTool.border.color = 'black'
                }
            }
         }
         Rectangle
         {
            id: selectTool
            height: animationBar.height/10
            width: animationBar.width
            radius: width*.1
            border.width: 6
            property bool selected: false
            border.color: 'black'
            Image
            {
                source: "images/selectionBox.png"
                anchors.fill: parent
                anchors.margins: 6
            }

            MouseArea
            {
                anchors.fill:parent
                onClicked:
                {
                    if(selectTool.selected)
                    {
                        selectTool.border.color = "black"
                        toolBar.selectToolDisabled()
                        selectTool.selected = false
                    }
                    else
                    {
                        selectTool.border.color = "#14DADE"
                        toolBar.selectToolEnabled()
                        selectTool.selected = true
                    }
                }
            }
         }
         Rectangle
         {
            id: moveTool
            height: animationBar.height/10
            width: animationBar.width
            radius: width*.1
            border.width: 6
            border.color: 'black'
            Image
            {
                source: "images/move.png"
                anchors.fill: parent
                anchors.margins: 6
            }

            MouseArea
            {
                anchors.fill:parent
                onClicked:
                {
                    square.selectedTool = "Move"

                    penTool.border.color = 'black'
                    fillTool.border.color = 'black'
                    moveTool.border.color = "#14DADE"
                    eyedropperTool.border.color = 'black'
                    toolBar.toolSelected();
                }
            }
         }
         Rectangle
         {
            id: eyedropperTool
            height: animationBar.height/10
            width: animationBar.width
            radius: width*.1
            border.width: 6
            border.color: 'black'
            Image
            {
                source: "images/colorPicker.png"
                anchors.fill: parent
                anchors.margins: 6
            }

            MouseArea
            {
                anchors.fill:parent
                onClicked:
                {
                    square.selectedTool = "Eyedropper"
                    eyedropperTool.border.color = "#14DADE"
                    penTool.border.color = 'black'
                    fillTool.border.color = 'black'
                    moveTool.border.color = 'black'
                    toolBar.toolSelected();
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
            border.width: 6
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
            border.width: 6
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
                    toolBar.toolSelected();
                    camView.showCameraView();
                }
            }
         }
         Rectangle
         {
            id: testButton
            height: open.height
            width: open.width
            radius: open.radius
            border.width: 6
            border.color: 'black'

            Image{
                anchors.fill: parent
                anchors.margins: 8
                source: "images/testButton.png"
            }

            MouseArea
            {
                anchors.fill:parent
                onClicked:{testModeOpen()}
            }
         }
    }
}

