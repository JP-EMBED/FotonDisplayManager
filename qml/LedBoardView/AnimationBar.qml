import QtQuick 2.4
import QtQuick.Controls 1.2

Rectangle
{
    property alias inputBox: inputBox
    property alias undoButton: undoButton
    id: animationBar
    width: parent.width/11
    height: parent.height - topBar.height
    x: parent.width - animationBar.width
    y: topBar.height

    //horizontal gradient
    Rectangle
    {
        id: horizGradient
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

        //spacer
         Rectangle{height: animationBar.height/26; width: animationBar.width; color: "transparent"}

         Rectangle
         {
            id: clearButton
            height: animationBar.height/13
            width: animationBar.width
            radius: width*.1
            clip: true
            Image
            {
                id: clearImage
                source: "images/spongeButton.png"
                anchors.fill: parent
                anchors.margins: 4
            }
            Rectangle
            {
                anchors.fill: parent
                color: "#7FA3A3A3"
                visible: clearArea.pressed
            }
            MouseArea
            {
                id:clearArea
                anchors.fill: parent
                onClicked:
                {
                    FotonGrid.clearBoard()
                    LedBoardManager.sendClearBoard();
                    for(var i = 0; i < 1024;i++)
                        square.grid.itemAt(i).color = 'black'
                    LedBoardManager.sendLedColor(FotonGrid.getColor());
                }
            }
         }
        //spacer
         Rectangle{height: animationBar.height/26; width: animationBar.width; color: "transparent"}
         Rectangle
         {
            id: nextButton
            height: animationBar.height/13; width: animationBar.width
            radius: width*.1
            clip: true
            Image
            {
                source: "images/nextButton.png"
                anchors.fill: parent
                anchors.margins: 4
            }
            Rectangle
            {
                anchors.fill: parent
                color: "#7FA3A3A3"
                visible: nextArea.pressed
            }
            MouseArea
            {
                id:nextArea
                anchors.fill: parent;
                onClicked:{flipPage(1);}
            }
         }

         Rectangle
         {
            id: prevButton
            height: animationBar.height/13; width: animationBar.width
            radius: width*.1
            clip: true
            Image
            {
                source: "images/previousButton.png"
                anchors.fill: parent
                anchors.margins: 4
            }
            Rectangle
            {
                anchors.fill: parent
                color: "#7FA3A3A3"
                visible: prevArea.pressed
            }
            MouseArea
            {
                id: prevArea
                anchors.fill: parent;
                onClicked:{flipPage(0)}
            }
         }
        //spacer
        Rectangle{height: animationBar.height/26; width: animationBar.width; color: "transparent"}
        Rectangle
        {
            height: parent.height/13
            width:  parent.width
            TextInput
            {
                id: inputBox
                anchors.leftMargin: 4; anchors.bottomMargin: 3; anchors.fill: parent
                horizontalAlignment: Text.AlignLeft; verticalAlignment: Text.AlignTop
                color: "#AAAAAA"; selectionColor: "#FF7777AA"
                font.pixelSize: height *3/4
                maximumLength: 6
                selectByMouse: true
                text: "0.5"
                validator: DoubleValidator
                {
                    id: numValidator
                    bottom: 0; top: 255;
                    decimals:3
                }
                onAccepted:
                {
                    FotonGrid.setDuration(inputBox.text * 1000);
                }

            }
        }
        Rectangle
        {
            id: playButton
            height: animationBar.height/13; width: animationBar.width
            radius: width*.1
            property int play: 0;
            clip: true
            Image
            {
                source: parent.play ? "images/pauseButton.png": "images/playButton.png"
                anchors.fill: parent
                anchors.margins: 4
            }
            Rectangle
            {
                anchors.fill: parent
                color: "#7FA3A3A3"
                visible: playArea.pressed
            }
            MouseArea
            {
                id: playArea
                anchors.fill: parent;
                onClicked:
                {
                    if (playButton.play == 0)
                    {
                        playButton.play = 1;
                        animationTimer.restart();
                    }
                    else
                    {
                        playButton.play = 0;
                        animationTimer.stop();
                    }
                }
            }
        }

        //spacer
        Rectangle{height: animationBar.height/26; width: animationBar.width; color: "transparent"}
        Rectangle
        {
            height: animationBar.height/13
            width: animationBar.width
            radius: width*.1
            clip: true
            Image
            {
                source: "images/copyButton.png"
                anchors.fill: parent
                anchors.margins: 4
            }
            Rectangle
            {
                anchors.fill: parent
                color: "#7FA3A3A3"
                visible: copyArea.pressed
            }
            MouseArea
            {
                id: copyArea
                anchors.fill: parent;
                onClicked:
                {
                    if (square.selectionBox.placed)
                    {
                       FotonGrid.copyPage(0,Math.round(square.selectionBox.originX/(square.width/32)), Math.round(square.selectionBox.originY/(square.width/32)), Math.round(square.selectionBox.endX/(square.width/32)), Math.round(square.selectionBox.endY/(square.width/32)))
                    }
                    else
                    {
                        FotonGrid.copyPage()
                    }
                }
            }
        }
        Rectangle
        {
            height: animationBar.height/13
            width: animationBar.width
            radius: width*.1
            clip: true
            Image
            {
                source: "images/pasteButton.png"
                anchors.fill: parent
                anchors.margins: 4
            }
            Rectangle
            {
                anchors.fill: parent
                color: "#7FA3A3A3"
                visible: pasteArea.pressed
            }
            MouseArea
            {
                id: pasteArea
                anchors.fill: parent;
                onClicked:
                {
                    if(FotonGrid.getCopyFlag() > 0)
                    {
                        changeMade()
                        if (square.selectionBox.placed)
                            FotonGrid.pastePage(0,Math.round(square.selectionBox.originX/(square.width/32)), Math.round(square.selectionBox.originY/(square.width/32)), Math.round(square.selectionBox.endX/(square.width/32)), Math.round(square.selectionBox.endY/(square.width/32)))
                        else
                            FotonGrid.pastePage()
                        for(var i = 0; i < 1024;i++)
                            square.grid.itemAt(i).color = FotonGrid.getLedColor(i);
                    }

                }
            }
        }

        Rectangle{height: animationBar.height/26; width: animationBar.width; color: "transparent"}
        Rectangle
        {
            id: addButton
            height: animationBar.height/13; width: animationBar.width
            radius: width*.1
            clip: true
            Image
            {
                source: "images/addButton.png"
                anchors.fill: parent
                anchors.margins: 4
            }
            Rectangle
            {
                anchors.fill: parent
                color: "#7FA3A3A3"
                visible: addArea.pressed
            }
            MouseArea
            {
                id: addArea
                anchors.fill: parent;
                onClicked:
                {
                    FotonGrid.insertPage()
                    changeMade()
                    displayGrid()
                    inputBox.text = FotonGrid.getDuration()/1000
                }
            }
        }
        Rectangle
        {
            id: deleteButton
            height: animationBar.height/13; width: animationBar.width
            radius: width*.1
            clip: true
            Image
            {
                source: "images/deleteButton.png"
                anchors.fill: parent
                anchors.margins: 4
            }
            Rectangle
            {
                anchors.fill: parent
                color: "#7FA3A3A3"
                visible: deleteArea.pressed
            }
            MouseArea
            {
                id: deleteArea
                anchors.fill: parent;
                onClicked:
                {
                    FotonGrid.deletePage()
                    displayGrid()
                    inputBox.text = FotonGrid.getDuration()/1000
                }
            }
        }
        Rectangle{height: animationBar.height/26; width: animationBar.width; color: "transparent"}
        Rectangle
        {

            id: undoButton
            height: animationBar.height/13; width: animationBar.width
            radius: width*.1
            property int redo: 0
            clip: true
            Image
            {
                source: parent.redo ? "images/redoButton.png" : "images/undoButton.png"
                anchors.fill: parent
                anchors.margins: 4
            }
            Rectangle
            {
                anchors.fill: parent
                color: "#7FA3A3A3"
                visible: undoArea.pressed
            }
            MouseArea
            {
                id: undoArea
                anchors.fill: parent;
                onClicked:
                {
                    FotonGrid.undoPage();
                    displayGrid();
                    undoButton.redo = undoButton.redo ^ 1;
                }
            }
        }
    }
}

