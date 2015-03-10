import QtQuick 2.4

Rectangle
{
    property alias grid: repeater
    property alias selectionBox: selectionBox
    id: square
    property string selectedTool: "Pen"
    property bool  selectionMode: false
    property real currentScale: 1
    property real startX: 0
    property real startY: 0
    property real currentX: square.x
    property real currentY: square.y
    property real pix_per_led:(square.width/32);
    width: parent.height - topBar.height
    height: square.width
    x: (parent.width/2 - square.width/2)
    y: topBar.height
    color: Qt.rgba(.7,.7,.7,1)
    border.width: 0
    transform: Scale { id: squareScale; origin.x: square.height/2; origin.y: square.width/2; xScale: 1; yScale: 1}

    //Selection Box

    MultiPointTouchArea
    {
        id: squareMultiTouch
        anchors.fill: parent
        maximumTouchPoints: 2
        enabled: !colorPicker.visible
        touchPoints: [TouchPoint { id: point1 }, TouchPoint { id: point2 }]
        property real moveStartX: 0
        property real moveStartY: 0
        onPressed:
        {
            var x = point1.x/(pix_per_led)
            var y = point1.y/(pix_per_led)

            square.currentScale = squareScale.xScale

            //within square
            var led_grid_mapped = mapToItem(gridLED, point1.x,point1.y)
            if(gridLED.contains(Qt.point(led_grid_mapped.x,led_grid_mapped.y)))
            {

                var selection_box_mapped = mapToItem(selectionBox, point1.x,point1.y);
                var originX = Math.round(selectionBox.originX/pix_per_led)
                var originY = Math.round(selectionBox.originY/pix_per_led)
                var endX = Math.round(selectionBox.endX/pix_per_led)
                var endY = Math.round(selectionBox.endY/pix_per_led)
                var row = Math.floor(y);
                var col = Math.floor(x);
                var inSelectionBox = selectionBox.contains(Qt.point(selection_box_mapped.x,selection_box_mapped.y));
                if(selectionMode)
                {
                    selectionBox.originX = (Math.round(x)*pix_per_led)
                    selectionBox.originY = (Math.round(y)*pix_per_led)
                    selectionBox.x = selectionBox.originX; selectionBox.y = selectionBox.originY;
                    selectionBox.width = 0;
                    selectionBox.height = 0
                }
                else if (square.selectedTool == "Pen")
                {
                    if(selectionBox.placed) // if Selection Box is Placed
                    {
                        // if the point is inside of the Selection Box
                        if(inSelectionBox)
                        {
                            FotonGrid.ledPressed(col, row);
                            LedBoardManager.sendLedSet(col, row);
                            repeater.itemAt(col + row*32).color = FotonGrid.getColor();
                        }
                    }
                    else // else just draw
                    {
                        changeMade();
                        FotonGrid.ledPressed(col, row);
                        LedBoardManager.sendLedSet(col, row);
                        repeater.itemAt(col + row*32).color = FotonGrid.getColor();
                    }
                }
                else if (square.selectedTool == "Fill")
                {
                    changeMade()
                    if(selectionBox.placed) // if Selection Box is Placed
                    {
                        if(inSelectionBox)
                        {
                            FotonGrid.fillBucket( Math.floor(x), Math.floor(y), originX, originY, endX, endY )
                        }
                        else
                        {
                            var led_count_w = Math.round(selectionBox.width/pix_per_led);
                            var led_count_h = Math.round(selectionBox.height/pix_per_led);
                            FotonGrid.fillBucketInverseSelect(row, col, Qt.rect(originX,originY,led_count_w,led_count_h) )
                        }
                    }
                    else
                    {
                        FotonGrid.fillBucket(Math.floor(x), Math.floor(y))
                    }
                    for (var i = 0; i < 1024; ++i)
                        repeater.itemAt(i).color = FotonGrid.getLedColor(i);
                }
                else if (square.selectedTool == "Move")
                {


                    squareMultiTouch.moveStartX = point1.x;
                    squareMultiTouch.moveStartY = point1.y;
                }
            }
        }
        onUpdated:
        {
            var led_grid_mapped = mapToItem(gridLED, point1.x,point1.y)
            if(gridLED.contains(Qt.point(led_grid_mapped.x,led_grid_mapped.y)))
            {
                var selection_box_mapped = mapToItem(selectionBox, point1.x,point1.y);
                var row = Math.floor(point1.y/(square.height/32));
                var col = Math.floor(point1.x/(square.height/32));
                var inSelectionBox = selectionBox.contains(Qt.point(selection_box_mapped.x,selection_box_mapped.y));
                if(selectionMode) // If defining down selection area
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
                else if (square.selectedTool == "Pen") // else if using pen
                {
                    if(selectionBox.placed == 1)
                    {

                        if(inSelectionBox)
                        {
                            FotonGrid.ledPressed(col, row);
                            LedBoardManager.sendLedSet(col, row);
                            repeater.itemAt(col + row*32).color = FotonGrid.getColor();
                        }
                    }
                    else
                    {
                        FotonGrid.ledPressed(col, row);
                        LedBoardManager.sendLedSet(col, row);
                        repeater.itemAt(col + row*32).color = FotonGrid.getColor();
                    }
                }
                else if (square.selectedTool == "Move") // else if moving
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
                        square.x = square.currentX + (point1.x - squareMultiTouch.moveStartX);
                        square.y = square.currentY + (point1.y - squareMultiTouch.moveStartY);
                    }
                }
            }

        }
        onReleased:
        {
            //creating a box
            if (selectionMode)
            {
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
                selectionMode = false
                selectionBox.placed = 1;
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
    Rectangle
    {
        id: selectionBox
        color: "#00000000"
        border.width: 10
        border.color: 'white'
        property real originX: 0
        property real originY: 0
        property real endX: 0
        property real endY: 0
        property int placed: 0
        property alias dragArea: dragArea
        transformOrigin: Item.TopLeft
        MouseArea{
            id: dragArea
            enabled: true
            anchors.fill: parent
            drag.target: selectionBox
            drag.axis: Drag.XAndYAxis
            drag.minimumX: 0
            drag.minimumY: 0
            drag.maximumX: square.x +square.width
            drag.maximumY: square.y +square.height
            onPressed: {mouse.accepted = true; squareMultiTouch.enabled = false;}
            onReleased:{
                squareMultiTouch.enabled = true;
                selectionBox.originX = Math.round(selectionBox.x/pix_per_led)
                selectionBox.originY = Math.round(selectionBox.y/pix_per_led)


                selectionBox.x = selectionBox.originX *pix_per_led
                selectionBox.y  = selectionBox.originY *pix_per_led
                selectionBox.originX = selectionBox.x
                selectionBox.originY = selectionBox.y
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
    }
}
