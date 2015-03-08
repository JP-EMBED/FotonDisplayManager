import QtQuick 2.4

Rectangle
{
    property alias grid: repeater
    property alias selectionBox: selectionBox
    id: square
    property string selectedTool: "Pen"
    property real currentScale: 1
    property real startX: 0
    property real startY: 0
    property real currentX: square.x
    property real currentY: square.y
    width: parent.height - topBar.height
    height: square.width
    x: (parent.width/2 - square.width/2)
    y: topBar.height
    color: Qt.rgba(.7,.7,.7,1)
    transform: Scale { id: squareScale; origin.x: square.height/2; origin.y: square.width/2; xScale: 1; yScale: 1}

    //Selection Box
    Rectangle
    {
        id: selectionBox
        z: 2
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
        enabled: !colorPicker.visible
        touchPoints: [TouchPoint { id: point1 }, TouchPoint { id: point2 }]
        onPressed:
        {
            var x = point1.x/(square.width/32)
            var y = point1.y/(square.height/32)

            square.currentScale = squareScale.xScale

            //within square
            if((point1.x < square.width && point1.y < square.height) && (point1.x > 0 && point1.y > 0))
            {
                    if (square.selectedTool == "Pen")
                    {
                        var row = Math.floor(y);
                        var col = Math.floor(x);
                        changeMade();
                        FotonGrid.ledPressed(col, row);
                        LedBoardManager.sendLedSet(col, row);
                        repeater.itemAt(col + row*32).color = FotonGrid.getColor();
                    }
            }

            if (square.selectedTool == "Fill")
            {
                changeMade()
                FotonGrid.fillBucket(Math.floor(x), Math.floor(y))
                displayGrid()

            }
            else if (square.selectedTool == "BoxSelect")
            {
                var originX = Math.round(selectionBox.originX/(square.width/32))
                var originY = Math.round(selectionBox.originY/(square.width/32))
                var endX = Math.round(selectionBox.endX/(square.width/32))
                var endY = Math.round(selectionBox.endY/(square.width/32))

                if (selectionBox.rotation == 0 && !(selectionBox.x < point1.x && point1.x < (selectionBox.x + selectionBox.width) &&
                                                    selectionBox.y < point1.y && point1.y < (selectionBox.y + selectionBox.height)))
                {
                    if (toolBar.fillTool.altUse == 1)
                    {
                        changeMade();
                        FotonGrid.copyPage(2, originX, originY, endX, endY)
                        FotonGrid.fillBucket( Math.floor(x), Math.floor(y) )
                        FotonGrid.pastePage(2, originX, originY, endX, endY)
                        displayGrid()
                    }
                    else
                    {
                        selectionBox.originX = (Math.round(x)*(square.width/32))
                        selectionBox.originY = (Math.round(y)*(square.width/32))
                        selectionBox.x = selectionBox.originX; selectionBox.y = selectionBox.originY;
                        selectionBox.placed = 0
                        selectionBox.width = 0; selectionBox.height = 0
                    }
                }
                else if (selectionBox.rotation == 90 && !(selectionBox.originX > point1.x && point1.x > (selectionBox.x - selectionBox.height) &&
                                                     selectionBox.originY < point1.y && point1.y < (selectionBox.originY + selectionBox.width)))
                {
                    if (toolBar.fillTool.altUse == 1)
                    {
                        changeMade()
                        FotonGrid.copyPage(2, originX, originY, endX, endY)
                        FotonGrid.fillBucket( Math.floor(x), Math.floor(y))
                        FotonGrid.pastePage(2, originX, originY, endX, endY)
                        displayGrid()
                    }
                    else
                    {
                        selectionBox.originX = (Math.round(x)*(square.width/32));
                        selectionBox.originY = (Math.round(y)*(square.width/32))
                        selectionBox.x = selectionBox.originX; selectionBox.y = selectionBox.originY;
                        selectionBox.placed = 0
                        selectionBox.width = 0; selectionBox.height = 0
                    }
                }
                else if (selectionBox.rotation == 180 && !(selectionBox.x > point1.x && point1.x > (selectionBox.x - selectionBox.width) &&
                                                           selectionBox.y > point1.y && point1.y > (selectionBox.y - selectionBox.height)))
                {
                    if (toolBar.fillTool.altUse == 1)
                    {
                        changeMade()
                        FotonGrid.copyPage(2,originX, originY, endX, endY)
                        FotonGrid.fillBucket(Math.floor(x), Math.floor(y))
                        FotonGrid.pastePage(2,originX, originY, endX, endY)
                        displayGrid()
                    }
                    else
                    {
                        selectionBox.originX = (Math.round(x)*(square.width/32));
                        selectionBox.originY = (Math.round(y)*(square.width/32))
                        selectionBox.x = selectionBox.originX; selectionBox.y = selectionBox.originY;
                        selectionBox.placed = 0
                        selectionBox.width = 0; selectionBox.height = 0
                    }
                }
                else if (selectionBox.rotation == 270 && !(selectionBox.x < point1.x && point1.x < (selectionBox.x + selectionBox.height) &&
                                                      selectionBox.y > point1.y && point1.y > (selectionBox.y - selectionBox.width)))
                {
                    if (toolBar.fillTool.altUse == 1)
                    {
                        changeMade()
                        FotonGrid.copyPage(2, originX, originY, endX, endY)
                        FotonGrid.fillBucket(Math.floor(x), Math.floor(y))
                        FotonGrid.pastePage(2, originX, originY, endX, endY)
                        displayGrid()
                    }
                    else
                    {
                        selectionBox.originX = (Math.round(x)*(square.width/32));
                        selectionBox.originY = (Math.round(y)*(square.width/32))
                        selectionBox.x = selectionBox.originX; selectionBox.y = selectionBox.originY;
                        selectionBox.placed = 0
                        selectionBox.width = 0; selectionBox.height = 0
                    }
                }
                else if (toolBar.fillTool.altUse == 1)
                {
                    changeMade()
                    FotonGrid.fillBucket(Math.floor(x), Math.floor(y), originX, originY, endX, endY)
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
                        var row = Math.floor(point1.y/(square.height/32));
                        var col = Math.floor(point1.x/(square.height/32));
                        FotonGrid.ledPressed(col, row);
                        LedBoardManager.sendLedSet(col, row);
                        repeater.itemAt(col + row*32).color = FotonGrid.getColor();
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
                if (toolBar.fillTool.altUse == 0)
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
                        selectionBox.x = selectionBox.originX + (point1.x + -point1.startX);
                        selectionBox.y = selectionBox.originY + (point1.y + -point1.startY);
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
                square.x = (parent.width/2 - square.width/2)
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
