import QtQuick 2.4

Rectangle {
    id:containerRect
    width: 400
    height: 250
    color:"transparent"
    clip:true
    property alias terminalEdit: terminalEdit
    Rectangle{
        id: titleBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height/14
        anchors.margins: 2
        border.color: "white"
        color:"darkgrey"
        Text{
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            text:" AT Command Output Display"
            font.pixelSize: parent.height * .8
            color: "white"
        }


    }

    Flickable{
        id: flickArea
        anchors.top:titleBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 4
        width: parent.width
        contentHeight: terminalEdit.height
        clip:true
        boundsBehavior: Flickable.DragOverBounds
        flickableDirection: Flickable.HorizontalAndVerticalFlick
        function ensureVisible(r)
        {
            if (contentX >= r.x)
                contentX = r.x;
            else if (contentX+width <= r.x+r.width)
                contentX = r.x+r.width-width;
            if (contentY >= r.y)
                contentY = r.y;
            else if (contentY+height <= r.y+r.height)
                contentY = r.y+r.height-height;
        }
        TextEdit{
            id: terminalEdit
            focus: true
            horizontalAlignment: TextEdit.AlignLeft
            verticalAlignment: TextEdit.AlignTop
            width: parent.width
            height: (lineCount * font.pixelSize) + containerRect.height
            wrapMode: TextEdit.WrapAtWordBoundaryOrAnywhere
            color: "lightgreen"
            font.pixelSize: 18
            onCursorRectangleChanged: flickArea.ensureVisible(cursorRectangle)
        }
        onFlickEnded: {
        /*    var r = visibleArea
            if (contentX >= r.x)
                contentX = r.x;
            else if (contentX+width <= r.x+r.width)
                contentX = r.x+r.width-width;
            if (contentY >= r.y)
                contentY = r.y;
            else if (contentY+height <= r.y+r.height)
                contentY = r.y+r.height-height;*/
        }
    }

}

