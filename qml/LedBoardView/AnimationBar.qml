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
         Rectangle{height: animationBar.height/15; width: animationBar.width; color: "transparent"}

         Button
         {
            id: clearButton
            height: animationBar.height/20
            width: animationBar.width
            text: "Clear"
            onClicked:
            {
                LedGrid.clearBoard()
                LedBoardManager.sendClearBoard();
                for(var i = 0; i < 1024;i++)
                    square.grid.itemAt(i).color = 'black'
            }
         }
        //spacer
         Rectangle{height: animationBar.height/15; width: animationBar.width; color: "transparent"}
         Button
         {
            id: nextButton
            height: animationBar.height/20; width: animationBar.width
            text: "Next"
            onClicked:{flipPage(1);}
         }
         Button
         {
            id: prevButton
            height: animationBar.height/20; width: animationBar.width
            text: "Prev"
            onClicked:{flipPage(0)}
         }
        //spacer
        Rectangle{height: animationBar.height/15; width: animationBar.width; color: "transparent"}
        Rectangle
        {
            height: parent.height/10
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
                    LedGrid.setDuration(inputBox.text * 1000);
                }

            }
        }
        Button
        {
            id: playButton
            height: animationBar.height/20; width: animationBar.width
            property int play: 0;
            text: ">"
            onClicked:
            {
                if (play == 0)
                {
                    playButton.play = 1;
                    playButton.text = "II";
                    animationTimer.restart();

                }
                else
                {
                    playButton.play = 0;
                    playButton.text = ">";
                    animationTimer.stop();
                }
            }
        }

        //spacer
        Rectangle{height: animationBar.height/15; width: animationBar.width; color: "transparent"}
        Button
        {
            height: animationBar.height/20
            width: animationBar.width
            text: "Copy"
            onClicked:
            {
                if (square.selectedTool == "BoxSelect")
                {
                   LedGrid.copyPage(0,Math.round(square.selectionBox.originX/(square.width/32)), Math.round(square.selectionBox.originY/(square.width/32)), Math.round(square.selectionBox.endX/(square.width/32)), Math.round(square.selectionBox.endY/(square.width/32)))
                }
                else
                {
                    LedGrid.copyPage()
                }
            }
        }
        Button
        {
            height: animationBar.height/20
            width: animationBar.width
            text: "Paste"
            onClicked:
            {
                if(LedGrid.getCopyFlag() > 0)
                {
                    changeMade()
                    if (square.selectedTool == "BoxSelect")
                        LedGrid.pastePage(0,Math.round(square.selectionBox.originX/(square.width/32)), Math.round(square.selectionBox.originY/(square.width/32)), Math.round(square.selectionBox.endX/(square.width/32)), Math.round(square.selectionBox.endY/(square.width/32)))
                    else
                        LedGrid.pastePage()
                    displayGrid()
                }

            }
        }

        Rectangle{height: animationBar.height/15; width: animationBar.width; color: "transparent"}
        Button
        {
            id: addButton
            height: animationBar.height/15; width: animationBar.width
            text: "Add"
            onClicked:
            {
                LedGrid.insertPage()

                changeMade()
                displayGrid()
                inputBox.text = LedGrid.getDuration()/1000
            }
        }
        Button
        {

            id: deleteButton
            height: animationBar.height/15; width: animationBar.width
            text: "Delete"
            onClicked:
            {
                LedGrid.deletePage()

                displayGrid()
                inputBox.text = LedGrid.getDuration()/1000
            }
        }
        Rectangle{height: animationBar.height/15; width: animationBar.width; color: "transparent"}
        Button
        {

            id: undoButton
            height: animationBar.height/15; width: animationBar.width
            property int redo: 0
            text: redo ? "Redo":"Undo"
            onClicked:
            {
                LedGrid.undoPage();
                displayGrid();
                undoButton.redo = undoButton.redo ^ 1;
            }
        }
    }
}

