import QtQuick 2.4
import "../../LedBoardView"
import QtQuick.Controls 1.2
Rectangle {
    id:colorCheckerTop
    width: ScreenWidth
    height:ScreenHeight
    color: "lightgrey"
    signal finished()
    LedGrid{id:colorCheckerSquare;
    anchors.centerIn: parent
    width: parent.height * .85
    height: width
    }
    Column{
        spacing: 40
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        RGBColorPicker{
            id:startColor
            label: "Starting Color"
        }
        RGBColorPicker{
            id:changeYAxis
            label: "Change X Color"
        }
        RGBColorPicker{
            id:changeXAxis
            label: "Change Y Color"
        }
    }
    Rectangle{
        height: 180
        width: 340
        border.color: "orange"
        color:"transparent"
        Rectangle{
            id: colorChecker
            width: parent.width * .85
            height: parent.height * .65
            color: "white"
            radius: 12
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.margins: 10
            Text{
                height:parent.height * .3
                width: parent.width * .85
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: colorChecker.bottom
                text: "Set Color To Board"
                color: "black"
                font.pixelSize: height *.85
                horizontalAlignment: Text.AlignHCenter

            }
        }

        radius: 12
        MouseArea{
            anchors.fill: parent
            onClicked:{
                var base_color = Qt.rgba(startColor.redValue,startColor.greenValue,startColor.blueValue);
                LedBoardManager.sendLedColor(base_color)
                LedBoardManager.sendLedSet(0,0)
                colorCheckerSquare.grid.itemAt(0).color = base_color


                for(var col = 1; col < 32; col++)
                {
                    var led_number = col
                    var next_color = Qt.rgba((startColor.redValue + (changeXAxis.redValue * col) /255 ),
                                             (startColor.greenValue + (changeXAxis.greenValue * col) /255 ),
                                             (startColor.blueValue + (changeXAxis.blueValue * col)/255) )
                    LedBoardManager.sendLedColor(next_color)
                    LedBoardManager.sendLedSet(col,0)
                    colorCheckerSquare.grid.itemAt(led_number).color =next_color
                }

                for(var row = 0; row < 32; row++ )
                {
                    for(var col2 = 0; col2 < 32; col2++)
                    {
                        led_number = (row * 32) + col2
                        next_color = Qt.rgba((startColor.redValue + (changeXAxis.redValue * row) + (changeYAxis.redValue * col2)   )/255,
                                                 (startColor.greenValue + (changeXAxis.greenValue * row) + (changeYAxis.greenValue * col2) )/255,
                                                 (startColor.blueValue + (changeXAxis.blueValue * row) + (changeYAxis.blueValue * col2) )/255 )
                        LedBoardManager.sendLedColor(next_color)
                        LedBoardManager.sendLedSet(col2,row)
                        colorCheckerSquare.grid.itemAt(led_number).color =next_color
                    }
                }
            }
        }
    }
    Rectangle{
        height: parent.height/10
        width: parent.width/10
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        color:"black"
        border.color: "orange"
        radius: 12
        Text{
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color:"white"
            font.pixelSize: parent.height * .55
            text:"Quit"
        }
        MouseArea{
            anchors.fill: parent
            onClicked:{
                finished();
            }
        }
    }
}

