import QtQuick 2.3
import QtQuick.Controls 1.2
Rectangle {
    //LED grid
    Rectangle
    {
        id: square
        width: ScreenHeight - topBar.height
        height: square.width
        x: ((ScreenWidth - sideBar.width)/2 - square.width/2)
        y: topBar.height
        color: Qt.rgba(.7,.7,.7,1)
        property color colorToSet: Qt.rgba(255,0,0,255)
        PinchArea
        {
            id: area
            anchors.fill: parent
            pinch.target: square
            pinch.minimumScale: 1
            pinch.maximumScale: 1.7
            pinch.dragAxis: Pinch.XAndYAxis
            pinch.minimumX: (-square.width/5)
            pinch.minimumY: (-square.height/5)
            pinch.maximumX: ScreenWidth - (square.width*.6)
            pinch.maximumY: ScreenHeight- (square.height*.6)
        }

        //Individual LEDs
        Grid
        {
            id: gridLED
            anchors.fill: square
            rows: 32
            columns: 32

            Repeater
            {
                model: 1024

                Rectangle
                {
                    width: square.width/32
                    height: square.height/32
                    color: 'blue'
                    radius: width*0.5
                    MouseArea
                    {
                        anchors.fill: parent
                        onPressed: {
                            parent.color = square.colorToSet;
                            //console.log("sending led @ Rx" + row + " Cx" + col);
                            LedBoardManager.sendLedSet(Math.floor(index/32), (index % 32), square.colorToSet);
                        }

                    }
                }
            }
        }

    }

    //top bar
    Rectangle
    {
        id: topBar
        width: ScreenWidth
        height: ScreenHeight/11
        gradient: Gradient
        {
                 GradientStop { position: 0.0; color: Qt.rgba(.5,.5,.5,1) }
                 GradientStop { position: 1.0; color: Qt.rgba(.7,.7,.7,1) }
        }
        //Top Buttons
        Row
        {
            anchors.horizontalCenter: parent
            spacing: 0

            Button
            {
                id: colorButton0
                height: topBar.height
                width: topBar.width/6
                text: "Red"
                onClicked: {
                    square.colorToSet = Qt.rgba(255,0,0,255);
                }
            }
            Button
            {
                id: colorButton1
                height: topBar.height
                width: topBar.width/6
                text: "Green"
                onClicked: {
                    square.colorToSet = Qt.rgba(0,255,0,255);
                }
            }
            Button
            {
                id: colorButton2
                height: topBar.height
                width: topBar.width/6
                text: "Blue"
                onClicked: {
                    square.colorToSet = Qt.rgba(0,0,255,255);
                }
            }
            Button
            {
                id: colorButton3
                height: topBar.height
                width: topBar.width/6
                text:"Yellow"
                onClicked: {
                    square.colorToSet = Qt.rgba(255,255,0,255);
                }
            }
            Button
            {
                id: colorButton4
                height: topBar.height
                width: topBar.width/6
                text: "color 5"
            }
            Button
            {
                id: colorButton5
                height: topBar.height
                width: topBar.width/6
                text: "color 6"
            }
        }
    }

    //side bar
    Rectangle
    {
        id: sideBar
        width: ScreenWidth/11
        height: ScreenHeight- topBar.height
        x: ScreenWidth - sideBar.width
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
             anchors.verticalCenter: parent
             spacing: 0

             Rectangle{height: sideBar.height/10; width: sideBar.width; color: "transparent"}

             Button
             {
                id: clearButton
                height: sideBar.height/10
                width: sideBar.width
                text: "Clear"
             }
             Rectangle{height: sideBar.height/10; width: sideBar.width; color: "transparent"}
             Button
             {
                id: nextButton
                height: sideBar.height/10; width: sideBar.width
                text: "Next"
             }
             Button
             {
                id: prevButton
                height: sideBar.height/10; width: sideBar.width
                text: "Prev"
             }
            Rectangle{height: sideBar.height/5; width: sideBar.width; color: "transparent"}
            Button
            {
                id: addButton
                height: sideBar.height/10; width: sideBar.width
                text: "Clear"
            }
            Button
            {

                id: deleteButton
                height: sideBar.height/10; width: sideBar.width
                text: "Delete"
            }

        }
    }

}
