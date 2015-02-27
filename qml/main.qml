import QtQuick 2.0
import QtQuick 2.1
import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.0
import "ColorPicker"
import "FExplorer"


ApplicationWindow
{
    title: "F0T0N2"
    id: mainWindow
    width: Screen.width
    height: Screen.height
    visible: true
    color: "black"

    Timer
    {
        id: animationTimer
        interval: LedGrid.getDuration()
        running: false
        onTriggered:
        {
            flipPage(1);
            animationTimer.interval = LedGrid.getDuration();
            animationTimer.restart();
        }
    }

    //LED grid
    Rectangle
    {
        id: square
        property string selectedTool: "Pen"
        property real currentScale: 1
        property real startX: 0
        property real startY: 0
        property real currentX: square.x
        property real currentY: square.y
        width: Screen.height - topBar.height
        height: square.width
        x: (Screen.width/2 - square.width/2)
        y: topBar.height
        color: Qt.rgba(.7,.7,.7,1)
        transform: Scale { id: squareScale; origin.x: square.height/2; origin.y: square.width/2; xScale: 1; yScale: 1}

        //Selection Box
        Rectangle
        {
            id: selectionBox
            z: 0
            color: "#00000000"
            border.width: 10
            border.color: 'white'
            property real originX: 0
            property real originY: 0
            property real endX: 0
            property real endY: 0
            property int placed: 0
            transformOrigin: Item.TopLeft
        }

        MultiPointTouchArea
        {
            id: squareMultiTouch
            anchors.fill: parent
            maximumTouchPoints: 2
            touchPoints: [TouchPoint { id: point1 }, TouchPoint { id: point2 }]
            onPressed:
            {

                square.currentScale = squareScale.xScale

                if((point1.x < square.width && point1.y < square.height) && (point1.x > 0 && point1.y > 0))
                {
                        if (square.selectedTool == "Pen")
                        {
                            changeMade()
                            LedGrid.ledPressed((point1.x/(square.width/32))|0, (point1.y/(square.height/32))|0)
                            repeater.itemAt((point1.x/(square.width/32))|0 + (point1.y/(square.height/32)|0)*32).color = LedGrid.getColor()
                        }
                }

                if (square.selectedTool == "Fill")
                {
                    changeMade()
                    LedGrid.fillBucket((point1.x/(square.width/32))|0, (point1.y/(square.height/32))|0)
                    displayGrid()

                }
                else if (square.selectedTool == "BoxSelect")
                {
                    if (selectionBox.rotation == 0 && !(selectionBox.x < point1.x && point1.x < (selectionBox.x + selectionBox.width) &&
                                                        selectionBox.y < point1.y && point1.y < (selectionBox.y + selectionBox.height)))
                    {
                        if (fillTool.altUse == 1)
                        {
                            changeMade();
                            LedGrid.copyPage(2, Math.round(selectionBox.originX/(square.width/32)), Math.round(selectionBox.originY/(square.width/32)), Math.round(selectionBox.endX/(square.width/32)), Math.round(selectionBox.endY/(square.width/32)))
                            LedGrid.fillBucket((point1.x/(square.width/32))|0, (point1.y/(square.height/32))|0)
                            LedGrid.pastePage(2, Math.round(selectionBox.originX/(square.width/32)), Math.round(selectionBox.originY/(square.width/32)), Math.round(selectionBox.endX/(square.width/32)), Math.round(selectionBox.endY/(square.width/32)))
                            displayGrid()
                        }
                        else
                        {
                            selectionBox.originX = ((Math.round(point1.x/(square.width/32)))*(square.width/32)); selectionBox.originY = (Math.round((point1.y/(square.height/32)))*(square.width/32))
                            selectionBox.x = selectionBox.originX; selectionBox.y = selectionBox.originY;
                            selectionBox.z = 100
                            selectionBox.placed = 0
                            selectionBox.width = 0; selectionBox.height = 0
                        }
                    }
                    else if (selectionBox.rotation == 90 && !(selectionBox.originX > point1.x && point1.x > (selectionBox.x - selectionBox.height) &&
                                                         selectionBox.originY < point1.y && point1.y < (selectionBox.originY + selectionBox.width)))
                    {
                        if (fillTool.altUse == 1)
                        {
                            changeMade()
                            LedGrid.copyPage(2, Math.round(selectionBox.originX/(square.width/32)), Math.round(selectionBox.originY/(square.width/32)), Math.round(selectionBox.endX/(square.width/32)), Math.round(selectionBox.endY/(square.width/32)))
                            LedGrid.fillBucket((point1.x/(square.width/32))|0, (point1.y/(square.height/32))|0)
                            LedGrid.pastePage(2, Math.round(selectionBox.originX/(square.width/32)), Math.round(selectionBox.originY/(square.width/32)), Math.round(selectionBox.endX/(square.width/32)), Math.round(selectionBox.endY/(square.width/32)))
                            displayGrid()
                        }
                        else
                        {
                        selectionBox.originX = ((Math.round(point1.x/(square.width/32)))*(square.width/32)); selectionBox.originY = (Math.round((point1.y/(square.height/32)))*(square.width/32))
                        selectionBox.x = selectionBox.originX; selectionBox.y = selectionBox.originY;
                        selectionBox.z = 100
                        selectionBox.placed = 0
                        selectionBox.width = 0; selectionBox.height = 0
                        }
                    }
                    else if (selectionBox.rotation == 180 && !(selectionBox.x > point1.x && point1.x > (selectionBox.x - selectionBox.width) &&
                                                               selectionBox.y > point1.y && point1.y > (selectionBox.y - selectionBox.height)))
                    {
                        if (fillTool.altUse == 1)
                        {
                            changeMade()
                            LedGrid.copyPage(2,Math.round(selectionBox.originX/(square.width/32)), Math.round(selectionBox.originY/(square.width/32)), Math.round(selectionBox.endX/(square.width/32)), Math.round(selectionBox.endY/(square.width/32)))
                            LedGrid.fillBucket((point1.x/(square.width/32))|0, (point1.y/(square.height/32))|0)
                            LedGrid.pastePage(2,Math.round(selectionBox.originX/(square.width/32)), Math.round(selectionBox.originY/(square.width/32)), Math.round(selectionBox.endX/(square.width/32)), Math.round(selectionBox.endY/(square.width/32)))
                            displayGrid()
                        }
                        else
                        {
                            selectionBox.originX = ((Math.round(point1.x/(square.width/32)))*(square.width/32)); selectionBox.originY = (Math.round((point1.y/(square.height/32)))*(square.width/32))
                            selectionBox.x = selectionBox.originX; selectionBox.y = selectionBox.originY;
                            selectionBox.z = 100
                            selectionBox.placed = 0
                            selectionBox.width = 0; selectionBox.height = 0
                        }
                    }
                    else if (selectionBox.rotation == 270 && !(selectionBox.x < point1.x && point1.x < (selectionBox.x + selectionBox.height) &&
                                                          selectionBox.y > point1.y && point1.y > (selectionBox.y - selectionBox.width)))
                    {
                        if (fillTool.altUse == 1)
                        {
                            changeMade()
                            LedGrid.copyPage(2, Math.round(selectionBox.originX/(square.width/32)), Math.round(selectionBox.originY/(square.width/32)), Math.round(selectionBox.endX/(square.width/32)), Math.round(selectionBox.endY/(square.width/32)))
                            LedGrid.fillBucket((point1.x/(square.width/32))|0, (point1.y/(square.height/32))|0)
                            LedGrid.pastePage(2, Math.round(selectionBox.originX/(square.width/32)), Math.round(selectionBox.originY/(square.width/32)), Math.round(selectionBox.endX/(square.width/32)), Math.round(selectionBox.endY/(square.width/32)))
                            displayGrid()
                        }
                        else
                        {
                            selectionBox.originX = ((Math.round(point1.x/(square.width/32)))*(square.width/32)); selectionBox.originY = (Math.round((point1.y/(square.height/32)))*(square.width/32))
                            selectionBox.x = selectionBox.originX; selectionBox.y = selectionBox.originY;
                            selectionBox.z = 100
                            selectionBox.placed = 0
                            selectionBox.width = 0; selectionBox.height = 0
                        }
                    }
                    else if (fillTool.altUse == 1)
                    {
                        changeMade()
                        LedGrid.fillBucket((point1.x/(square.width/32))|0, (point1.y/(square.height/32))|0, Math.round(selectionBox.originX/(square.width/32)), Math.round(selectionBox.originY/(square.width/32)), Math.round(selectionBox.endX/(square.width/32)), Math.round(selectionBox.endY/(square.width/32)))
                        displayGrid()
                    }
                }
            }
            onUpdated:
            {
                if((point1.x < square.width && point1.y < square.height) && (point1.x > 0 && point1.y > 0))
                {
                        if (square.selectedTool == "Pen")
                        {
                            LedGrid.ledPressed((point1.x/(square.width/32))|0, (point1.y/(square.height/32))|0)
                            repeater.itemAt((point1.x/(square.width/32))|0 + (point1.y/(square.height/32)|0)*32).color = LedGrid.getColor()
                        }
                        else if (square.selectedTool == "Move")
                        {
                            if (point1.pressed && point2.pressed)
                            {
                                var xRatio = Math.abs(point1.x - point2.x)/Math.abs(point1.startX - point2.startX)
                                var yRatio = Math.abs(point1.y - point2.y)/Math.abs(point1.startY - point2.startY)

                                if (yRatio > xRatio)
                                    xRatio = yRatio

                                if ((xRatio > 1 && squareScale.xScale < 3.05 ) || (xRatio < 1 && squareScale.xScale > .95))
                                {
                                    squareScale.xScale = xRatio * square.currentScale
                                    squareScale.yScale = xRatio * square.currentScale
                                }

                                square.startX = point1.x
                                square.startY = point1.y
                            }
                            else if (point1.pressed)
                            {
                                square.x = square.currentX + (point1.x - point1.startX);
                                square.y = square.currentY + (point1.y - point1.startY);
                            }
                        }
                }
                //update box look
                if (square.selectedTool == "BoxSelect")
                {
                    if (fillTool.altUse == 0)
                    {
                        if( selectionBox.placed == 0)
                        {
                            if (point1.x > selectionBox.x && point1.y > selectionBox.y)
                                selectionBox.rotation = 0
                            else if (point1.x < selectionBox.x && point1.y > selectionBox.y)
                                selectionBox.rotation = 90
                            else if (point1.x < selectionBox.x && point1.y < selectionBox.y)
                                selectionBox.rotation = 180
                            else if (point1.x > selectionBox.x && point1.y < selectionBox.y)
                                selectionBox.rotation = 270

                            if (selectionBox.rotation == 0 || selectionBox.rotation == 180)
                            {
                                selectionBox.width  = Math.abs(point1.x - selectionBox.x);
                                selectionBox.height = Math.abs(point1.y - selectionBox.y);
                            }
                            else
                            {
                                selectionBox.width  = Math.abs(point1.y - selectionBox.y);
                                selectionBox.height = Math.abs(point1.x - selectionBox.x);
                            }

                        }
                        else
                        {
                            selectionBox.x = selectionBox.originX + (point1.x - point1.startX);
                            selectionBox.y = selectionBox.originY + (point1.y - point1.startY);
                        }
                    }
                }
            }
            onReleased:
            {
                //creating a box
                if (square.selectedTool == "BoxSelect" && selectionBox.placed == 0)
                {
                    selectionBox.placed = 1
                    if (selectionBox.rotation == 0 || selectionBox.rotation == 180)
                    {
                        selectionBox.height = Math.abs((Math.round(point1.y/(square.height/32))*(square.height/32)) - selectionBox.y)
                        selectionBox.width  = Math.abs((Math.round(point1.x/(square.width/32)) *(square.width/32))  - selectionBox.x)
                    }
                    else
                    {
                        selectionBox.height = Math.abs((Math.round(point1.x/(square.width/32)) *(square.width/32))  - selectionBox.x)
                        selectionBox.width  = Math.abs((Math.round(point1.y/(square.height/32))*(square.height/32)) - selectionBox.y)
                    }
                }
                else
                {

                    selectionBox.x = (Math.round(selectionBox.x/(square.width/32))) *(square.width/32 )
                    selectionBox.y = (Math.round(selectionBox.y/(square.height/32)))*(square.height/32)

                    selectionBox.originX = selectionBox.x;
                    selectionBox.originY = selectionBox.y;
                }
                selectionBox.endX = ((selectionBox.rotation == 90 || selectionBox.rotation == 270) ? ((selectionBox.rotation == 90) ? (selectionBox.originX - selectionBox.height) : (selectionBox.height + selectionBox.originX))
                                                                                                   : (selectionBox.rotation == 0    ? (selectionBox.width + selectionBox.originX)  : (selectionBox.originX - selectionBox.width)));
                selectionBox.endY = ((selectionBox.rotation == 90 || selectionBox.rotation == 270) ? ((selectionBox.rotation == 90) ? (selectionBox.originY + selectionBox.width)  : (selectionBox.originY - selectionBox.width))
                                                                                                   : (selectionBox.rotation == 0    ? (selectionBox.originY + selectionBox.height) : (selectionBox.originY - selectionBox.height)));
                square.currentX = square.x
                square.currentY = square.y

                if (squareScale.xScale < 1)
                {
                    squareScale.xScale = 1
                    squareScale.yScale = 1
                    square.x = (Screen.width/2 - square.width/2)
                    square.y = topBar.height
                }

                if (squareScale.xScale > 3)
                {
                    squareScale.xScale = 3
                    squareScale.yScale = 3
                }
            }
        }

        //Individual LEDs
        Grid
        {
            id: gridLED
            anchors.fill: parent
            rows: 32
            columns: 32

            Repeater
            {
                id: repeater
                objectName: "LEDs"
                model: 1024

                Rectangle
                {
                    width: square.width/32
                    height: square.height/32
                    color: 'black'
                    radius: width*0.5
                }
            }
        }

    }

    //top bar
    Rectangle
    {
        id: topBar
        width: Screen.width
        height: Screen.height/11
        gradient: Gradient
        {
                 GradientStop { position: 0.0; color: Qt.rgba(.5,.5,.5,1) }
                 GradientStop { position: 1.0; color: Qt.rgba(.7,.7,.7,1) }
        }
        //Top Buttons
        Row
        {
            id:colorButtons
            spacing: 0

            Rectangle
            {
                id: colorButton0
                height: topBar.height
                width: topBar.width/6
                color: 'red'
                border.width: 10
                border.color: "#FFB01C"
                radius: width*.1
                property int colorUse0: 1;
                MouseArea
                {
                    anchors.fill: parent

                    onClicked:
                    {
                        if (colorButton0.colorUse0 == 0)
                        {
                            LedGrid.colorSelect(parent.color)
                            colorButton0.border.color = "#FFB01C"
                            colorButton1.border.color = 'black'
                            colorButton2.border.color = 'black'
                            colorButton3.border.color = 'black'
                            colorButton4.border.color = 'black'
                            colorButton5.border.color = 'black'
                            colorPicker.x = Screen.width*-1;
                            colorButton0.colorUse0 = 1;
                            colorButton1.colorUse1 = 0;
                            colorButton2.colorUse2 = 0;
                            colorButton3.colorUse3 = 0;
                            colorButton4.colorUse4 = 0;
                        }
                        else if (colorButton0.colorUse0 == 1)
                        {
                            colorPicker.x = 180;
                            colorButton0.colorUse0 = 2;
                        }
                        else
                        {
                            colorPicker.x = Screen.width*-1;
                            colorButton0.color = colorPicker.pickedColor;
                            colorButton0.colorUse0 = 1;
                            LedGrid.colorSelect(parent.color)
                        }
                    }
                }
            }

            Rectangle
            {
                id: colorButton1
                height: topBar.height
                width: topBar.width/6
                color: 'blue'
                radius: width*.1
                border.width: 10
                border.color: 'black'
                property int colorUse1: 0;
                MouseArea
                {
                    anchors.fill: parent

                    onClicked:
                    {
                        if (colorButton1.colorUse1 == 0)
                        {
                            LedGrid.colorSelect(parent.color)
                            colorButton0.border.color = 'black'
                            colorButton1.border.color = "#FFB01C"
                            colorButton2.border.color = 'black'
                            colorButton3.border.color = 'black'
                            colorButton4.border.color = 'black'
                            colorButton5.border.color = 'black'
                            colorPicker.x = Screen.width*-1;
                            colorButton0.colorUse0 = 0;
                            colorButton1.colorUse1 = 1;
                            colorButton2.colorUse2 = 0;
                            colorButton3.colorUse3 = 0;
                            colorButton4.colorUse4 = 0;

                        }
                        else if (colorButton1.colorUse1 == 1)
                        {
                            colorPicker.x = 180;
                            colorButton1.colorUse1 = 2;
                        }
                        else
                        {
                            colorPicker.x = Screen.width*-1;
                            colorButton1.color = colorPicker.pickedColor;
                            colorButton1.colorUse1 = 1;
                            LedGrid.colorSelect(parent.color)
                        }
                    }
                }
            }

            Rectangle
            {
                id: colorButton2
                height: topBar.height
                width: topBar.width/6
                color: 'green'
                radius: width*.1
                border.width: 10
                border.color: 'black'
                property int colorUse2: 0;
                MouseArea
                {
                    anchors.fill: parent

                    onClicked:
                    {
                        if (colorButton2.colorUse2 == 0)
                        {
                            LedGrid.colorSelect(parent.color)
                            colorButton0.border.color = 'black'
                            colorButton1.border.color = 'black'
                            colorButton2.border.color = "#FFB01C"
                            colorButton3.border.color = 'black'
                            colorButton4.border.color = 'black'
                            colorButton5.border.color = 'black'
                            colorPicker.x = Screen.width*-1;
                            colorButton0.colorUse0 = 0;
                            colorButton1.colorUse1 = 0;
                            colorButton2.colorUse2 = 1;
                            colorButton3.colorUse3 = 0;
                            colorButton4.colorUse4 = 0;
                        }
                        else if (colorButton2.colorUse2 == 1)
                        {
                            colorPicker.x = 180;
                            colorButton2.colorUse2 = 2;
                        }
                        else
                        {
                            colorPicker.x = Screen.width*-1;
                            colorButton2.color = colorPicker.pickedColor;
                            colorButton2.colorUse2 = 1;
                            LedGrid.colorSelect(parent.color)
                        }
                    }
                }
            }
            Rectangle
            {
                id: colorButton3
                height: topBar.height
                width: topBar.width/6
                color: 'yellow'
                radius: width*.1
                border.width: 10
                border.color: 'black'
                property int colorUse3: 0;
                MouseArea
                {
                    anchors.fill: parent

                    onClicked:
                    {
                        if (colorButton3.colorUse3 == 0)
                        {
                            LedGrid.colorSelect(parent.color)
                            colorButton0.border.color = 'black'
                            colorButton1.border.color = 'black'
                            colorButton2.border.color = 'black'
                            colorButton3.border.color = "#FFB01C"
                            colorButton4.border.color = 'black'
                            colorButton5.border.color = 'black'
                            colorPicker.x = Screen.width*-1;
                            colorButton0.colorUse0 = 0;
                            colorButton1.colorUse1 = 0;
                            colorButton2.colorUse2 = 0;
                            colorButton3.colorUse3 = 1;
                            colorButton4.colorUse4 = 0;

                        }
                        else if (colorButton3.colorUse3 == 1)
                        {
                            colorPicker.x = 180;
                            colorButton3.colorUse3 = 2;
                        }
                        else
                        {
                            colorPicker.x = Screen.width*-1;
                            colorButton3.color = colorPicker.pickedColor;
                            colorButton3.colorUse3 = 1;
                            LedGrid.colorSelect(parent.color)
                        }
                    }
                }
            }
            Rectangle
            {
                id: colorButton4
                height: topBar.height
                width: topBar.width/6
                color: 'orange'
                radius: width*.1
                border.width: 10
                border.color: 'black'
                property int colorUse4: 0;
                MouseArea
                {
                    anchors.fill: parent

                    onClicked:
                    {
                        if (colorButton4.colorUse4 == 0)
                        {
                            LedGrid.colorSelect(parent.color)
                            colorButton0.border.color = 'black'
                            colorButton1.border.color = 'black'
                            colorButton2.border.color = 'black'
                            colorButton3.border.color = 'black'
                            colorButton4.border.color = "#FFB01C"
                            colorButton5.border.color = 'black'
                            colorPicker.x = Screen.width*-1;
                            colorButton0.colorUse0 = 0;
                            colorButton1.colorUse1 = 0;
                            colorButton2.colorUse2 = 0;
                            colorButton3.colorUse3 = 0;
                            colorButton4.colorUse4 = 1;

                        }
                        else if (colorButton4.colorUse4 == 1)
                        {
                            colorPicker.x = 180;
                            colorButton4.colorUse4 = 2;
                        }
                        else
                        {
                            colorPicker.x = Screen.width*-1;
                            colorButton4.color = colorPicker.pickedColor;
                            colorButton4.colorUse4 = 1;
                            LedGrid.colorSelect(parent.color)
                        }
                    }
                }
            }
            Rectangle
            {
                id: colorButton5
                height: topBar.height
                width: topBar.width/6
                color: 'black'
                radius: width*.1
                border.width: 10
                border.color: 'black'
                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    {
                        LedGrid.colorSelect(parent.color)
                        colorButton0.border.color = 'black'
                        colorButton1.border.color = 'black'
                        colorButton2.border.color = 'black'
                        colorButton3.border.color = 'black'
                        colorButton4.border.color = 'black'
                        colorButton5.border.color = "#14DADE"
                        colorButton0.colorUse0 = 0;
                        colorButton1.colorUse1 = 0;
                        colorButton2.colorUse2 = 0;
                        colorButton3.colorUse3 = 0;
                        colorButton4.colorUse4 = 0;
                    }
                }
            }
        }
}




    //left most bar
    Rectangle
    {
        id: toolBar
        width: Screen.width/11
        height: Screen.height - topBar.height
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

             Rectangle{height: sideBar.height/10; width: sideBar.width; color: "transparent"}

             Rectangle
             {
                id: penTool
                height: sideBar.height/10
                width: sideBar.width
                radius: width*.1
                border.width: 10
                border.color: "#14DADE"
                Text{ text: "Pen"}
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
                height: sideBar.height/10
                width: sideBar.width
                radius: width*.1
                border.width: 10
                border.color: "black"
                property int altUse: 0
                Text{ text: "Fill"}
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
                height: sideBar.height/10
                width: sideBar.width
                radius: width*.1
                border.width: 10
                border.color: 'black'
                Text{ text: "BoxSelect"}
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
                height: sideBar.height/10
                width: sideBar.width
                radius: width*.1
                border.width: 10
                border.color: 'black'
                Text{ text: "Move"}
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
             Rectangle{height: sideBar.height/20; width: sideBar.width; color: "transparent"}
             Rectangle
             {
                id: save
                height: sideBar.height/10
                width: sideBar.width
                radius: width*.1
                border.width: 10
                border.color: 'black'

                Text{ text: "Save"}
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
                height: sideBar.height/10
                width: sideBar.width
                radius: width*.1
                border.width: 10
                border.color: 'black'

                Text{ text: "open"}
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
             /*
             Rectangle{height: sideBar.height/20; width: sideBar.width; color: "transparent"}
             Rectangle
             {
                id: connect
                height: sideBar.height/10
                width: sideBar.width
                radius: width*.1
                border.width: 10
                border.color: 'black'

                Text{ text: "Connect"}
                MouseArea
                {
                    anchors.fill:parent
                    onClicked:
                    {
                        //bluetooth connection
                    }
                }
             }
             Rectangle
             {
                id: send
                height: sideBar.height/10
                width: sideBar.width
                radius: width*.1
                border.width: 10
                border.color: 'black'

                Text{ text: "Send"}
                MouseArea
                {
                    anchors.fill:parent
                    onClicked:
                    {
                        //send bluetooth data
                    }
                }
             }
             */
        }
    }

    //right Side bar
    Rectangle
    {
        id: sideBar
        width: Screen.width/11
        height: Screen.height - topBar.height
        x: Screen.width - sideBar.width
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
             Rectangle{height: sideBar.height/15; width: sideBar.width; color: "transparent"}

             Button
             {
                id: clearButton
                height: sideBar.height/20
                width: sideBar.width
                text: "Clear"
                onClicked:
                {
                    LedGrid.clearBoard()

                    for(var i = 0; i < 1024;i++)
                        repeater.itemAt(i).color = 'black'
                }
             }
            //spacer
             Rectangle{height: sideBar.height/15; width: sideBar.width; color: "transparent"}
             Button
             {
                id: nextButton
                height: sideBar.height/20; width: sideBar.width
                text: "Next"
                onClicked:{flipPage(1);}
             }
             Button
             {
                id: prevButton
                height: sideBar.height/20; width: sideBar.width
                text: "Prev"
                onClicked:{flipPage(0)}
             }
            //spacer
            Rectangle{height: sideBar.height/15; width: sideBar.width; color: "transparent"}
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
                height: sideBar.height/20; width: sideBar.width
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
            Rectangle{height: sideBar.height/15; width: sideBar.width; color: "transparent"}
            Button
            {
                height: sideBar.height/20
                width: sideBar.width
                text: "Copy"
                onClicked:
                {
                    if (square.selectedTool == "BoxSelect")
                    {
                       LedGrid.copyPage(0,Math.round(selectionBox.originX/(square.width/32)), Math.round(selectionBox.originY/(square.width/32)), Math.round(selectionBox.endX/(square.width/32)), Math.round(selectionBox.endY/(square.width/32)))
                    }
                    else
                    {
                        LedGrid.copyPage()
                    }
                }
            }
            Button
            {
                height: sideBar.height/20
                width: sideBar.width
                text: "Paste"
                onClicked:
                {
                    if(LedGrid.getCopyFlag() > 0)
                    {
                        changeMade()
                        if (square.selectedTool == "BoxSelect")
                            LedGrid.pastePage(0,Math.round(selectionBox.originX/(square.width/32)), Math.round(selectionBox.originY/(square.width/32)), Math.round(selectionBox.endX/(square.width/32)), Math.round(selectionBox.endY/(square.width/32)))
                        else
                            LedGrid.pastePage()
                        displayGrid()
                    }

                }
            }

            Rectangle{height: sideBar.height/15; width: sideBar.width; color: "transparent"}
            Button
            {
                id: addButton
                height: sideBar.height/15; width: sideBar.width
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
                height: sideBar.height/15; width: sideBar.width
                text: "Delete"
                onClicked:
                {
                    LedGrid.deletePage()

                    displayGrid()
                    inputBox.text = LedGrid.getDuration()/1000
                }
            }
            Rectangle{height: sideBar.height/15; width: sideBar.width; color: "transparent"}
            Button
            {

                id: undoButton
                height: sideBar.height/15; width: sideBar.width
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

    ColorPicker{id:colorPicker; width:Screen.width*5/8; height: Screen.height*5/8; y:topBar.height+4; x:Screen.width*-1}
    FExplorer{id:fExplorer; x: Screen.width*-1}

    function displayGrid()
    {
        for(var i = 0; i < 1024;i++)
            repeater.itemAt(i).color = LedGrid.getLedColor(i);
    }

    function flipPage(dir)
    {
        if (LedGrid.getPages() > 1)
        {
            LedGrid.flipPage(dir)
            inputBox.text = LedGrid.getDuration()/1000
            for(var i = 0; i < 1024;i++)
                repeater.itemAt(i).color = LedGrid.getLedColor(i);
        }
        changeMade()
    }

    function changeMade()
    {
        LedGrid.copyPage(1);
        undoButton.redo = 0;
        //send bluetooth
    }
}




