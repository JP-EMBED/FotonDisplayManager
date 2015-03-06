import QtQuick 2.4
import QtQuick.Controls 1.2
import "LedBoardView"
import "ConnectionMenu"
import "CameraView"

ApplicationWindow
{
    title: "F0T0N2"
    visible: true
    id: mainWindow
    width: ScreenWidth
    height: ScreenHeight


    LedBoardView{
        id:boardView

    }

    FindDeviceMenu{
        anchors.fill: parent

    }
    CameraView{
        id:camView
        width:  parent.width
        height: parent.height
        color: "black"
        x:0
        y:-(height)
    }
}
